//
//  OnboardingView+Views.swift
//  Github-Demo
//
//  Created by Pushpsen Airekar on 23/05/25.
//

import SwiftUI

extension OnboardingView {
    
    /// Background image filling the entire screen
    func buildBackground() -> some View {
        Image.onboardingBackground
            .resizable()
            .ignoresSafeArea()
            .aspectRatio(contentMode: .fill)
    }
    
    /// App logo displayed on onboarding screen
    func buildLogo() -> some View {
        Image.logo
            .renderingMode(.template)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 75, height: 75)
            .foregroundStyle(Color.ghSolidWhiteText)
    }
    
    /// Header text with custom font and white color
    func buildHeader() -> some View {
        Text(Constants.headerText)
            .foregroundStyle(Color.ghSolidWhiteText)
            .font(.headerFont())
    }
    
    /// Tagline text supporting multiple lines with gray color
    func buildTagline() -> some View {
        Text(Constants.taglineText)
            .multilineTextAlignment(.leading)
            .foregroundStyle(Color.ghSolidGrayText)
            .font(.tertiaryFont())
    }
    
    /// 'Get Started' button with animation and icon
    @ViewBuilder
    func buildButton() -> some View {
        Button {
            withAnimation {
                onComplete()
            }
        } label: {
            HStack {
                Text(Constants.getStartedText)
                    .foregroundColor(.black)
                    .font(.tertiaryFont(weight: .semibold))
                
                Image(systemName: SystemImageConstants.chevronForward)
                    .tint(.black)
                    .font(.tertiaryFont(weight: .semibold))
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
            .background {
                RoundedRectangle(cornerSize: .init(width: 6, height: 6))
                    .foregroundColor(.white)
            }
        }
    }
}
