//
//  GHRepo.swift
//  UserService
//
//  Created by Pushpsen Airekar on 23/05/25.
//

public struct GHRepo: Identifiable, Equatable, Decodable, Sendable {
    public let id: Int
    public let node_id: String
    public let name: String
    public let full_name: String
    public let owner: GHUser
    public let `private`: Bool
    public let html_url: String
    public let description: String?
    public let fork: Bool
    public let url: String
    public let created_at: String
    public let updated_at: String
    public let pushed_at: String
    public let homepage: String?
    public let size: Int
    public let stargazers_count: Int
    public let watchers_count: Int
    public let language: String?
    public let forks_count: Int
    public let open_issues_count: Int
    public let license: GHLicense?
    public let default_branch: String
}

public struct GHLicense: Decodable, Equatable, Sendable {
    public let key: String
    public let name: String
    public let spdx_id: String
    public let url: String?
    public let node_id: String
}
