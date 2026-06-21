//
//  CategoryCard.swift
//  PanelSyncc
//
//  Created by Amelia Putri Aftiana on 19/06/26.
//


import SwiftUI

struct CategoryCard: View {
    let title: String
    let seriesCount: Int
    let imageUrl: String
    var onTap: (() -> Void)? = nil

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Image Section
            AsyncImage(url: URL(string: imageUrl)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFill()
                } else if phase.error != nil {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .overlay(Image(systemName: "photo").foregroundColor(.gray))
                } else {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .overlay(ProgressView())
                }
            }
            .frame(height: 50)
            .clipped()
            
            // Text Section
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.commentsUsername)
                    .foregroundColor(.white)
                
                Text("\(seriesCount) Series")
                    .font(.rankCardFontDescription)
                    .foregroundColor(.panelSecondary)
            }
            .padding(12)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.panelDark)
        }
        .cornerRadius(12)
        .onTapGesture {
            onTap?()
        }
    }
}

#Preview {
    HStack {
        CategoryCard(title: "Sci-Fi", seriesCount: 124, imageUrl: "https://picsum.photos/200/200")
        CategoryCard(title: "Fantasy", seriesCount: 312, imageUrl: "https://picsum.photos/201/200")
    }
    .padding()
    .background(Color.black)
}
