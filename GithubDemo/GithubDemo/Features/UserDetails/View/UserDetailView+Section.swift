//
//  UserDetailView+Section.swift
//  Github-Demo
//
//  Created by Pushpsen Airekar on 23/05/25.
//

import SwiftUI

extension UserDetailsView {
    
    /// Builds a section item with an icon, title, subtitle, and a forward chevron.
    /// - Parameters:
    ///   - icon: The system image name for the icon.
    ///   - iconColor: The background color for the icon's rounded rectangle.
    ///   - title: The main title text.
    ///   - subtitle: The subtitle text displayed on the trailing side.
    /// - Returns: A view representing the section item.
    func buildSectionItem(
        icon: String,
        iconColor: Color,
        title: String,
        subtitle: String
    ) -> some View {
        HStack {
            // Icon with colored rounded rectangle background
            RoundedRectangle(cornerSize: .init(width: 6, height: 6))
                .foregroundColor(iconColor)
                .overlay {
                    Image(systemName: icon)
                        .font(.tertiaryFont())
                        .foregroundColor(.ghSolidWhiteText)
                }
                .frame(width: 30, height: 30)
            
            // Title text
            Text(title)
                .font(.secondaryFont())
                .foregroundColor(.ghPrimaryText)
            
            Spacer()
            
            // Subtitle text
            Text(subtitle)
                .font(.secondaryFont())
                .foregroundColor(.ghTertiaryText)
            
            // Chevron forward icon indicating navigation
            Image(systemName: SystemImageConstants.chevronForward)
                .font(.secondaryFont())
                .foregroundColor(.ghPrimaryText)
        }
        .padding(14)
        .background {
            RoundedRectangle(cornerSize: .init(width: 12, height: 12))
                .foregroundColor(Color.ghSecondaryBackground)
        }
        .padding(.horizontal)
    }
}
