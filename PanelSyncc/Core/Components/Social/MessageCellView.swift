//
//  MessageCellView.swift
//  PanelSyncc
//
//  Created by Amelia Putri Aftiana on 19/06/26.
//


import SwiftUI

struct MessageCellView: View {
    let username: String
    let lastMessage: String
    let time: String
    let unreadCount: Int
    
    var body: some View {
        HStack(spacing: 12) {
            // 1. Avatar Placeholder
            Circle()
                .fill(Color(white: 0.8))
                .frame(width: 48, height: 48)
            
            // 2. Name and Message
            VStack(alignment: .leading, spacing: 4) {
                Text(username)
                    .font(.friendName)
                    .foregroundColor(.white)
                
                Text(lastMessage)
                    .font(.friendChat)
                    .foregroundColor(.white.opacity(0.8))
                    .lineLimit(2)
            }
            
            Spacer(minLength: 8)
            
            // 3. Time and Unread Badge
            VStack(alignment: .trailing, spacing: 8) {
                Text(time)
                    .font(.caption2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                if unreadCount > 0 {
                    Text("\(unreadCount)")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundColor(.white)
                        .frame(width: 20, height: 20)
                        .background(Color.panelPrimary)
                        .clipShape(Circle())
                } else {
                    Circle()
                        .fill(Color.clear)
                        .frame(width: 20, height: 20)
                }
            }
        }
        .padding(.horizontal, 16)
        // Hardcoded dimensions to exactly match your Figma inspector
        .frame(height: 78)
        .background(Color.panelDark)
        .cornerRadius(12)
    }
}

#Preview {
    ZStack {
        Color(white: 0.95).ignoresSafeArea()
        
        VStack(spacing: 12) {
            MessageCellView(
                username: "NeonShadow",
                lastMessage: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                time: "23.59",
                unreadCount: 1
            )
            
            MessageCellView(
                username: "Amelia",
                lastMessage: "Sounds good, see you tomorrow!",
                time: "08.15",
                unreadCount: 0
            )
        }
    }
}
