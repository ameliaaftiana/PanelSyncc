//
//  OnboardingPage4.swift
//  PanelSyncc
//
//  Created by Amelia Putri Aftiana on 18/06/26.
//

import SwiftUI

struct OnboardingPage4: View {
    var body: some View {
        VStack {
            Spacer()
            
            Image("Onboarding4")
                .resizable()
                .scaledToFit()
                .padding(.horizontal)
            
            Spacer()
            
            VStack(spacing: 12) {
                Text("Welcome to\nPanelSync")
                    .font(.onboardingTitle)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.black)
                
                Text("The ultimate social hub for comic enthusiasts. Join the community to read, curate, and connect.")
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
    OnboardingPage4()
}
