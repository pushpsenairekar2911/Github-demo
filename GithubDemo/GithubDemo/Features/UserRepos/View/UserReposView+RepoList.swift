//
//  UserRepos+RepoList.swift
//  Github-Demo
//
//  Created by Pushpsen Airekar on 24/05/25.
//

import SwiftUI

extension UserReposView {
    
    // MARK: - Build Repo List
    @ViewBuilder func buildRepoList(
        repos: [Repository]
    ) -> some View {
        List(repos) { repo in
            buildListItem(
                repo: repo
            )
            .onTapGesture {
                if let url = repo.url {
                    router.openURL(url: url)
                }
            }
            .listRowSeparator(.hidden, edges: .all)
            .listRowBackground(Color.clear)
            .listRowInsets(EdgeInsets(top: 6, leading: 16, bottom: 6, trailing: 16))
        }
        .background(Color.clear)
        .listStyle(.plain)
        .scrollIndicators(.hidden)
    }
}
