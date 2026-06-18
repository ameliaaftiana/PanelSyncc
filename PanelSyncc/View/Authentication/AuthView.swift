//
//  AuthView.swift
//  PanelSyncc
//
//  Created by Amelia Putri Aftiana on 18/06/26.
//


import SwiftUI

struct AuthView: View {
    var body: some View {
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
                    iconName: "applelogo",
                    isSystemIcon: true
                ) {
                    print("Continue with Apple tapped")
                }
                // 2. Google Button
                SocialAuthButton(
                    title: "Continue with Google",
                    iconName: "GoogleIcon", // Custom Image Asset (See note below!)
                    isSystemIcon: false
                ) {
                    // Action for Google Login
                    print("Continue with Google tapped")
                }
                SecondaryButton(
                    title: "Skip for now",
                    action: {
                        // Action to enter the app as a guest
                        print("Skip for now tapped")
                    }
                )
            }
            .padding(.horizontal, 24)
            
            Spacer()
                .frame(height: 60) // Keeps the footer pinned near the bottom
            
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
    }
}

//// MARK: - Secondary Button Component
//// (You can move this to its own file later, just like SocialAuthButton!)
//struct SecondaryButton: View {
//    let title: String
//    let action: () -> Void
//    
//    var body: some View {
//        Button(action: action) {
//            Text(title)
//                .font(.headline)
//                .foregroundColor(.white)
//                .frame(maxWidth: .infinity)
//                .padding(.vertical, 14)
//                // Uses the gray color from your Theme file
//                .background(Color.panelPrimary) 
//                .cornerRadius(12)
//        }
//    }
//}

#Preview {
    AuthView()
}
