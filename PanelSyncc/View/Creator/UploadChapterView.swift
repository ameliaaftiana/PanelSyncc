//
//  UploadChapterView.swift
//  PanelSyncc
//
//  Created by Amelia Putri Aftiana on 21/06/26.
//

import SwiftUI

struct UploadChapterView: View {
    @Environment(\.dismiss) private var dismiss

    // Passed in from the previous screen
    var seriesTitle: String
    
    // FIX: Binding to allow popping back to CreatorStudio
    @Binding var rootIsActive: Bool

    @State private var chapterNumber: String = ""
    @State private var chapterTitle: String = ""

    var body: some View {
        VStack(spacing: 0) {
            // ── 1. Header ──────────────────────────────────────────────
            HStack {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.black)
                        .padding(18)
                        .background(Color.white)
                        .clipShape(Circle())
                        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                }

                Spacer()

                Text("Upload Chapter")
                    .font(.rankTitle)
                    .foregroundColor(.panelDark)

                Spacer()

                // Invisible placeholder to keep the title perfectly centered
                Color.clear.frame(width: 44, height: 44)
            }
            .padding(.horizontal)
            .padding(.top, 10)
            .padding(.bottom, 20)

            // ── 2. Scrollable Content ────────────────────────────────────
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {

                    // Current Series Identifier
                    HStack(spacing: 20) {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.black)
                            .frame(width: 60, height: 60)

                        VStack(alignment: .leading, spacing: 4) {
                            Text("CURRENT SERIES")
                                .font(.onboardingSkip)
                                .foregroundColor(.panelSecondary)

                            Text(seriesTitle)
                                .font(.rankCardFont)
                        }
                        Spacer()
                    }

                    Divider()
                        .padding(.vertical, 8)

                    // Chapter Number Input
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Chapter Number")
                            .font(.otherTitle)

                        TextField("Enter chapter number", text: $chapterNumber)
                            .keyboardType(.numberPad)
                            .padding()
                            .frame(height: 50)
                            .background(Color.panelDark)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }

                    // Chapter Title Input
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Chapter Title")
                            .font(.otherTitle)

                        TextField("Enter chapter title", text: $chapterTitle)
                            .padding()
                            .frame(height: 50)
                            .background(Color.panelDark)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }

                    // Pages Upload Area
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Pages")
                            .font(.otherTitle)

                        Text("Upload comic pages in order.")
                            .font(.onboardingSkip)
                            .foregroundColor(.panelPrimary)

                        // Main Upload Button
                        Button(action: {
                            // TODO: Pick Multiple Images
                        }) {
                            VStack(spacing: 8) {
                                Image(systemName: "photo.on.rectangle.angled")
                                    .font(.system(size: 24))
                                    .foregroundColor(.panelSecondary)
                                Text("Select Pages")
                                    .font(.otherTitle)
                                    .foregroundColor(.panelSecondary)
                                Text("JPEG, PNG up 10Mb each")
                                    .font(.caption2)
                                    .foregroundColor(.panelSecondary)
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 140)
                            .background(Color.panelDark)
                            .cornerRadius(12)
                        }

                        // Uploaded Pages Grid Preview
                        HStack(spacing: 12) {
                            ForEach(1...3, id: \.self) { index in
                                ZStack {
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color.panelDark)
                                        .aspectRatio(1, contentMode: .fit)

                                    VStack(spacing: 4) {
                                        Image(systemName: "photo")
                                            .foregroundColor(.panelSecondary)
                                        Text("PG. \(index)")
                                            .font(.caption2)
                                            .fontWeight(.bold)
                                            .foregroundColor(.panelSecondary)
                                    }
                                }
                            }
                        }
                        .padding(.top, 4)
                    }

                    Spacer(minLength:0 )

                    // ── 3. Publish Button ─────────────────────────────────
                    PrimaryButton(title: "Publish Chapter") {
                        // TODO: Submit data to backend
                        print("Publishing chapter...")
                        // FIX: Setting to false dismisses this view AND UploadComicView at once
                        rootIsActive = false
                    }
                }
                .padding(.horizontal)
            }
        }
        .background(Color(UIColor.systemGray6).ignoresSafeArea())
        .navigationBarHidden(true)
        .toolbar(.hidden, for: .tabBar) // FIX: Hides Tab Bar
    }
}

#Preview {
    NavigationStack {
        UploadChapterView(seriesTitle: "Comic Title", rootIsActive: .constant(true))
    }
}
