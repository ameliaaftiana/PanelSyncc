import SwiftUI

// MARK: - Main Profile View

struct ProfileView: View {
    var body: some View {
        NavigationView {
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
                            .padding(12)
                            .background(Color.white)
                            .clipShape(Circle())
                            .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 10)
                .padding(.bottom, 12)

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
                            ProfileMenuRow(iconName: "location.north.circle", title: "Creator Studio", showDivider: true)
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
