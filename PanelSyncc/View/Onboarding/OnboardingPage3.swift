//
//  OnboardingPage3.swift
//  PanelSyncc
//
//  Created by Amelia Putri Aftiana on 18/06/26.
//

import SwiftUI

struct OnboardingPage3: View {
    var body: some View {
        VStack {
            Spacer()
            
            Image("Onboarding3")
                .resizable()
                .scaledToFit()
                .padding(.horizontal)
            
            Spacer()
            
            VStack(spacing: 12) {
                Text("Read Together\nChat Anytime")
                    .font(.onboardingTitle)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.black)
                
                Text("Connect with fellow comic lovers. Discuss the latest chapters, share theories, and chat with friends right inside the app.")
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
    OnboardingPage3()
}
