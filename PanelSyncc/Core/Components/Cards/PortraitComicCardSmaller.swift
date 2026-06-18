//
//  PortraitComicCardSmaller.swift
//  PanelSyncc
//
//  Created by Amelia Putri Aftiana on 17/06/26.
//


import SwiftUI

struct PortraitComicCardSmaller: View {
    let title: String
    let lastChap: String     // e.g., "Chap 23"
    let imageUrl: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            
            // Comic Cover Image using AsyncImage
            AsyncImage(url: URL(string: imageUrl)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                // Keeps your original gray placeholder while loading
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .overlay(
                        Image(systemName: "photo")
                            .foregroundColor(.gray)
                    )
            }
            .frame(width: 110, height: 110) // Matched the W and H from Figma inspector
            .cornerRadius(12) // Matched the 12px corner radius from Figma
            .clipped()
            
            // Text Content
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.comicCardPortraitTitle)
                    .foregroundColor(Color(.label))
                    .lineLimit(1)

                Text(lastChap)
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
        // Pass a valid image URL to test in preview, or leave blank to see the placeholder
        PortraitComicCardSmaller(title: "10th Dimension...", lastChap: "Chap 119", imageUrl: "https://picsum.photos/110/110")
        PortraitComicCardSmaller(title: "11 of Me", lastChap: "Chap 7", imageUrl: "https://picsum.photos/110/110")
    }
    .padding()
}
