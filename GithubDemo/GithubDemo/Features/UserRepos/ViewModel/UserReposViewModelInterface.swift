//
//  UserReposViewModelInterface.swift
//  Github-Demo
//
//  Created by Pushpsen Airekar on 24/05/25.
//

import SwiftUI
import Combine
import Foundation
import UserService

// Alias for convenience
typealias Repository = UserReposPresentationObject.Repository

// MARK: - Presentation object representing the user repositories state
public struct UserReposPresentationObject: Sendable {
    
    // Initial state when loading begins
    static let initialValue: UserReposPresentationObject = .init(state: .loading)

    // Represents the different UI states
    enum State: Sendable {
        case loading
        case loaded(repos: [Repository])
        case failed                 
    }
    
    // Repository model presented to the view
    struct Repository: Identifiable, Sendable {
        let id : Int
        let title: String
        let description: String?
        let language: String?
        let stars: Int
        let url: URL?
    }
    
    // Current state of the repositories view
    let state: State
}
