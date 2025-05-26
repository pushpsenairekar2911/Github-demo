//
//  UserReposViewModel.swift
//  Github-Demo
//
//  Created by Pushpsen Airekar on 24/05/25.
//

import SwiftUI
import Combine
import UserService

open class UserReposViewModel: ObservableObject {
    // Published state for the view to observe
    @Published var presentationObject: UserReposPresentationObject = .initialValue
    
    private let userService: UserServiceInterface
    private let userName : String
    
    private var cancellables: Set<AnyCancellable> = []
    
    // Raw repo data from service
    private var repos: [GHRepo]? {
        didSet {
            makePresentationObject()
        }
    }
    
    // Initialize with userName and service dependency
    init(userName: String,
         userService: UserServiceInterface) {
        self.userName = userName
        self.userService = userService
        
        Task(priority: .high) {
            setupSubscriptions()
        }
        makePresentationObject()
    }
    
    // Subscribe to repo fetch and update state accordingly
    private func setupSubscriptions() {
        userService.fetchUserRepos(userName: userName)
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    if case .failure = completion {
                        self?.performFailure()
                    }
                },
                receiveValue: { [weak self] repos in
                    self?.repos = repos
                }
            )
            .store(in: &cancellables)
    }
    
    // Handle failure by updating state
    func performFailure() {
        self.presentationObject = .init(state: .failed)
    }
    
    @MainActor
    private func didCompleteSubscriptions(subscriptions: Set<AnyCancellable>) {
        self.cancellables = subscriptions
    }
}

// MARK: - Presentation object transformation

extension UserReposViewModel {
    
    private func makePresentationObject() {
        guard let repos = repos, !repos.isEmpty else {
            presentationObject =  UserReposPresentationObject(state: .loading)
            return
        }
        
        let reposPo = repos.map { getRepositoryPo(repo: $0) }
        
        presentationObject =  UserReposPresentationObject(state: .loaded(
            repos: reposPo
        ))
    }
    
    private func getRepositoryPo(repo: GHRepo) -> Repository {
        Repository(
            id: repo.id,
            title: repo.name,
            description: repo.description,
            language: repo.language,
            stars: repo.stargazers_count,
            url: URL(string: repo.html_url)
        )
    }
}
