//
//  UserService.swift
//  UserService
//
//  Created by Pushpsen Airekar on 23/05/25.
//

import GHNetworkingService
import Foundation
import Combine

// UserService implementation
public class UserService: UserServiceInterface {
    
    private let networkService: GHNetworkServiceInterface

    public init(
        networkService: GHNetworkServiceInterface
    ) {
        self.networkService = networkService
    }
    
    // MARK :- Fetch Users
    func internalFetchUsers() async throws -> [GHUser] {
        let endPoint = GHNetworkServiceEndpointBuilder()
            .setMethod(.get)
            .setBaseURL(.baseURL)
            .setPath(.getUsers)
            .build()
        let response: [GHUser] = try await networkService.request(endPoint: endPoint, retries: 1)
        return response
    }
    
    public func fetchUsers() -> AnyPublisher<[GHUser], any Error> {
        Future { promise in
            Task {
                do {
                    let results = try await self.internalFetchUsers()
                    promise(.success(results))
                } catch {
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    // MARK :- Fetch User details
    func internalFetchUserDetails(userName: String) async throws -> GHUserDetail {
        let endPoint = GHNetworkServiceEndpointBuilder()
            .setMethod(.get)
            .setBaseURL(.baseURL)
            .setPath(.getUserDetails(userName: userName))
            .build()
        let response: GHUserDetail = try await networkService.request(endPoint: endPoint, retries: 1)
        return response
    }
    
    public func fetchUserDetails(userName: String) -> AnyPublisher<GHUserDetail, any Error> {
        Future { promise in
            Task {
                do {
                    let results = try await self.internalFetchUserDetails(
                        userName: userName
                    )
                    promise(.success(results))
                } catch {
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    // MARK :- Fetch User respos
    func internalFetchUserRepos(
        userName: String
    ) async throws -> [GHRepo] {
        let endPoint = GHNetworkServiceEndpointBuilder()
            .setMethod(.get)
            .setBaseURL(.baseURL)
            .setPath(.getUserRepos(userName: userName))
            .build()
        let response: [GHRepo] = try await networkService.request(endPoint: endPoint, retries: 1)
        return response
    }
    
    public func fetchUserRepos(
        userName: String
    ) -> AnyPublisher<[GHRepo], any Error> {
        Future { promise in
            Task {
                do {
                    let results = try await self.internalFetchUserRepos(
                        userName: userName
                    )
                    promise(.success(results))
                } catch {
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
