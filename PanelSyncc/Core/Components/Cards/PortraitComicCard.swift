//
//  PortraitComicCard.swift
//  PanelSyncc
//
//  Created by Amelia Putri Aftiana on 18/06/26.
//


import SwiftUI

struct PortraitComicCard: View {
    let title: String
    let rating: String     // e.g., "4.8"
    let readers: String    // e.g., "1.2M" or "10k"
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
            .frame(width: 110, height: 150)
            .cornerRadius(12)
            .clipped()
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.comicCardPortraitTitle)
                    .lineLimit(1)
                
                // Subtitle HStack
                HStack(spacing: 8) {
                    
                    // Section 1: Rating
                    HStack(spacing: 2) {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                            .font(.system(size: 10))
                        Text(rating)
                    }
                    
                    // Section 2: Readers
                    HStack(spacing: 2) {
                        Image(systemName: "eye.fill")
                            .foregroundColor(.gray)
                            .font(.system(size: 10))
                        Text(readers)
                    }
                    
                }
                .font(.comicCardPortraitBody)
                .foregroundColor(.secondary)
                .lineLimit(1)
            }
        }
        .frame(width: 110) // Adjust width based on your grid needs
    }
}

// Preview
#Preview {
    PortraitComicCard(title: "21st Century...", rating: "9.40", readers: "1.8M", imageUrl: "https://picsum.photos/110/150")
}
