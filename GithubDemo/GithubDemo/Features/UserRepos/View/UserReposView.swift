//
//  UserReposView.swift
//  Github-Demo
//
//  Created by Pushpsen Airekar on 24/05/25.
//

import SwiftUI

/// Displays the repository list for a user, handling loading, failure, and loaded states.
struct UserReposView: View {
    
    @EnvironmentObject var router: AppRouter  
    @StateObject var viewModel : UserReposViewModel  
    
    var body: some View {
        buildContentView()
    }
}

extension UserReposView {
    @ViewBuilder
    private func buildContentView() -> some View {
        ZStack {
            Color.ghPrimaryBackground
                .ignoresSafeArea()
            
            VStack {
                switch viewModel.presentationObject.state {
                case .failed:
                    buildFailureView()
                case .loading:
                    buildLoadingView()
                case .loaded(let repos):
                    buildRepoList(repos: repos)
                }
            }
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    buildBackButton()
                }
            }
        }
    }
    
    @ViewBuilder
    private func buildBackButton() -> some View {
        Button {
            router.goBack()
        } label: {
            HStack {
                Image(systemName: SystemImageConstants.chevronBackward)
                    .font(.secondaryFont(weight: .semibold))
                    .foregroundColor(.ghPrimaryText)
                
                Text(Constants.repositoryText)
                    .font(.secondaryFont(weight: .semibold))
                    .foregroundColor(.ghPrimaryText)
            }
        }
    }
}
