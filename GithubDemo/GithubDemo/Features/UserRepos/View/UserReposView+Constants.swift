//
//  UserReposView+Constants.swift
//  Github-Demo
//
//  Created by Pushpsen Airekar on 24/05/25.
//

import SwiftUI

// MARK: - Constants
extension UserReposView {
    
    /// Text constants used in the UserReposView
    enum Constants {
        static let repositoryText: String = "Repositories"
        static let failureText: String = "Failed to fetch repositories"
        static let starsText: String = "stars"
    }
    
    /// System image names used in UserReposView
    enum SystemImageConstants {
        static let chevronBackward: String = "chevron.backward"
        static let failure: String = "exclamationmark.circle"
        static let star: String = "star"
    }
}
