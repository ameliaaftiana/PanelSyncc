//
//  TrendingSearchCard.swift
//  PanelSyncc
//
//  Created by Amelia Putri Aftiana on 19/06/26.
//

import SwiftUI

// MARK: - Mini Sub-Component for Trending Searches
struct TrendingSearchCard: View {
    let title: String
    let author: String     // Replaced lastChap with author
    let imageUrl: String
    var onTap: (() -> Void)? = nil

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            
            // Comic Cover Image (Handles Web URLs & Local Assets)
            if imageUrl.hasPrefix("http") {
                AsyncImage(url: URL(string: imageUrl)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .overlay(
                            Image(systemName: "photo")
                                .foregroundColor(.gray)
                        )
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
                    .font(.comicCardPortraitTitle) // Using your custom font
                    .foregroundColor(Color(.label))
                    .lineLimit(1)

                Text(author)
                    .font(.comicCardPortraitBody) // Using your custom font
                    .foregroundColor(.secondary)
                    .lineLimit(1)
            }
        }
        .frame(width: 120)
        .onTapGesture {
            onTap?()
        }
    }
}

// Preview just for this component
#Preview {
    HStack(spacing: 16) {
        TrendingSearchCard(
            title: "Neon Ashes",
            author: "Jane Doe",
            imageUrl: "01" // Testing with Local Asset string
        )
        TrendingSearchCard(
            title: "The Duke's Secret",
            author: "John Smith",
            imageUrl: "05" // Testing with Local Asset string
        )
    }
    .padding()
}
