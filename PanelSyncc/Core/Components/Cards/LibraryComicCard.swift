//
//  LibraryComicCard.swift
//  PanelSyncc
//
//  Created by Amelia Putri Aftiana on 18/06/26.
//

import SwiftUI

struct LibraryComicCard: View {
    let genres: [String]
    let title: String
    let description: String
    let imageUrl: String
    let rating: Double
    let readers: Int
    let loves: Int
    let bookmarks: Int
    var onTap: (() -> Void)? = nil

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            let safeUrlString = imageUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? imageUrl
            
            AsyncImage(url: URL(string: safeUrlString)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Rectangle()
                    .fill(Color.gray.opacity(0.4))
                    .overlay(
                        Image(systemName: "photo")
                            .foregroundColor(.gray.opacity(0.8))
                    )
            }
            .frame(width: 100, height: 120)
            .cornerRadius(2)
            .clipped()
            // 3. Content
            VStack(alignment: .leading, spacing: 6) {
                
                // Genre
                Text(genres.prefix(3).joined(separator: " • "))
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(Color(red: 0.6, green: 0.8, blue: 1.0))
                
                // Title
                Text(title)
                    .font(.rankCardFontTitle)
                    .foregroundColor(.white)
                    .lineLimit(1)
                
                // 4-Section Stats Row
                HStack(spacing: 10) {
                    HStack(spacing: 2) {
                        Image(systemName: "star.fill").foregroundColor(.yellow)
                        Text(String(format: "%.1f", rating)).foregroundColor(.white)
                    }
                    HStack(spacing: 2) {
                        Image(systemName: "eye.fill").foregroundColor(.gray)
                        Text(readers.abbreviated()).foregroundColor(.white)
                    }
                    HStack(spacing: 2) {
                        Image(systemName: "heart.fill").foregroundColor(.pink)
                        Text(loves.abbreviated()).foregroundColor(.white)
                    }
                    HStack(spacing: 2) {
                        Image(systemName: "bookmark.fill").foregroundColor(.red)
                        Text(bookmarks.abbreviated()).foregroundColor(.white)
                    }
                }
                .font(.comicCardPortraitBody)
                .lineLimit(1)
                .minimumScaleFactor(0.8)
                
                // Description
                Text(description)
                    .font(.rankCardFontDescription)
                    .foregroundColor(.white.opacity(0.7))
                    .lineLimit(4)
                    .padding(.top, 2)
            }
            
            Spacer(minLength: 0)
        }
        .padding(12)
        .background(Color.panelDark)
        .cornerRadius(12)
        .frame(height: 140)
        .onTapGesture {
            onTap?()
        }
    }
}

// Preview
#Preview {
    ZStack {
        Color(UIColor.darkGray).ignoresSafeArea()
        
        VStack(spacing: 20) {
            LibraryComicCard(
                genres: ["Cyberpunk", "Action", "Sci-Fi"],
                title: "Neon Ashes of Sector 7",
                description: "A rogue AI navigates the dangerous underbelly of a futuristic metropolis, seeking answers to its own existence while hunted by corporate mercenaries.",
                // Test with a real image URL in the preview!
                imageUrl: "https://picsum.photos/100/120",
                rating: 4.9,
                readers: 2500000,
                loves: 89000,
                bookmarks: 310500
            )
            
            LibraryComicCard(
                genres: ["Fantasy", "Romance"],
                title: "The Duke's Secret",
                description: "When an ordinary librarian accidentally discovers the cursed Duke's hidden magical affinity, she is swept into a world of court politics.",
                imageUrl: "https://picsum.photos/100/120",
                rating: 4.7,
                readers: 950000,
                loves: 42100,
                bookmarks: 105000
            )
        }
        .padding()
    }
}
