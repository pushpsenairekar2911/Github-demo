//
//  UserDetailView+UserHeader.swift
//  Github-Demo
//
//  Created by Pushpsen Airekar on 23/05/25.
//

import SwiftUI
import GHKit

extension UserDetailsView {
    
    /// Builds the user header view displaying user avatar, name, and stats.
    /// - Parameter user: The user details to display.
    /// - Returns: A view containing the user's header information.
    func buildUserHeaderView(
        user: UserDetails
    ) -> some View {
        HStack(alignment: .center, spacing: 20) {
            // User avatar icon
            buildIcon(imageSource: user.imageUrl)
            
            // User name and stats
            VStack(alignment: .leading, spacing: 10) {
                buildName(name: user.name)
                
                // Stats: repos, followers, following
                HStack(spacing: 40) {
                    buildTitleSubtitle(
                        title: "\(user.repos)",
                        subtitle: Constants.reposText
                    )
                    
                    buildTitleSubtitle(
                        title: "\(user.followers)",
                        subtitle: Constants.followersText
                    )
                    
                    buildTitleSubtitle(
                        title: "\(user.following)",
                        subtitle: Constants.followingText
                    )
                }
                .padding(.trailing)
            }
            
            Spacer()
        }
        .padding()
    }
}

// MARK: - Private helper views

extension UserDetailsView {
    
    /// Builds a text view for the user's name if available.
    /// - Parameter name: Optional user name string.
    /// - Returns: A text view showing the user's name.
    @ViewBuilder
    private func buildName(
        name: String?
    ) -> some View {
        if let name, !name.isEmpty {
            Text(name)
                .font(.primaryFont(weight: .bold))
                .foregroundColor(.ghPrimaryText)
                .multilineTextAlignment(.leading)
        }
    }
    
    /// Builds the user avatar image view.
    /// Supports local image names or remote URLs.
    /// - Parameter imageSource: GHImageSource enum (local or remote image).
    /// - Returns: An image view clipped to a circle.
    @ViewBuilder
    func buildIcon(
        imageSource: GHImageSource?
    ) -> some View {
        if let imageSource {
            switch imageSource {
            case .localImage(let name):
                Image.fromName(name)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 68, height: 68)
                    .clipShape(Circle())
            case .remote(let url):
                GHAsyncImage(url: URL(string: url)!)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 68, height: 68)
                    .clipShape(Circle())
            }
        }
    }
    
    /// Builds a vertical stack with title and subtitle text.
    /// - Parameters:
    ///   - title: The main title text (e.g., "12").
    ///   - subtitle: The subtitle text (e.g., "repos").
    /// - Returns: A vertically stacked view showing the title and subtitle.
    private func buildTitleSubtitle(
        title: String,
        subtitle: String
    ) -> some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.primaryFont(weight: .bold))
                .foregroundColor(.ghPrimaryText)
            
            Text(subtitle)
                .font(.tertiaryFont())
                .foregroundColor(.ghPrimaryText)
        }
    }
}
