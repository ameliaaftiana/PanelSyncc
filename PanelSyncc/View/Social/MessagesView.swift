//
//  MessagesView.swift
//  PanelSyncc
//
//  Created by Amelia Putri Aftiana on 19/06/26.
//

import SwiftUI

struct MessagesView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var searchText: String = ""
    
    // Sample mock data for the preview
    let mockMessages = [
        ("NeonShadow", "Lorem ipsum dolor sit amet, consectetur adipiscing elit.", "23.59", 1),
        ("NeonShadow", "Lorem ipsum dolor sit amet, consectetur adipiscing elit.", "23.59", 1),
        ("NeonShadow", "Lorem ipsum dolor sit amet, consectetur adipiscing elit.", "23.59", 1),
        ("NeonShadow", "Lorem ipsum dolor sit amet, consectetur adipiscing elit.", "23.59", 1),
        ("NeonShadow", "Lorem ipsum dolor sit amet, consectetur adipiscing elit.", "23.59", 1)
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            // ── 1. Custom Header ──────────────────────────────────────────────
            HStack {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.black)
                        .padding(16)
                        .background(Color.white)
                        .clipShape(Circle())
                        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                }

                Spacer()

                Text("Messages")
                    .font(.rankTitle)
                    .foregroundColor(.panelDark)

                Spacer()

                // FIX: Changed from Button to NavigationLink to push the view smoothly
                NavigationLink(destination: CreateMessagesView()) {
                    Image(systemName: "square.and.pencil")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.black)
                        .padding(12)
                        .background(Color.white)
                        .clipShape(Circle())
                        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                }
            }
            .padding(.horizontal)
            .padding(.top, 10)
            .padding(.bottom, 20)

            // ── 2. Search Bar ─────────────────────────────────────────────────
            HStack(spacing: 20) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                    .font(.system(size: 16, weight: .medium))

                TextField("Search", text: $searchText)
                    .font(.subheadline)
                    .foregroundColor(.black)

                if !searchText.isEmpty {
                    Button(action: { searchText = "" }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                }

                Image(systemName: "mic")
                    .foregroundColor(.gray)
                    .font(.system(size: 16, weight: .medium))
            }
            .padding(.horizontal, 16)
            .frame(height: 50)
            .background(Color.white)
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.05), radius: 6, x: 0, y: 3)
            .padding(.horizontal)
            .padding(.bottom, 20)

            // ── 3. Messages List ──────────────────────────────────────────────
            ScrollView(showsIndicators: false) {
                VStack(spacing: 12) {
                    ForEach(0..<mockMessages.count, id: \.self) { index in
                        let msg = mockMessages[index]

                        NavigationLink(destination: ChatView()) {
                            MessageCellView(
                                username: msg.0,
                                lastMessage: msg.1,
                                time: msg.2,
                                unreadCount: msg.3
                            )
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 40)
            }
        }
        .background(Color(UIColor.systemGray6).ignoresSafeArea())
        .navigationBarHidden(true)
        .toolbar(.hidden, for: .tabBar)
        // FIX: Removed .fullScreenCover entirely
    }
}

#Preview {
    NavigationStack {
        MessagesView()
    }
}
