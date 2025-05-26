//
//  UsersViewModelEvent.swift
//  Github-Demo
//
//  Created by Pushpsen Airekar on 23/05/25.
//

import SwiftUI
import Combine
import Foundation
import GHKit

typealias User = UsersPresentationObject.User

// MARK: - UsersPresentationObject
struct UsersPresentationObject: Sendable {
    
    static let initialValue: UsersPresentationObject = .init(state: .loading)
    
    enum State: Sendable {
        case loading
        case loaded(users: [User])
        case failed
    }
    
    struct User: Identifiable {
        let id = UUID()
        let name: String
        let imageUrl: GHImageSource
    }
    
    var state: State
}
