//
//  CreatorStudioView.swift
//  PanelSyncc
//
//  Created by Amelia Putri Aftiana on 21/06/26.
//


import SwiftUI

struct CreatorStudioView: View {
    @Environment(\.dismiss) private var dismiss
    
    // 1. Add this state variable to control the navigation
    @State private var showUploadComic: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            // ── 1. Custom Header ──────────────────────────────────────────────
            HStack {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.black)
                        .padding(18)
                        .background(Color.white)
                        .clipShape(Circle())
                        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                }

                Spacer()

                Text("Creator Studio")
                    .font(.rankTitle)
                    .foregroundColor(.panelDark)

                Spacer()

                Color.clear.frame(width: 44, height: 44)
            }
            .padding(.horizontal)
            .padding(.top, 10)
            .padding(.bottom, 12)

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 24) {

                    // ── 2. Upload Button ─────────────────────────────────
                    PrimaryButton(title: "Upload New Stories") {
                        // 2. Trigger the navigation state
                        showUploadComic = true
                    }
                    .padding(.top, 16)

                    Divider()

                    // ── 3. My Stories List ───────────────────────────────
                    Text("My Stories")
                        .font(.otherTitle)
                        .foregroundColor(.panelDark)

                    VStack(spacing: 16) {
                        ForEach(0..<2, id: \.self) { _ in
                            MyStoryCard()
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .background(Color(UIColor.systemGray6).ignoresSafeArea())
        .navigationBarHidden(true)
        // 3. Add the navigation destination here
        .navigationDestination(isPresented: $showUploadComic) {
            UploadComicView()
        }
    }
}

// MARK: - Components

struct MyStoryCard: View {
    var body: some View {
        HStack(spacing: 16) {
            // Image Placeholder
            RoundedRectangle(cornerRadius: 8)
                .fill(Color(white: 0.85))
                .frame(width: 90, height: 120)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Title")
                    .font(.otherTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Text("Chapter")
                    .font(.seeAll)
                    .foregroundColor(.white.opacity(0.7))
                Text("Description")
                    .font(.seeAll)
                    .foregroundColor(.white.opacity(0.7))
                
                Spacer()
                
                HStack {
                    Spacer()
                    Button(action: { /* Manage Story */ }) {
                        HStack(spacing: 6) {
                            Image(systemName: "pencil.and.ellipsis.rectangle")
                            Text("Manage")
                        }
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Color(white: 0.9))
                        .cornerRadius(8)
                    }
                }
            }
            .padding(.vertical, 4)
        }
        .padding(12)
        .background(Color.black)
        .cornerRadius(12)
    }
}

#Preview {
    NavigationStack {
        CreatorStudioView()
    }
}
