//
//  UserDetailsView.swift
//  Github-Demo
//
//  Created by Pushpsen Airekar on 23/05/25.
//

import GHKit
import SwiftUI

struct UserDetailsView: View {
    
    @StateObject var viewModel: UserDetailsViewModel
    @EnvironmentObject var router: AppRouter
    
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
                case .loaded(let user):
                    buildContentView(user: user)
                case .failed:
                    ContentUnavailableView(
                        Constants.failureText,
                        image: SystemImageConstants.failure
                    )
                }
            }
        }
        // Hide default back button to use custom one
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                buildBackButton()
            }
        }
    }
}

extension UserDetailsView {
    
    /// Builds the main content view showing user details
    func buildContentView(user: UserDetails) -> some View {
        ScrollView {
            buildUserHeaderView(user: user)
            buildBio(bio: user.bio)
            buildCompanyAndLocationView(
                company: user.company,
                location: user.address
            )
            
            Divider()
                .padding(.vertical)
            
            VStack(spacing: 14) {
                // Button to navigate to user repositories list
                Button {
                    router.goToUserRepos(userName: user.login)
                } label: {
                    buildSectionItem(
                        icon: SystemImageConstants.book,
                        iconColor: .ghRedPestel,
                        title: Constants.repositoriesText,
                        subtitle: "\(user.repos)"
                    )
                }
                
                // Button to open starred repositories URL in browser
                Button {
                    if let starredURL = user.starredURL, let url = URL(string: starredURL) {
                        router.openURL(url: url)
                    }
                } label: {
                    buildSectionItem(
                        icon: SystemImageConstants.star,
                        iconColor: .ghYellowPestel,
                        title: Constants.starredText,
                        subtitle: ""
                    )
                }
                
                // Button to open organizations URL in browser
                Button {
                    if let organizationsURL = user.organizationsURL, let url = URL(string: organizationsURL) {
                        router.openURL(url: url)
                    }
                } label: {
                    buildSectionItem(
                        icon: SystemImageConstants.building,
                        iconColor: .ghOrangePestel,
                        title: Constants.organizationsText,
                        subtitle: ""
                    )
                }
            }
        }
    }
    
    /// Custom back button 
    @ViewBuilder
    private func buildBackButton() -> some View {
        Button {
            router.goBack()
        } label: {
            HStack {
                Image(systemName: SystemImageConstants.chevronBackward)
                    .font(.secondaryFont(weight: .semibold))
                    .foregroundColor(.ghPrimaryText)
                
                if case let .loaded(user) = viewModel.presentationObject.state {
                    Text(user.login)
                        .font(.secondaryFont(weight: .semibold))
                        .foregroundColor(.ghPrimaryText)
                }
            }
        }
    }
}
