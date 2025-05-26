//
//  UserServiceInterface.swift
//  UserService
//
//  Created by Pushpsen Airekar on 23/05/25.
//

import Combine

public protocol UserServiceInterface {
    
    func fetchUsers() -> AnyPublisher<[GHUser], Error>
    
    func fetchUserDetails(userName: String) -> AnyPublisher<GHUserDetail, Error>
    
    func fetchUserRepos(userName: String) -> AnyPublisher<[GHRepo], Error>
}
