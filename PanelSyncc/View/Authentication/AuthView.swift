//
//  AuthView.swift
//  PanelSyncc
//
//  Created by Amelia Putri Aftiana on 18/06/26.
//

import SwiftUI

struct AppleIconView: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.white)
                .frame(width: 24, height: 24)

            Image(systemName: "applelogo")
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.black)
        }
    }
}

struct GoogleIconView: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.white)
                .frame(width: 24, height: 24)

            Text("G")
                .font(.system(size: 18, weight: .bold))
                .foregroundStyle(
                    LinearGradient(
                        colors: [
                            Color(hex: "#4285F4"),
                            Color(hex: "#4285F4"),
                            Color(hex: "#EA4335"),
                            Color(hex: "#FBBC05"),
                            Color(hex: "#34A853")
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
        }
    }
}

struct AuthView: View {
    @State private var navigateToHome = false

    var body: some View {
        NavigationStack {
            VStack {
                // MARK: - Top Spacer (For illustration later)
                Spacer()

                // MARK: - Title
                Text("Log In or Sign Up")
                    .font(.loginTitle)
                    .foregroundColor(.black)
                    .padding(.bottom, 16)

                // MARK: - Buttons Section
                VStack(spacing: 10) {
                    // 1. Apple Button
                    SocialAuthButton(
                        title: "Continue with Apple",
                        iconName: "",
                        isSystemIcon: true
                    ) {
                        navigateToHome = true
                    }
                    .overlay(alignment: .leading) {
                        AppleIconView()
                            .padding(.leading, 54)
                    }
                    // 2. Google Button
                    SocialAuthButton(
                        title: "Continue with Google",
                        iconName: "",
                        isSystemIcon: true
                    ) {
                        navigateToHome = true
                    }
                    .overlay(alignment: .leading) {
                        GoogleIconView()
                            .padding(.leading, 54)
                    }
                    SecondaryButton(
                        title: "Skip for now",
                        action: {
                            navigateToHome = true
                        }
                    )
                }
                .padding(.horizontal)

                Spacer()
                    .frame(height: 80)

                // MARK: - Footer Links
                HStack {
                    Button("PRIVACY POLICY") {
                        print("Privacy Policy tapped")
                    }

                    Spacer()

                    Button("TERMS OF SERVICE") {
                        print("Terms of Service tapped")
                    }
                }
                .font(.system(size: 10, weight: .bold))
                .tracking(1) // Adds spacing between letters to match your design
                .foregroundColor(.black)
                .padding(.horizontal, 40)
                .padding(.bottom, 24)
            }
            .background(Color.white.ignoresSafeArea())
            .navigationDestination(isPresented: $navigateToHome) {
                ContentView()
            }
        }
    }
}

#Preview {
    AuthView()
}
