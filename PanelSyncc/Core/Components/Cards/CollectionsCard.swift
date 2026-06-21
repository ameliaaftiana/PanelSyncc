//
//  CollectionsCards.swift
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
            // Comic Cover Image Placeholder
            Rectangle()
                .fill(Color.gray.opacity(0.3)) // Matched the black placeholder from the design
                .frame(width: 110, height: 110) //
                .cornerRadius(12)
                .overlay(
                    Image(systemName: "photo")
                        .foregroundColor(.gray)
                )
            
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
        CollectionsCard(title: "Title", author: "Author Name", imageUrl: "")
        CollectionsCard(title: "Title", author: "Author Name", imageUrl: "")
    }
    .padding()
}
