//
//  UsersView+List.swift
//  Github-Demo
//
//  Created by Pushpsen Airekar on 23/05/25.
//

import SwiftUI

extension UsersView {
    
    func buildUsersList(
        users: [User]
    ) -> some View {
        ScrollView {
            LazyVGrid(columns: columns,
                      spacing: 16
            ) {
                ForEach(users) { user in
                    buildUserListItem(
                        user: user
                    )
                }
            }
            .padding()
        }
        .searchable(
            text: $viewModel.searchText,
            placement: .navigationBarDrawer(displayMode: .always)
        )
        .overlay {
            if case .loaded(_) = viewModel.presentationObject.state, users.isEmpty {
                ContentUnavailableView.search
            }
        }
    }
}
