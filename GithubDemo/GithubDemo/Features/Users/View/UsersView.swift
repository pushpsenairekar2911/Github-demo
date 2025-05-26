//
//  UsersView.swift
//  Github-Demo
//
//  Created by Pushpsen Airekar on 23/05/25.
//

import SwiftUI
import GHKit

struct UsersView: View {
    
    @EnvironmentObject var router: AppRouter
    @StateObject var viewModel: UsersViewModel
    
    let columns = [
        GridItem(.flexible(), spacing: 14),
        GridItem(.flexible(), spacing: 14)
    ]
    
    var body: some View {
        ZStack {
            // Background color for the entire view
            Color.ghPrimaryBackground
                .ignoresSafeArea()
            
            VStack {
                // Switch between loading, loaded, and failure states
                switch viewModel.presentationObject.state {
                case .loading:
                    ProgressView()
                case .loaded:
                    // Use filteredUsers directly from viewModel
                    buildUsersList(users: viewModel.filteredUsers)
                case .failed:
                    ContentUnavailableView(
                        Constants.failureText,
                        image: SystemImageConstants.failure
                    )
                }
            }
        }
        .navigationTitle(Constants.developersText)
        .background(Color.ghPrimaryBackground)
    }
}
