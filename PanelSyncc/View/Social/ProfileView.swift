//
//  ProfileView.swift
//  PanelSyncc
//
//  Created by Amelia Putri Aftiana on 19/06/26.
//


import SwiftUI

// MARK: - Main Profile View

struct ProfileView: View {
    var body: some View {
        // 1. CHANGED: Use NavigationStack instead of NavigationView
        NavigationStack {
            VStack(spacing: 0) {
                HStack {
                    Text("Profile")
                        .font(.libraryTitle)
                        .foregroundColor(.panelDark)

                    Spacer()

                    Button(action: {
                        // TODO: Settings or Options action
                    }) {
                        Image(systemName: "ellipsis")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.black)
                            .padding(20)
                            .background(Color.white)
                            .clipShape(Circle())
                            .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 10)
                .padding(.bottom, 20)

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 20) {

                        // ── 2. Avatar & Info ───────────────────────────────────
                        VStack(spacing: 12) {
                            ProfileAvatarView()
                                .padding(.top, 16)

                            VStack(spacing: 4) {
                                Text("Username")
                                    .font(.topPicksTitle)
                                    .foregroundColor(.panelDark)

                                Text("Lorem ipsum dolor sit amet,\nconsectetur adipiscing elit.")
                                    .font(.libraryMenuUnSelected)
                                    .foregroundColor(.panelDark)
                                    .multilineTextAlignment(.center)
                            }
                        }
                        Spacer()

                        // ── 3. Menu Group 1 ────────────────────────────────────
                        VStack(spacing: 0) {
                            ProfileMenuRow(iconName: "clock.arrow.circlepath", title: "Reading History", showDivider: true)
                            ProfileMenuRow(iconName: "questionmark.circle", title: "Help & Support", showDivider: true)
                            ProfileMenuRow(iconName: "bell", title: "Notifications", showDivider: false)
                        }
                        .background(Color.panelSecondary)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .padding(.horizontal)

                        // ── 4. Menu Group 2 ────────────────────────────────────
                        VStack(spacing: 0) {
                            // This NavigationLink now correctly pushes onto the NavigationStack
                            NavigationLink(destination: CreatorStudioView()) {
                                ProfileMenuRow(iconName: "location.north.circle", title: "Creator Studio", showDivider: false)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                        .background(Color.panelSecondary)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .padding(.horizontal)

                        // ── 5. Log Out Button ──────────────────────────────────
                        PrimaryButton(title: "Log Out") {
                            // TODO: Add your log out logic here
                            print("Log Out Tapped")
                        }
                        .padding(.horizontal)

                        Spacer(minLength: 40)
                    }
                    .padding(.bottom, 30)
                }
            }
            .background(Color(UIColor.systemGray6).ignoresSafeArea())
            .navigationBarHidden(true)
        }
    }
}


// MARK: - Preview
#Preview {
    ProfileView()
}
