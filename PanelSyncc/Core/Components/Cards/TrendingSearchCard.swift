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
            
            // Comic Cover Image using AsyncImage
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
            imageUrl: "https://picsum.photos/110/110"
        )
        TrendingSearchCard(
            title: "The Duke's Secret", 
            author: "John Smith", 
            imageUrl: "https://picsum.photos/110/111"
        )
    }
    .padding()
}
