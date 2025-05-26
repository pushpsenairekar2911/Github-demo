//
//  RootView.swift
//  Github-Demo
//
//  Created by Pushpsen Airekar on 23/05/25.
//

import SwiftUI
import Combine

struct RootView: View {
    
    /// Persist onboarding status in UserDefaults
    @AppStorage("hasOnboarded") private var hasOnboarded: Bool = false
    
    /// Shared router object for navigation and app state
    @EnvironmentObject var router: AppRouter
    
    /// RouterCoordinator to resolve views for navigation routes
    let coordinator: RouterCoordinator
    
    var body: some View {
        Group {
            if hasOnboarded {
                // Main app flow with NavigationStack and dynamic routing
                NavigationStack(path: $router.path) {
                    UsersView(
                        viewModel: UsersViewModel(
                            userService: router.userService
                        )
                    )
                    .navigationDestination(for: Route.self) { route in
                        coordinator.resolveView(for: route)
                    }
                }
            } else {
                // Show onboarding screen until completed
                OnboardingView {
                    withAnimation {
                        hasOnboarded = true
                    }
                }
            }
        }
    }
}
