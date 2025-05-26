//
//  UserRepos+ListItem.swift
//  Github-Demo
//
//  Created by Pushpsen Airekar on 24/05/25.
//

import GHKit
import SwiftUI

extension UserReposView {
    // MARK: - Build Repo List Item
    @ViewBuilder
    func buildListItem(
        repo: Repository
    ) -> some View {
        HStack {
            VStack(alignment: .leading,
                   spacing: 12) {
                // Title & Subtitle
                buildTitleSubtitle(
                    title: repo.title,
                    subtitle: repo.description
                )
                
                buildBottomView(
                    language: repo.language,
                    stars: "\(repo.stars) " + Constants.starsText
                )
            }.padding()
            Spacer()
        }
        .contentShape(Rectangle())
        .clipped()
        .background {
            RoundedRectangle(cornerSize: .init(width: 12, height: 12))
                .foregroundColor(Color.ghSecondaryBackground)
        }
    }
    
    @ViewBuilder
    func buildTitleSubtitle(
        title: String?,
        subtitle: String?
    ) -> some View {
        VStack(alignment: .leading,
               spacing: 12) {
            if let title {
                Text(title)
                    .foregroundColor(.ghPrimaryText)
                    .font(.secondaryFont(weight: .semibold))
                    .multilineTextAlignment(.leading)
            }
            if let subtitle {
                Text(subtitle)
                    .foregroundColor(.ghSecondaryText)
                    .font(.tertiaryFont())
                    .multilineTextAlignment(.leading)
            }
        }
    }
    
    @ViewBuilder
    func buildBottomView(
        language: String?,
        stars: String?
    ) -> some View {
        HStack(spacing: 6) {
            if let language, !language.isEmpty {
                HStack(spacing: 4) {
                    Capsule()
                        .frame(width: 10, height: 10)
                        .foregroundColor(.ghRedPestel)
                        .padding(2)
                        .lineLimit(1)
                    
                    Text(language)
                        .foregroundColor(.ghSecondaryText)
                        .font(.tertiaryFont())
                        .padding(2)
                        .lineLimit(1)
                }
                .padding(.horizontal, 5)
                .padding(.vertical, 3)
                .background {
                    RoundedRectangle(cornerSize: CGSize(width: 6, height: 6))
                        .foregroundColor(Color.ghTertiaryBackground)
                }
                .roundedBorder(
                    cornerRadius: 6,
                    color: Color.ghTertiaryStroke,
                    lineWidth: 1
                )
            }
            
            if let stars {
                HStack(spacing: 6) {
                    Image(systemName: SystemImageConstants.star)
                        .foregroundColor(.ghSecondaryText)
                        .font(.tertiaryFont())
                        .padding(2)
                        .lineLimit(1)
                    
                    Text(stars)
                        .foregroundColor(.ghSecondaryText)
                        .font(.tertiaryFont())
                        .padding(2)
                        .lineLimit(1)
                }
                .padding(.horizontal, 5)
                .padding(.vertical, 3)
                .background {
                    RoundedRectangle(cornerSize: CGSize(width: 6, height: 6))
                        .foregroundColor(Color.ghTertiaryBackground)
                }
                .roundedBorder(
                    cornerRadius: 6,
                    color: Color.ghTertiaryStroke,
                    lineWidth: 1
                )
            }
        }.frame(height: 32)
    }
}
