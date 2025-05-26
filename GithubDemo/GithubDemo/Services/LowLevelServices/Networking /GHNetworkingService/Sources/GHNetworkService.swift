//
//  GHNetworkService.swift
//  GHNetworkService
//
//  Created by Pushpsen Airekar on 23/05/25.
//

import Foundation

public class GHNetworkService: GHNetworkServiceInterface {
    
    private var session: URLSession
    private let decoder: JSONDecoder
    private let token: String?
    
    public init(
        urlSession: URLSession = .shared,
        decoder: JSONDecoder = JSONDecoder(),
        token: String? = nil
    ) {
        self.session = urlSession
        self.decoder = decoder
        self.token = token
    }
    
    public func request<T: Decodable>(
        endPoint: GHEndPoint,
        retries: Int = 3
    ) async throws -> T {
        guard let url = endPoint.url else {
            throw GHNetworkError.invalidURL
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endPoint.method.rawValue
        urlRequest.timeoutInterval = 30
        
        endPoint.paramters?.forEach { key, value in
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        
        if let token = token {
            urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        do {
            let (data, response) = try await executeRequest(urlRequest, remainingRetries: retries)
            return try decode(data: data, response: response)
        } catch {
            throw handleError(error)
        }
    }
    
    private func executeRequest(_ request: URLRequest, remainingRetries: Int) async throws -> (Data, URLResponse) {
        do {
            return try await session.data(for: request)
        } catch {
            if remainingRetries > 0 {
                try await Task.sleep(nanoseconds: 1_000_000_000) // 1 second delay
                return try await executeRequest(request, remainingRetries: remainingRetries - 1)
            }
            throw error
        }
    }
    
    private func decode<T: Decodable>(data: Data, response: URLResponse) throws -> T {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw GHNetworkError.invalidResponse
        }
        
        switch httpResponse.statusCode {
        case 200...299:
            do {
                return try decoder.decode(T.self, from: data)
            } catch {
                throw GHNetworkError.decodingError
            }
        default:
            throw GHNetworkError.serverError(httpResponse.statusCode)
        }
    }
    
    private func handleError(_ error: Error) -> Error {
        if let networkError = error as? GHNetworkError {
            return networkError
        }
        return GHNetworkError.unknown
    }
}
