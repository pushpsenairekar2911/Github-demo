//
//  UserDetailsViewModelInterface.swift
//  Github-Demo
//
//  Created by Pushpsen Airekar on 23/05/25.
//

import SwiftUI
import Combine
import Foundation
import GHKit

/// Typealias for convenience to refer to nested UserDetails struct
typealias UserDetails = UserDetailsPresentationObject.UserDetails

/// Presentation object for User Details screen,
/// encapsulating the UI state and user data.
struct UserDetailsPresentationObject: Sendable {
    
    /// Initial default value with loading state
    static let initialValue: UserDetailsPresentationObject = .init(state: .loading)
    
    /// Enum representing different states of the view
    enum State: Sendable {
        /// Data is being loaded
        case loading
        
        /// Data successfully loaded with associated user details
        case loaded(user: UserDetails)
        
        /// Failed to load data
        case failed
    }
    
    /// Struct representing detailed user information used by the view
    struct UserDetails: Identifiable {
        /// Unique identifier for SwiftUI lists and diffing
        let id = UUID()
        
        /// User's login or username
        let login: String
        
        /// User's full name (optional, may be empty string)
        let name: String
        
        /// Number of followers the user has
        let followers: Int
        
        /// Number of users the user is following
        let following: Int
        
        /// Number of public repositories owned by the user
        let repos: Int
        
        /// User biography or description (optional)
        let bio: String
        
        /// User's company affiliation (optional)
        let company: String
        
        /// User's location or address (optional)
        let address: String
        
        /// User avatar image source, supports local or remote images
        let imageUrl: GHImageSource
        
        /// URLs for following, followers, starred repos, and organizations (optional)
        let followingURL: String?
        let followersURL: String?
        let starredURL: String?
        let organizationsURL: String?
    }
    
    /// Current state of the presentation object (loading, loaded, failed)
    var state: State
}
