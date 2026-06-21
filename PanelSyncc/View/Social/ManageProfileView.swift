//
//  ManageProfileView.swift
//  PanelSyncc
//
//  Created by Amelia Putri Aftiana on 21/06/26.
//


import SwiftUI

struct ManageProfileView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 0) {
            // ── 1. Custom Header ──────────────────────────────────────────────
            HStack {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.black)
                        .padding(16)
                        .background(Color.white)
                        .clipShape(Circle())
                        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                }

                Spacer()

                Text("Manage")
                    .font(.libraryTitle)
                    .foregroundColor(.panelDark)

                Spacer()

                Button(action: { /* Options */ }) {
                    Image(systemName: "ellipsis")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.black)
                        .padding(18)
                        .background(Color.white)
                        .clipShape(Circle())
                        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                }
            }
            .padding(.horizontal)
            .padding(.top, 10)
            .padding(.bottom, 12)

            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {

                    // ── 2. Profile Info ──────────────────────────────────
                    VStack(spacing: 12) {
                        Circle()
                            .fill(Color(white: 0.8))
                            .frame(width: 110, height: 110)
                            .padding(.top, 24)

                        VStack(spacing: 6) {
                            Text("Username")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.white)

                            Text("Lorem ipsum dolor sit amet,\nconsectetur adipiscing elit.")
                                .font(.subheadline)
                                .foregroundColor(.white.opacity(0.8))
                                .multilineTextAlignment(.center)
                        }

                        // Action Buttons
                        HStack(spacing: 16) {
                            Button(action: { /* Follow */ }) {
                                HStack {
                                    Image(systemName: "person.badge.plus")
                                    Text("Follow")
                                }
                                .font(.subheadline).fontWeight(.bold)
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 12)
                                .background(Color(white: 0.9))
                                .cornerRadius(12)
                            }

                            Button(action: { /* Message */ }) {
                                HStack {
                                    Image(systemName: "envelope")
                                    Text("Message")
                                }
                                .font(.subheadline).fontWeight(.bold)
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 12)
                                .background(Color(white: 0.9))
                                .cornerRadius(12)
                            }
                        }
                        .padding(.top, 8)
                        .padding(.horizontal, 24)
                    }

                    // ── 3. Currently Reading ──────────────────────────────
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Currently Reading")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.horizontal, 24)

                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color(white: 0.8))
                            .frame(height: 160)
                            .padding(.horizontal, 24)
                    }

                    // ── 4. Collections ───────────────────────────────────
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Collections")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.horizontal, 24)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(0..<4, id: \.self) { _ in
                                    VStack(alignment: .leading, spacing: 8) {
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(Color(white: 0.8))
                                            .frame(width: 110, height: 110)
                                        Text("Title")
                                            .font(.subheadline)
                                            .fontWeight(.bold)
                                            .foregroundColor(.white)
                                    }
                                }
                            }
                            .padding(.horizontal, 24)
                        }
                    }

                    Spacer(minLength: 40)
                }
            }
        }
        .background(Color(UIColor.systemGray6).ignoresSafeArea())
        .navigationBarHidden(true)
    }
}

#Preview {
    ManageProfileView()
}
