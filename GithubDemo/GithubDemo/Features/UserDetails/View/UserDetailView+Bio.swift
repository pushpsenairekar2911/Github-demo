//
//  UserDetailView+Bio.swift
//  Github-Demo
//
//  Created by Pushpsen Airekar on 23/05/25.
//

import SwiftUI

extension UserDetailsView {
    
    /// Builds a view displaying the user's bio if it is not empty.
    @ViewBuilder
    func buildBio(
        bio: String
    ) -> some View {
        if !bio.isEmpty {
            HStack {
                Text(bio)
                    .font(.secondaryFont())
                    .foregroundColor(.ghPrimaryText)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal)
                Spacer()
            }
        }
    }
}
