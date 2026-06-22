//
//  ChapterRowCard.swift
//  PanelSyncc
//
//  Created by Amelia Putri Aftiana on 17/06/26.
//

import SwiftUI

struct ChapterRowCard: View {
    let chapterNumber: Int
    let chapterTitle: String
    let views: Int
    let loves: Int
    let comments: Int
    let imageUrl: String
    
    // State variables for interactivity
    @State private var isLoved: Bool = false
    @State private var showingDownloadAlert: Bool = false
    @State private var isDownloaded: Bool = false
    
    var body: some View {
        HStack(spacing: 12) {
            
            // 1. Image Thumbnail (Handles Web URLs, Local Assets, and Empty Fallbacks)
            if imageUrl.isEmpty {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 100, height: 60)
                    .cornerRadius(4)
                    .overlay(
                        Image(systemName: "photo")
                            .foregroundColor(.gray)
                    )
            } else if imageUrl.hasPrefix("http") {
                AsyncImage(url: URL(string: imageUrl)) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    case .failure(_):
                        Color.gray.opacity(0.3)
                            .overlay(Image(systemName: "photo.badge.exclamationmark").foregroundColor(.gray))
                    case .empty:
                        Color.gray.opacity(0.3)
                            .overlay(ProgressView().tint(.white))
                    @unknown default:
                        Color.gray.opacity(0.3)
                    }
                }
                .frame(width: 100, height: 60)
                .cornerRadius(4)
                .clipped()
            } else {
                // Local Asset Image
                Image(imageUrl)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 60)
                    .cornerRadius(4)
                    .clipped()
            }
            
            // 2. Middle Text Content
            VStack(alignment: .leading, spacing: 6) {
                Text("Ch. \(chapterNumber) - \(chapterTitle)")
                    .font(.chapterCardTItle) // Note: Make sure this matches your custom font
                    .foregroundColor(.white)
                    .lineLimit(1)
                
                // Stats Row
                HStack(spacing: 12) {
                    HStack(spacing: 2) {
                        Image(systemName: "eye.fill").foregroundColor(.gray)
                        Text(views.abbreviated())
                    }
                    HStack(spacing: 2) {
                        Image(systemName: "heart.fill").foregroundColor(.red)
                        Text(loves.abbreviated())
                    }
                    HStack(spacing: 2) {
                        Image(systemName: "text.bubble.fill").foregroundColor(.blue)
                        Text(comments.abbreviated())
                    }
                }
                .font(.caption)
                .foregroundColor(.white.opacity(0.8))
                .lineLimit(1)
                .minimumScaleFactor(0.8)
            }
            
            Spacer(minLength: 4)
            
            // 3. Right Side Actions
            VStack {
                // Heart Button
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        isLoved.toggle()
                    }
                }) {
                    Image(systemName: isLoved ? "heart.fill" : "heart")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(isLoved ? .red : .white)
                }
                
                Spacer()
                
                // Download Button
                Button(action: {
                    // Trigger the alert ONLY if it hasn't been downloaded yet
                    if !isDownloaded {
                        showingDownloadAlert = true
                    }
                }) {
                    // Change icon to a checkmark and color to green if downloaded
                    Image(systemName: isDownloaded ? "checkmark.circle.fill" : "tray.and.arrow.down")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(isDownloaded ? .green : .white)
                }
                // Disable the button so it can't be clicked again
                .disabled(isDownloaded)
                // The Alert Pop-up
                .alert("Download Chapter", isPresented: $showingDownloadAlert) {
                    Button("Yes") {
                        // When "Yes" is clicked, mark as downloaded
                        withAnimation {
                            isDownloaded = true
                        }
                    }
                    Button("No", role: .cancel) {
                        // "No" just dismisses the alert naturally
                    }
                } message: {
                    Text("Are you sure you want to download this chapter?")
                }
            }
            .padding(.vertical, 6)
            .padding(.trailing, 4)
        }
        .padding(10)
        .frame(height: 80)
        .background(Color.panelDark) // Note: Ensure Color.panelDark is defined
        .cornerRadius(12)
    }
}

// Preview
#Preview {
    ZStack {
        Color.white.ignoresSafeArea()
        
        VStack(spacing: 8) {
            ChapterRowCard(
                chapterNumber: 10,
                chapterTitle: "Apayah Ini",
                views: 12500,
                loves: 4500,
                comments: 320,
                imageUrl: "04" // Testing with local asset "04"
            )
        }
    }
}
