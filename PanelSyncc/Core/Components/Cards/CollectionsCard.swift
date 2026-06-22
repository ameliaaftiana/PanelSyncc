//
//  CollectionsCard.swift
//  PanelSyncc
//
//  Created by Amelia Putri Aftiana on 18/06/26.
//

import SwiftUI

struct CollectionsCard: View {
    let title: String
    let author: String
    let imageUrl: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // 1. Image Thumbnail (Handles Web URLs, Local Assets, and Empty Fallbacks)
            if imageUrl.isEmpty {
                Rectangle()
                    .fill(Color.gray.opacity(0.3)) // Matched the placeholder from the design
                    .frame(width: 110, height: 110)
                    .cornerRadius(12)
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
                .frame(width: 110, height: 110)
                .cornerRadius(12)
                .clipped()
            } else {
                // Local Asset Image
                Image(imageUrl)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 110, height: 110)
                    .cornerRadius(12)
                    .clipped()
            }
            
            // Text Content
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.comicCardPortraitTitle)
                    .foregroundColor(Color(.label))
                    .lineLimit(1)

                Text(author)
                    .font(.comicCardPortraitBody)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
            }
        }
        .frame(width: 120)
    }
}

// Preview
#Preview {
    HStack(spacing: 16) {
        CollectionsCard(title: "Title", author: "Author Name", imageUrl: "01")
        CollectionsCard(title: "Title", author: "Author Name", imageUrl: "")
    }
    .padding()
}
