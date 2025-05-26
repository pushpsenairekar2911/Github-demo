//
//  GHNetworkServiceInterface.swift
//  GHNetworkingService
//
//  Created by Pushpsen Airekar on 23/05/25.
//


import Foundation

public protocol GHNetworkServiceInterface {
    func request<T: Decodable>(endPoint: GHEndPoint, retries: Int) async throws -> T
}

public enum GHNetworkError: Error {
    case invalidURL
    case invalidResponse
    case decodingError
    case serverError(Int)
    case unknown
}

// MARK: - METHOD'S TYPE
public enum GHHTTPMethod: String {
    case get = "GET"
}

// MARK: - BASE URL
public enum GHBaseURL: String {
    case baseURL = "api.github.com"
}


// MARK: - PATH
public enum GHAPIPath {
    case getUsers
    case getUserDetails(userName: String)
    case getUserRepos(userName: String)

    var path: String {
        switch self {
        case .getUsers:
            return "/users"
        case .getUserDetails(let userName):
            return "/users/\(userName)"
        case .getUserRepos(let userName):
            return "/users/\(userName)/repos"
        }
    }
}

public protocol GHEndPoint {

    var path: GHAPIPath { get set }
    var method: GHHTTPMethod { get set }
    var baseURL: GHBaseURL { get set }
    var paramters: [String: String]? { get set }
    var url: URL? { get }
}

public struct GHEndPointImplmentation: GHEndPoint {

    public var path: GHAPIPath = .getUsers
    public var method: GHHTTPMethod = .get
    public var baseURL: GHBaseURL = .baseURL
    public var paramters: [String : String]?

    public var url: URL? {

        var components = URLComponents()
        components.scheme = "https"
        components.host = baseURL.rawValue
        components.path = path.path
        components.queryItems = paramters?.map { URLQueryItem(name: $0.key, value: $0.value )}
        return components.url
    }
}
