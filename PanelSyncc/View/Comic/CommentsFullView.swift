//
//  CommentFullView.swift
//  PanelSyncc
//
//  Created by Amelia Putri Aftiana on 21/06/26.
//


import SwiftUI

struct CommentsFullView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var commentText: String = ""
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.panelDark.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // ── 1. Header (Light Gray) ─────────────────────────────────────────
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.black)
                            .padding(14)
                            .background(Color.white)
                            .clipShape(Circle())
                            .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                    }
                    
                    Spacer()
                    
                    Text("Comments")
                        .font(.rankTitle)
                        .foregroundColor(.panelDark)
                    
                    Spacer()
                    
                    Color.clear.frame(width: 44, height: 44)
                }
                .padding(.horizontal)
                .padding(.top, 0)
                .padding(.bottom, 10)
                .background(
                    Color(UIColor.systemGray6)
                        .ignoresSafeArea(edges: .top)
                )
                
                // ── 2. Comments List ──────────────────────────────────────────────
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 16) {
                        ForEach(0..<6, id: \.self) { _ in
                            // Using your existing DynamicCommentCard
                            DynamicCommentCard(
                                username: "The Username",
                                commentText: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum sit amet vestibulum lorem. Vivamus posuere convallis est, a porttitor odio tempor non. Sed lobortis aliquet convallis. Maecenas",
                                likes: 119,
                                replies: 1000
                            )
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 24)
                    .padding(.bottom, 24)
                }
                
                // ── 3. Bottom Input Bar ────────────────────────────────────────────
                HStack(spacing: 12) {
                    Button(action: { /* Emoji */ }) {
                        Image(systemName: "face.smiling")
                            .font(.system(size: 22))
                            .foregroundColor(.panelDark)
                            .frame(width: 44, height: 44)
                            .background(Color.panelSecondary)
                            .clipShape(Circle())
                    }
                    
                    HStack {
                        TextField("Text Message", text: $commentText)
                            .foregroundColor(.black)
                        
                        Button(action: { /* Voice Memo */ }) {
                            Image(systemName: "mic")
                                .foregroundColor(.black)
                        }
                    }
                    .padding(.horizontal, 16)
                    .frame(height: 44)
                    .background(Color.panelSecondary)
                    .cornerRadius(22)
                    
                    Button(action: { /* Send */ }) {
                        Image(systemName: "paperplane.fill")
                            .font(.system(size: 20))
                            .foregroundColor(.black)
                            .frame(width: 44, height: 44)
                            .background(Color.panelSecondary)
                            .clipShape(Circle())
                    }
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 16)
                .background(Color.panelDark)
            }
        }
        .navigationBarHidden(true)
        .toolbar(.hidden, for: .tabBar)
    }
}

#Preview {
    CommentsFullView()
}
