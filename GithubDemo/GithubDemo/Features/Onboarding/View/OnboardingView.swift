//
//  OnboardingView.swift
//  Github-Demo
//
//  Created by Pushpsen Airekar on 23/05/25.
//

import SwiftUI
import GHKit

struct OnboardingView: View {
    
    // Closure called when onboarding completes
    var onComplete: () -> Void
    
    var body: some View {
        VStack {
            // MARK: - Background View
            buildBackground()
                .overlay {
                    VStack(alignment: .leading) {
                        
                        // MARK: - Logo View
                        buildLogo()
                            .padding(.bottom, 30)
                        
                        VStack(alignment: .leading,
                               spacing: 16) {
                            // MARK: - Header View
                            buildHeader()
                            
                            // MARK: - Tagline View
                            buildTagline()
                            
                            // MARK: - Button View
                            buildButton()
                                .padding(.top, 10)
                        }
                        Spacer()
                    }
                    .padding(.top, 148)
                    .padding(.leading, 40)
                    .padding(.trailing)
                }
        }
    }
}
