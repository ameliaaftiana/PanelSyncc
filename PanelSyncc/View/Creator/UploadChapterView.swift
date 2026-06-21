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
                        .padding(13)
                        .background(Color.white)
                        .clipShape(Circle())
                        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                }

                Spacer()

                Text("Upload Chapter")
                    .font(.libraryTitle)
                    .foregroundColor(.panelDark)

                Spacer()

                // Invisible placeholder to keep the title perfectly centered
                Color.clear.frame(width: 44, height: 44)
            }
            .padding(.horizontal)
            .padding(.top, 10)
            .padding(.bottom, 12)

            // ── 2. Scrollable Content ────────────────────────────────────
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {

                    // Current Series Identifier
                    HStack(spacing: 12) {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.black)
                            .frame(width: 60, height: 60)

                        VStack(alignment: .leading, spacing: 4) {
                            Text("CURRENT SERIES")
                                .font(.system(size: 10, weight: .bold))
                                .foregroundColor(.gray)

                            Text(seriesTitle)
                                .font(.title3)
                                .fontWeight(.bold)
                        }
                        Spacer()
                    }

                    Divider()
                        .padding(.vertical, 8)

                    // Chapter Number Input
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Chapter Number")
                            .font(.headline)
                            .fontWeight(.bold)

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
                            .font(.headline)
                            .fontWeight(.bold)

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
                            .font(.headline)
                            .fontWeight(.bold)

                        Text("Upload comic pages in order.")
                            .font(.caption)
                            .foregroundColor(.panelDark)

                        // Main Upload Button
                        Button(action: {
                            // TODO: Pick Multiple Images
                        }) {
                            VStack(spacing: 8) {
                                Image(systemName: "photo.on.rectangle.angled")
                                    .font(.system(size: 24))
                                    .foregroundColor(.white)
                                Text("Select Pages")
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                Text("JPEG, PNG up 10Mb each")
                                    .font(.caption2)
                                    .foregroundColor(.gray)
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
                                            .foregroundColor(.white)
                                        Text("PG. \(index)")
                                            .font(.caption2)
                                            .fontWeight(.bold)
                                            .foregroundColor(.white)
                                    }
                                }
                            }
                        }
                        .padding(.top, 4)
                    }

                    Spacer(minLength: 24)

                    // ── 3. Publish Button ─────────────────────────────────
                    PrimaryButton(title: "Publish Chapter") {
                        // TODO: Submit data to backend
                        print("Publishing chapter...")
                    }
                }
                .padding(24)
            }
        }
        .background(Color.white.ignoresSafeArea())
        .navigationBarHidden(true)
    }
}

#Preview {
    NavigationStack {
        UploadChapterView(seriesTitle: "Comic Title")
    }
}
