//
//  AppRouter.swift
//  Github-Demo
//
//  Created by Pushpsen Airekar on 25/05/25.
//

import SwiftUI
import UserService
import GHNetworkingService

protocol RouteHandler {
    func view(for route: Route) -> AnyView?
}

enum Route: Hashable {
    case users
    case userDetails(userName: String)
    case userRepos(userName: String)
    case openURL(url: URL)
}

final class AppRouter: ObservableObject {
    
    // MARK: - Published Properties
    @Published var path = NavigationPath()

    // MARK: - Dependencies
    // Lazy initialization of userService
       lazy var userService: UserService = {
           return UserService(networkService: GHNetworkService(token: SecretsManager.githubToken))
       }()
    // MARK: - Navigation Methods

    /// Navigates to the User Details screen
    func goToUsers() {
        path.append(Route.users)
    }
    
    /// Navigates to the User Details screen
    func goToUserDetails(userName: String) {
        path.append(Route.userDetails(userName: userName))
    }

    /// Navigates to the User Repositories screen
    func goToUserRepos(userName: String) {
        path.append(Route.userRepos(userName: userName))
    }
    
    /// Opens URL in external browser
    func openURL(url: URL) {
        UIApplication.shared.open(url)
    }

    /// Navigates back by one screen
    func goBack() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }

    /// Navigates back to the root view
    func goToRoot() {
        path.removeLast(path.count)
    }
}
