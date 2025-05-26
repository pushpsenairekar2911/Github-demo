//
//  RepoRouteHandler.swift
//  Github-Demo
//
//  Created by Pushpsen Airekar on 25/05/25.
//

import UserService
import SwiftUI

struct UserReposRouter: RouteHandler {
    let userService: UserService

    func view(for route: Route) -> AnyView? {
        switch route {
        case .userRepos(let userName):
            let viewModel = UserReposViewModel(userName: userName, userService: userService)
            return AnyView(UserReposView(viewModel: viewModel))

        default:
            return nil
        }
    }
}
