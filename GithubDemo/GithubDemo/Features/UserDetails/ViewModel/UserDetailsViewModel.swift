//
//  UserDetailsViewModel.swift
//  Github-Demo
//
//  Created by Pushpsen Airekar on 23/05/25.
//

import Combine
import Foundation
import UserService
import GHKit

open class UserDetailsViewModel: ObservableObject {
    
    @Published var presentationObject: UserDetailsPresentationObject = .init(state: .loading)
    @Published var searchText = ""
    
    private let userService: UserServiceInterface
    private let userName: String
    
    private var userDetails: GHUserDetail? {
        didSet {
            makePresentationObject()
        }
    }
    
    private var cancellables: Set<AnyCancellable> = []

    // MARK: - Initialization
    
    init(userName: String,
         userService: UserServiceInterface) {
        self.userName = userName
        self.userService = userService
        
        Task(priority: .high) {
            setupSubscriptions()
        }
        
        makePresentationObject()
    }
    
    // MARK: - Private methods
    
    private func setupSubscriptions() {
        userService.fetchUserDetails(userName: userName)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    if case .failure = completion {
                        self?.performFailure()
                    }
                },
                receiveValue: { [weak self] userDetails in
                    self?.userDetails = userDetails
                }
            )
            .store(in: &cancellables)
    }

    func performFailure() {
        self.presentationObject = .init(state: .failed)
    }
    
    private func makePresentationObject() {
        guard let userDetails = userDetails else {
            presentationObject = UserDetailsPresentationObject(state: .loading)
            return
        }
        let userDetailsPo = getUserDetailPo(user: userDetails)
        
        presentationObject = UserDetailsPresentationObject(state: .loaded(user: userDetailsPo))
    }
    
    private func getUserDetailPo(user: GHUserDetail) -> UserDetails {
        return .init(
            login: user.login,
            name: user.name ?? "",
            followers: user.followers,
            following: user.following,
            repos: user.publicRepos,
            bio: user.bio ?? "",
            company: user.company ?? "",
            address: user.location ?? "",
            imageUrl: .remote(url: user.avatarURL),
            followingURL: user.followingURL,
            followersURL: user.followersURL,
            starredURL: user.starredURL,
            organizationsURL: user.organizationsURL
        )
    }
}
