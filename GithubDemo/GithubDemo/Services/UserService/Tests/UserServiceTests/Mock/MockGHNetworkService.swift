//
//  MockNetworkService.swift
//  UserService
//
//  Created by Pushpsen Airekar on 25/05/25.
//

import Foundation
import Combine
@testable import UserService
import XCTest
import GHNetworkingService

class MockNetworkService: GHNetworkServiceInterface {
    var responseData: Any?
    var error: Error?

    func request<T: Decodable>(endPoint: GHEndPoint, retries: Int) async throws -> T {
        if let error = error {
            throw error
        }
        guard let data = responseData as? T else {
            throw URLError(.badServerResponse)
        }
        return data
    }
}
