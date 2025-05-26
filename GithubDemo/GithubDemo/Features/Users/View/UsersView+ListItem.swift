//
//  UsersView+ListItem.swift
//  Github-Demo
//
//  Created by Pushpsen Airekar on 23/05/25.
//

import SwiftUI
import GHKit
import GHFoundation

extension UsersView {

    func buildUserListItem(user: User) -> some View {
        VStack(spacing: 12) {
            buildIcon(
                imageSource: user.imageUrl
            )
            
            buildName(
                name: user.name
            )
            
            buildViewProfile(
                userName: user.name
            )
        }
        .padding()
        .background(Color.ghSecondaryBackground)
        .cornerRadius(6)
        .contentShape(Rectangle())
        .roundedBorder(
            cornerRadius: 6,
            color: Color.ghSecondaryStroke,
            lineWidth: 1
        )
        .onTapGesture {
            withAnimation {
                router.goToUserDetails(
                    userName: user.name
                )
            }
        }
    }
    
    private func buildName(
        name: String
    ) -> some View {
        Text(name)
            .font(.tertiaryFont())
            .foregroundColor(.ghTertiaryText)
    }
    
    private func buildViewProfile(
        userName: String
    ) -> some View {
        HStack {
            Spacer()
            Button(action: {
                    withAnimation {
                        router.goToUserDetails(
                            userName: userName
                        )
                    }
            }) {
                Group {
                    Text(Constants.viewProfileText)
                    +
                    Text(Image(systemName: SystemImageConstants.chevronRight))
                }
                .font(.tertiaryFont())
                .foregroundColor(.ghSecondaryText)
                .padding(.vertical, 6)
                .padding(.horizontal, 10)
                .background(Color.ghTertiaryBackground)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 6, style: .continuous))
                .roundedBorder(
                    cornerRadius: 6,
                    color: Color.ghTertiaryStroke,
                    lineWidth: 1
                )
            }
            Spacer()
        }
    }
}

extension UsersView {
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
                    .frame(
                        width: 90,
                        height: 90,
                        alignment: .center
                    )
                    .clipShape(Circle())
            case .remote(let url):
                GHAsyncImage(url: URL(string: url)!)
                .aspectRatio(contentMode: .fit)
                .frame(
                    width: 90,
                    height: 90,
                    alignment: .center
                )
                .clipShape(Circle())
            }
        }
    }
}
