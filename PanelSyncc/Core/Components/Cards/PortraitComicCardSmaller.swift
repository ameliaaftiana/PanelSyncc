//
//  PortraitComicCardSmaller.swift
//  PanelSyncc
//
//  Created by Amelia Putri Aftiana on 17/06/26.
//

import SwiftUI

struct PortraitComicCardSmaller: View {
    let title: String
    let lastChap: String
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
                    .font(.comicCardPortraitTitle)
                    .foregroundColor(Color(.label))
                    .lineLimit(1)

                Text(lastChap)
                    .font(.comicCardPortraitBody)
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

// Preview
#Preview {
    HStack(spacing: 16) {
        PortraitComicCardSmaller(title: "10th Dimension...", lastChap: "Chap 119", imageUrl: "02")
        PortraitComicCardSmaller(title: "11 of Me", lastChap: "Chap 7", imageUrl: "https://picsum.photos/110/110")
    }
    .padding()
}
