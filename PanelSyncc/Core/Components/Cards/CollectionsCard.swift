//
//  CollectionsCards.swift
//  PanelSyncc
//
//  Created by Amelia Putri Aftiana on 18/06/26.
//


import SwiftUI

struct CollectionsCard: View {
    let title: String
    let author: String     // e.g., "Chap 23"
    let imageUrl: String   // Or use a local image name for now
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Comic Cover Image Placeholder
            Rectangle()
                .fill(Color.gray.opacity(0.3)) // Matched the black placeholder from the design
                .frame(width: 110, height: 110) // Matched the W and H from Figma inspector
                .cornerRadius(12) // Matched the 12px corner radius from Figma
                .overlay(
                    // You can replace this with AsyncImage when hooking up your backend
                    Image(systemName: "photo")
                        .foregroundColor(.gray)
                )
            
            // Text Content
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    // Implementing the custom font for headings
                    .font(.comicCardPortraitTitle)
                    .foregroundColor(Color(.label))
                    .lineLimit(1)

                Text(author)
                    // Implementing the custom font for the body
                    .font(.comicCardPortraitBody)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
            }
        }
        // ONLY lock the width to match the image width.
        // Do NOT set a fixed height here, so the text has room to breathe!
        .frame(width: 120)
    }
}

// Preview
#Preview {
    HStack(spacing: 16) {
        CollectionsCard(title: "Title", author: "Author Name", imageUrl: "")
        CollectionsCard(title: "Title", author: "Author Name", imageUrl: "")
    }
    .padding()
}
