//
//  SocialAuthButton.swift
//  PanelSyncc
//
//  Created by Amelia Putri Aftiana on 17/06/26.
//


import SwiftUI

struct SocialAuthButton: View {
    let title: String
    let iconName: String // SystemImage name or custom asset name
    let isSystemIcon: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                if isSystemIcon {
                    Image(systemName: iconName)
                        .font(.buttonFontOnboard)
                } else {
                    Image(iconName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                }
                
                Text(title)
                    .font(.headline)
            }
            .foregroundColor(Color(hex: "#FFFFFF"))
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(Color(hex: "#6B7589"))
            .cornerRadius(12)
        }
    }
}

// Preview
// Preview
#Preview {
    SocialAuthButton(
        title: "Get Started",
        iconName: "apple.logo",
        isSystemIcon: true
    ) {
        print("Tapped")
    }
    .padding()
}
