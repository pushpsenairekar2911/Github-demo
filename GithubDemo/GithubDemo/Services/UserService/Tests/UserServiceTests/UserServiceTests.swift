//
//  UserServiceTests.swift
//  UserService
//
//  Created by Pushpsen Airekar on 25/05/25.
//

import XCTest
@testable import UserService
import Combine

// MARK: - UserServiceTests
final class UserServiceTests: XCTestCase {
    
    var mockNetworkService: MockNetworkService!
    var userService: UserService!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        mockNetworkService = MockNetworkService()
        userService = UserService(networkService: mockNetworkService)
        cancellables = []
    }
    
    override func tearDown() {
        cancellables = nil
        userService = nil
        mockNetworkService = nil
        super.tearDown()
    }
    
    // MARK: - fetchUsers
    
    func testFetchUsersSuccess() {
        let expectedUsers = [
            GHUser(
                login: "john",
                id: 1,
                nodeID: "MDQ6VXNlcjE=",
                avatarURL: "https://avatars.githubusercontent.com/u/1?v=4",
                gravatarID: "",
                url: "https://api.github.com/users/john",
                htmlURL: "https://github.com/john",
                followersURL: "https://api.github.com/users/john/followers",
                followingURL: "https://api.github.com/users/john/following{/other_user}",
                gistsURL: "https://api.github.com/users/john/gists{/gist_id}",
                starredURL: "https://api.github.com/users/john/starred{/owner}{/repo}",
                subscriptionsURL: "https://api.github.com/users/john/subscriptions",
                organizationsURL: "https://api.github.com/users/john/orgs",
                reposURL: "https://api.github.com/users/john/repos",
                eventsURL: "https://api.github.com/users/john/events{/privacy}",
                receivedEventsURL: "https://api.github.com/users/john/received_events",
                type: "User",
                userViewType: "default",
                siteAdmin: false
            )
        ]
        mockNetworkService.responseData = expectedUsers
        
        let expectation = self.expectation(description: "Users fetched")
        
        userService.fetchUsers()
            .sink(receiveCompletion: { _ in },
                  receiveValue: { users in
                XCTAssertEqual(users.count, 1)
                XCTAssertEqual(users.first?.login, "john")
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 2)
    }
    
    func testFetchUsersFailure() {
        mockNetworkService.error = URLError(.notConnectedToInternet)
        
        let expectation = self.expectation(description: "Users fetch failed")
        
        userService.fetchUsers()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTAssertTrue(error is URLError)
                    expectation.fulfill()
                }
            }, receiveValue: { _ in
                XCTFail("Should not receive users on failure")
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 2)
    }
    
    // MARK: - fetchUserDetails
    
    func testFetchUserDetailsSuccess() {
        let expectedDetail = GHUserDetail(
            login: "jane",
            id: 2,
            nodeID: "MDQ6VXNlcjI=",
            avatarURL: "https://avatars.githubusercontent.com/u/2?v=4",
            gravatarID: nil,
            url: "https://api.github.com/users/jane",
            htmlURL: "https://github.com/jane",
            followersURL: "https://api.github.com/users/jane/followers",
            followingURL: "https://api.github.com/users/jane/following{/other_user}",
            gistsURL: "https://api.github.com/users/jane/gists{/gist_id}",
            starredURL: "https://api.github.com/users/jane/starred{/owner}{/repo}",
            subscriptionsURL: "https://api.github.com/users/jane/subscriptions",
            organizationsURL: "https://api.github.com/users/jane/orgs",
            reposURL: "https://api.github.com/users/jane/repos",
            eventsURL: "https://api.github.com/users/jane/events{/privacy}",
            receivedEventsURL: "https://api.github.com/users/jane/received_events",
            type: "User",
            siteAdmin: false,
            name: "Jane Doe",
            company: "GitHub",
            blog: "https://janedoe.dev",
            location: "San Francisco",
            email: "jane@example.com",
            hireable: true,
            bio: "iOS Engineer",
            twitterUsername: "jane_github",
            publicRepos: 42,
            publicGists: 7,
            followers: 100,
            following: 50,
            createdAt: "2020-01-01T00:00:00Z",
            updatedAt: "2024-12-31T23:59:59Z"
        )
        mockNetworkService.responseData = expectedDetail
        
        let expectation = self.expectation(description: "User details fetched")
        
        userService.fetchUserDetails(userName: "jane")
            .sink(receiveCompletion: { _ in },
                  receiveValue: { detail in
                XCTAssertEqual(detail.login, "jane")
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 2)
    }
    
    func testFetchUserDetailsFailure() {
        mockNetworkService.error = URLError(.timedOut)
        
        let expectation = self.expectation(description: "User detail fetch failed")
        
        userService.fetchUserDetails(userName: "jane")
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTAssertTrue(error is URLError)
                    expectation.fulfill()
                }
            }, receiveValue: { _ in
                XCTFail("Should not receive user details on failure")
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 2)
    }
    
    // MARK: - fetchUserRepos
    
    func testFetchUserReposSuccess() {
        let license = GHLicense(
            key: "mit",
            name: "MIT License",
            spdx_id: "MIT",
            url: "https://api.github.com/licenses/mit",
            node_id: "MDc6TGljZW5zZW1pdA=="
        )
        
        let owner = GHUser(
            login: "john",
            id: 1,
            nodeID: "MDQ6VXNlcjE=",
            avatarURL: "https://avatars.githubusercontent.com/u/1?v=4",
            gravatarID: "",
            url: "https://api.github.com/users/john",
            htmlURL: "https://github.com/john",
            followersURL: "https://api.github.com/users/john/followers",
            followingURL: "https://api.github.com/users/john/following{/other_user}",
            gistsURL: "https://api.github.com/users/john/gists{/gist_id}",
            starredURL: "https://api.github.com/users/john/starred{/owner}{/repo}",
            subscriptionsURL: "https://api.github.com/users/john/subscriptions",
            organizationsURL: "https://api.github.com/users/john/orgs",
            reposURL: "https://api.github.com/users/john/repos",
            eventsURL: "https://api.github.com/users/john/events{/privacy}",
            receivedEventsURL: "https://api.github.com/users/john/received_events",
            type: "User",
            userViewType: "default",
            siteAdmin: false
        )
        
        let expectedRepos = [
            GHRepo(
                id: 101,
                node_id: "MDEwOlJlcG9zaXRvcnkxMDE=",
                name: "awesome-project",
                full_name: "john/awesome-project",
                owner: owner,
                private: false,
                html_url: "https://github.com/john/awesome-project",
                description: "An awesome SwiftUI project",
                fork: false,
                url: "https://api.github.com/repos/john/awesome-project",
                created_at: "2021-01-01T00:00:00Z",
                updated_at: "2024-12-01T00:00:00Z",
                pushed_at: "2024-12-20T00:00:00Z",
                homepage: "https://awesomeproject.dev",
                size: 2048,
                stargazers_count: 150,
                watchers_count: 150,
                language: "Swift",
                forks_count: 30,
                open_issues_count: 2,
                license: license,
                default_branch: "main"
            )
        ]
        mockNetworkService.responseData = expectedRepos
        
        let expectation = self.expectation(description: "User repos fetched")
        
        userService.fetchUserRepos(userName: "jane")
            .sink(receiveCompletion: { _ in },
                  receiveValue: { repos in
                XCTAssertEqual(repos.count, 1)
                XCTAssertEqual(repos.first?.name, "SampleRepo")
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 2)
    }
    
    func testFetchUserReposFailure() {
        mockNetworkService.error = URLError(.cannotFindHost)
        
        let expectation = self.expectation(description: "User repos fetch failed")
        
        userService.fetchUserRepos(userName: "jane")
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTAssertTrue(error is URLError)
                    expectation.fulfill()
                }
            }, receiveValue: { _ in
                XCTFail("Should not receive repos on failure")
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 2)
    }
}
