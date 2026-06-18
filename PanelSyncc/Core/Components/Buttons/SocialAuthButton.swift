//
//  SocialAuthButton.swift
//  PanelSyncc
//
//  Created by Amelia Putri Aftiana on 17/06/26.
//


import SwiftUI

struct SocialAuthButton: View {
    let title: String
    let iconName: String
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
                    .font(.buttonFontOnboard)
            }
            .foregroundColor(Color(hex: "#FFFFFF"))
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(Color.panelDark)
            .cornerRadius(12)
        }
    }
}

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
