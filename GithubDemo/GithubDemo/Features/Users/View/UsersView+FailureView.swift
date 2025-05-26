

//
//  UserRepos+FailureView.swift
//  Github-Demo
//
//  Created by Pushpsen Airekar on 24/05/25.
//

import SwiftUI

extension UsersView {
    // MARK: - Build Failure View
    @ViewBuilder
    func buildFailureView() -> some View {
        VStack {
            Image(systemName: SystemImageConstants.failure)
                .resizable()
                .font(.system(size: 32))
            
            Text(Constants.failureText)
        }
    }
}
