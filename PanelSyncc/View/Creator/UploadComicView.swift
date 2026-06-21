//
//  UploadComicView.swift
//  PanelSyncc
//
//  Created by Amelia Putri Aftiana on 21/06/26.
//

import SwiftUI

struct UploadComicView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var comicTitle: String = ""
    @State private var genres: String = ""
    @State private var synopsis: String = ""

    @State private var navigateToChapter: Bool = false

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

                Text("Upload")
                    .font(.rankTitle)
                    .foregroundColor(.panelDark)

                Spacer()

                // Invisible placeholder to keep the title perfectly centered
                Color.clear.frame(width: 44, height: 44)
            }
            .padding(.horizontal)
            .padding(.top, 10)
            .padding(.bottom, 20)

            // ── 2. Scrollable Form Content ───────────────────────────────
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {

                    // Cover Upload Area
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Cover")
                            .font(.otherTitle)

                        Button(action: {
                            // TODO: Select Image Action
                        }) {
                            RoundedRectangle(cornerRadius: 12)
                                .strokeBorder(Color.panelDark, style: StrokeStyle(lineWidth: 2, dash: [6]))
                                .frame(height: 160)
                                .background(Color.white)
                        }
                    }

                    // Title Input
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Title")
                            .font(.otherTitle)

                        TextField("Enter comic title", text: $comicTitle)
                            .padding()
                            .frame(height: 50)
                            .background(Color.panelDark)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }

                    // Genres Input
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Genres")
                            .font(.otherTitle)

                        TextField("e.g., Action, Fantasy, Romance", text: $genres)
                            .foregroundColor(.white)
                            .padding()
                            .frame(height: 50)
                            .background(Color.panelDark)
                            .cornerRadius(12)
                    }

                    // Synopsis Input
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Synopsis")
                            .font(.otherTitle)

                        ZStack(alignment: .topLeading) {
                            if synopsis.isEmpty {
                                Text("Enter comic synopsis...")
                                    .foregroundColor(.white)
                                    .padding(12)
                            }
                            TextEditor(text: $synopsis)
                                .padding(8)
                                .frame(height: 120)
                                .scrollContentBackground(.hidden)
                                .background(Color.panelDark)
                                .foregroundColor(.white)
                                .cornerRadius(12)
                        }
                    }

                    Spacer(minLength: 0)

                    // ── 3. Continue Button ─────────────────────────────────
                    PrimaryButton(title: "Continue") {
                        navigateToChapter = true
                    }
                }
                .padding(.horizontal)
            }
        }
        .background(Color(UIColor.systemGray6).ignoresSafeArea())
        .navigationBarHidden(true)
        .navigationDestination(isPresented: $navigateToChapter) {
            UploadChapterView(seriesTitle: comicTitle.isEmpty ? "Comic Title" : comicTitle)
        }
    }
}

#Preview {
    NavigationStack {
        UploadComicView()
    }
}
