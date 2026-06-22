//
//  TopPicksCard.swift
//  PanelSyncc
//
//  Created by Amelia Putri Aftiana on 17/06/26.
//

import SwiftUI

struct TopPicksCard: View {
    let title: String
    let description: String
    let genre: String
    let imageUrl: String
    let rating: Double
    let readers: Int
    let loves: Int
    let bookmarks: Int
    var onTap: (() -> Void)? = nil

    var body: some View {
        ZStack(alignment: .leading) {
            
            // 1. Background Image (Handles Web URLs & Local Assets)
            if imageUrl.hasPrefix("http") {
                AsyncImage(url: URL(string: imageUrl)) { phase in
                    switch phase {
                    case .empty:
                        ZStack {
                            Color(red: 0.1, green: 0.2, blue: 0.5)
                            ProgressView().tint(.white)
                        }
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                    case .failure:
                        ZStack {
                            Color(red: 0.1, green: 0.2, blue: 0.5)
                            HStack {
                                Spacer()
                                Image(systemName: "photo.badge.exclamationmark")
                                    .font(.system(size: 40))
                                    .foregroundColor(.white.opacity(0.3))
                                    .padding(.trailing, 40)
                            }
                        }
                    @unknown default:
                        Color(red: 0.1, green: 0.2, blue: 0.5)
                    }
                }
                .frame(width: 346, height: 150)
                .clipped()
            } else {
                // Local Asset Image
                Image(imageUrl)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 346, height: 150)
                    .clipped()
            }
            
            // 2. Gradient Overlay (Keeps your text legible)
            LinearGradient(
                gradient: Gradient(colors: [Color.black.opacity(0.9), Color.black.opacity(0.0)]),
                startPoint: .leading,
                endPoint: .trailing
            )
            
            // 3. Text Content
            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .font(.cardTopPicksTitle)
                    .foregroundColor(.white)
                    .lineLimit(1)
                
                Text(description)
                    .font(.cardTopPicksDescription)
                    .foregroundColor(.white.opacity(0.8))
                    .lineLimit(3)
                    .padding(.bottom, 4)
                
                // 4-Section Stats Row
                HStack(spacing: 10) {
                    // Section 1: Rating
                    HStack(spacing: 2) {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        Text(String(format: "%.1f", rating))
                            .foregroundColor(.white)
                    }
                    
                    // Section 2: Readers
                    HStack(spacing: 2) {
                        Image(systemName: "eye.fill")
                            .foregroundColor(.gray)
                        Text(readers.abbreviated())
                            .foregroundColor(.white)
                    }
                    
                    // Section 3: Loves
                    HStack(spacing: 2) {
                        Image(systemName: "heart.fill")
                            .foregroundColor(.pink)
                        Text(loves.abbreviated())
                            .foregroundColor(.white)
                    }
                    
                    // Section 4: Bookmarks
                    HStack(spacing: 2) {
                        Image(systemName: "bookmark.fill")
                            .foregroundColor(.blue)
                        Text(bookmarks.abbreviated())
                            .foregroundColor(.white)
                    }
                }
                .font(.comicCardPortraitBody)
                .lineLimit(1)
                .minimumScaleFactor(0.8)
                
                Text(genre)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(.white)
                    .padding(.top, 2)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 16)
            .frame(width: 260, alignment: .leading)
        }
        .frame(width: 346, height: 150)
        .cornerRadius(16)
        .onTapGesture {
            onTap?()
        }
    }
}

// Preview
#Preview {
    TopPicksCard(
        title: "I'm the Queen in This Life",
        description: "The Etruscan Kingdom is stained with blood when the king's illegitimate son Cesare conspires with his fiancée...",
        genre: "Fantasy",
        imageUrl: "01", // Testing with a local asset name
        rating: 4.8,
        readers: 1200000,
        loves: 45500,
        bookmarks: 113567
    )
}
