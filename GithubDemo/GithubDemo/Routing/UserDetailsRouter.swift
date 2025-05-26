//
//  UserRouteHandler.swift
//  Github-Demo
//
//  Created by Pushpsen Airekar on 25/05/25.
//
import UserService
import SwiftUI

struct UserDetailsRouter: RouteHandler {
    let userService: UserService

    func view(for route: Route) -> AnyView? {
        switch route {
        case .userDetails(let username):
            let viewModel = UserDetailsViewModel(userName: username, userService: userService)
            return AnyView(UserDetailsView(viewModel: viewModel))

        default:
            return nil
        }
    }
}
