//
//  UserDetailView+CompanyAndLocation.swift
//  Github-Demo
//
//  Created by Pushpsen Airekar on 23/05/25.
//

import SwiftUI

extension UserDetailsView {
    
    /// Builds a horizontal view displaying the user's company and location.
    @ViewBuilder
    func buildCompanyAndLocationView(
        company: String?,
        location: String?
    ) -> some View {
        // Show view only if company or location is non-empty
        if !(company?.isEmpty ?? true) || !(location?.isEmpty ?? true) {
            HStack(spacing: 6) {
                
                // Location View
                if let location, !location.isEmpty {
                    HStack(spacing: 4) {
                        Image(systemName: SystemImageConstants.house)
                            .foregroundColor(.ghSecondaryText)
                            .font(.tertiaryFont())
                            .padding(2)
                        
                        Text(location)
                            .foregroundColor(.ghSecondaryText)
                            .font(.tertiaryFont())
                            .padding(2)
                            .lineLimit(1)
                    }
                    .padding(5)
                    .background {
                        RoundedRectangle(cornerSize: CGSize(width: 6, height: 6))
                            .foregroundColor(Color.ghSecondaryBackground)
                    }
                    .roundedBorder(
                        cornerRadius: 6,
                        color: Color.ghSecondaryStroke,
                        lineWidth: 1
                    )
                }
                
                // Company View
                if let company, !company.isEmpty {
                    HStack(spacing: 4) {
                        Image(systemName: SystemImageConstants.building)
                            .foregroundColor(.ghSecondaryText)
                            .font(.tertiaryFont())
                            .padding(2)
                        
                        Text(company)
                            .foregroundColor(.ghSecondaryText)
                            .font(.tertiaryFont())
                            .padding(2)
                            .lineLimit(1)
                    }
                    .padding(5)
                    .background {
                        RoundedRectangle(cornerSize: CGSize(width: 6, height: 6))
                            .foregroundColor(Color.ghSecondaryBackground)
                    }
                    .roundedBorder(
                        cornerRadius: 6,
                        color: Color.ghSecondaryStroke,
                        lineWidth: 1
                    )
                }
                
                Spacer()
            }
            .frame(height: 32)
            .padding(.leading)
        }
    }
}
