//
//  GithubDemoApp.swift
//  Github-Demo
//
//  Created by Pushpsen Airekar on 23/05/25.
//

import SwiftUI
import UserService
import GHNetworkingService

/// Entry point for the GitHub Demo SwiftUI application.
@main
struct GithubDemoApp: App {
    
    /// Global app router for navigation and state management
    @StateObject var router = AppRouter()
    
    /// Shared instance of `UserService`, initialized with a network service and GitHub token
    let userService = UserService(
        networkService: GHNetworkService(
            token: SecretsManager.githubToken
        )
    )

    var body: some Scene {
        // Coordinator that routes between user detail and user repos views
        let coordinator = RouterCoordinator(
            handlers: [
                UserDetailsRouter(userService: userService),
                UserReposRouter(userService: userService)
            ]
        )
        
        // Inject user service into the global router
        router.userService = userService

        return WindowGroup {
            RootView(coordinator: coordinator)
                .environmentObject(router)
        }
    }
}
