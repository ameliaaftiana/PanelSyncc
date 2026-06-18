//
//  OnboardingPage2.swift
//  PanelSyncc
//
//  Created by Amelia Putri Aftiana on 18/06/26.
//


import SwiftUI

struct OnboardingPage2: View {
    var body: some View {
        VStack {
            Spacer()
            
            // Image Placeholder
            
            Spacer()
            
            VStack(spacing: 12) {
                Text("Curate Your Comic\nPlaylists")
                    .font(.onboardingTitle)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.panelDark)
                
                Text("Group your top reads into custom collections. Share your unique taste with the world and discover what others are hooked on.")
                    .font(.onboardingDescription)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 16)
                    .lineSpacing(4)
            }
            .padding(.bottom, 40)
        }
    }
}

#Preview {
    OnboardingPage2()
}
