//
//  CoomentCard.swift
//  PanelSyncc
//
//  Created by Amelia Putri Aftiana on 18/06/26.
//

import SwiftUI

struct DynamicCommentCard: View {
    let username: String
    let commentText: String
    let likes: Int
    let replies: Int
    
    // Tracks if the user liked this specific comment
    @State private var isLiked: Bool = false
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            
            // 1. Avatar (Pinned to the top left)
            Circle()
                .fill(Color.gray.opacity(0.5))
                .frame(width: 44, height: 44)
            
            // 2. Content Stack
            VStack(alignment: .leading, spacing: 8) {
                
                // Username
                Text(username)
                    .font(.commentsUsername) // Or your custom font
                    .foregroundColor(.black)
                
                // Comment Text (Dynamic Height)
                Text(commentText)
                    .font(.rankCardFontDescription)
                    .foregroundColor(.black.opacity(0.8))
                    // NO .lineLimit() here so it can grow to as many lines as needed!
                    .fixedSize(horizontal: false, vertical: true) // Ensures text doesn't truncate in scroll views
                
                // 3. Footer Stats
                HStack(spacing: 16) {
                    Spacer() // Pushes the stats to the right
                    
                    // Interactive Like Button
                    Button(action: {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                            isLiked.toggle()
                        }
                    }) {
                        HStack(spacing: 4) {
                            Text((likes + (isLiked ? 1 : 0)).abbreviated())
                            Image(systemName: isLiked ? "heart.fill" : "heart")
                        }
                        .foregroundColor(isLiked ? .red : .black.opacity(0.8))
                    }
                    
                    // Replies
                    HStack(spacing: 4) {
                        Text(replies.abbreviated())
                        Image(systemName: "text.bubble")
                    }
                    .foregroundColor(.black.opacity(0.8))
                }
                .font(.system(size: 14, weight: .semibold))
                .padding(.top, 4) // Gives a little breathing room above the icons
            }
        }
        .padding(16)
        .background(Color.panelSecondary)
        .cornerRadius(12)
    }
}

// Preview showing a short comment vs a very long comment
#Preview {
    ZStack {
        Color.black.ignoresSafeArea() // Black background to see the gray cards
        
        ScrollView {
            VStack(spacing: 16) {
                // Example 1: Short Comment
                DynamicCommentCard(
                    username: "The Username",
                    commentText: "Short comment here!",
                    likes: 119,
                    replies: 1000
                )
                
                // Example 2: Long Comment (Will automatically grow taller!)
                DynamicCommentCard(
                    username: "The Username",
                    commentText: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum sit amet vestibulum lorem. Vivamus posuere convallis est, a porttitor odio tempor non. Sed lobortis aliquet convallis. Maecenas sed lobortis aliquet convallis.",
                    likes: 42,
                    replies: 3
                )
            }
            .padding()
        }
    }
}
