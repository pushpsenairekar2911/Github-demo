//
//  UsersViewModel.swift
//  Github-Demo
//
//  Created by Pushpsen Airekar on 23/05/25.
//

import Combine
import Foundation
import UserService
import GHKit

open class UsersViewModel: ObservableObject {
    
    @Published var presentationObject: UsersPresentationObject = .init(state: .loading)
    @Published var searchText = ""
    
    /// Filtered users based on searchText and loaded users
    @Published private(set) var filteredUsers: [User] = []
    
    private let userService: UserServiceInterface
    private var users: [User] = []
    private var cancellables: Set<AnyCancellable> = []

    // Initialization with data fetching and filtering setup
    init(userService: UserServiceInterface) {
        self.userService = userService
        
        setupSubscriptions()
        setupFiltering()
        makePresentationObject()
    }
    
    // Fetch users from service and update state
    private func setupSubscriptions() {
        userService.fetchUsers()
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    if case .failure = completion {
                        self?.performFailure()
                    }
                },
                receiveValue: { [weak self] ghUsers in
                    guard let self = self else { return }
                    let mappedUsers = ghUsers.map { self.getUserPo(user: $0) }
                    self.users = mappedUsers
                    self.presentationObject = .init(state: .loaded(users: mappedUsers))
                }
            )
            .store(in: &cancellables)
    }
    
    // Combine searchText and loaded users to compute filteredUsers reactively
    private func setupFiltering() {
        Publishers.CombineLatest($searchText, $presentationObject)
            .map { [weak self] (searchText, presentationObject) -> [User] in
                guard let self = self else { return [] }
                guard case let .loaded(users) = presentationObject.state else { return [] }
                if searchText.isEmpty {
                    return users
                } else {
                    return users.filter {
                        $0.name.lowercased().contains(searchText.lowercased())
                    }
                }
            }
            .receive(on: DispatchQueue.main)
            .assign(to: &$filteredUsers)
    }

    func performFailure() {
        self.presentationObject = .init(state: .failed)
        self.filteredUsers = []
    }
    
    // Set presentation state according to users availability
    private func makePresentationObject() {
        if users.isEmpty {
            presentationObject = UsersPresentationObject(state: .loading)
        } else {
            presentationObject = UsersPresentationObject(state: .loaded(users: users))
        }
    }
    
    private func getUserPo(user: GHUser) -> User {
        .init(
            name: user.login,
            imageUrl: .remote(url: user.avatarURL)
        )
    }
}
