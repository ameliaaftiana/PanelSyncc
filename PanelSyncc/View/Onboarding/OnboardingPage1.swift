//
//  OnboardingPage1.swift
//  PanelSyncc
//
//  Created by Amelia Putri Aftiana on 18/06/26.
//


import SwiftUI

struct OnboardingPage1: View {
    var body: some View {
        VStack {
            // MARK: - Middle Image Area
            Spacer()
            // Drop your Image() here later!
            
            Spacer()
            
            // MARK: - Text Content
            VStack(spacing: 12) {
                Text("Dive Into Endless\nStories")
                    .font(.onboardingTitle)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.panelDark)
                
                Text("Explore a massive library of comics. Find your next favorite series, track your progress, and rank the best reads.")
                    .font(.onboardingDescription) 
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 16)
                    .lineSpacing(4)
            }
            .padding(.bottom, 40) // Gives space before the Next button
        }
    }
}

#Preview {
    OnboardingPage1()
}
