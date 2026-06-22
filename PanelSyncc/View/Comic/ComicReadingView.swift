//
//  ComicReadingView.swift
//  PanelSyncc
//
//  Created by Amelia Putri Aftiana on 18/06/26.
//

import SwiftUI

struct ComicReadingView: View {
    let chapterNumber: Int
    @Environment(\.dismiss) private var dismiss
    
    @State private var isLoved: Bool = false
    
    var body: some View {
        ZStack {
            // ── 1. Main Comic Content & End Section (Black Background) ─────────
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    ForEach(0..<3, id: \.self) { _ in
                        Image("comic")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity)
                    }
                    
                    // ── END OF CHAPTER SECTION ──
                    VStack(spacing: 32) {
                        Text("- End of Chapter -")
                            .font(.otherTitle)
                            .foregroundColor(.panelSecondary)
                            .padding(.top, 40)
                        
                        VStack(alignment: .leading, spacing: 16) {
                            HStack {
                                Text("Comments (127)")
                                    .font(.otherTitle)
                                    .foregroundColor(.panelWhite)
                                
                                Spacer()
                                
                                NavigationLink(destination: CommentsFullView()) {
                                    Text("See All")
                                        .font(.seeAll)
                                        .foregroundColor(.white)
                                        .underline()
                                }
                            }
                            
                            // Fake "Post a comment" input box
                            NavigationLink(destination: CommentsFullView()) {
                                HStack {
                                    Circle()
                                        .fill(Color(white: 0.85))
                                        .frame(width: 32, height: 32)
                                    
                                    Text("Post a comment...")
                                        .font(.subheadline)
                                        .foregroundColor(.black.opacity(0.7))
                                    
                                    Spacer()
                                    
                                    Image(systemName: "paperplane.fill")
                                        .foregroundColor(.panelDark)
                                }
                                .padding(12)
                                .background(Color.panelSecondary)
                                .cornerRadius(25)
                            }
                            .buttonStyle(PlainButtonStyle())
                            
                            // Using your existing DynamicCommentCard
                            DynamicCommentCard(
                                username: "The Username",
                                commentText: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum sit amet vestibulum lorem. Vivamus posuere convallis est, a porttitor odio tempor non. Sed lobortis aliquet convallis. Maecenas",
                                likes: 119,
                                replies: 1000
                            )
                            
                            DynamicCommentCard(
                                username: "The Username",
                                commentText: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum sit amet vestibulum lorem. Vivamus posuere convallis est, a porttitor odio tempor non. Sed lobortis aliquet convallis. Maecenas",
                                likes: 119,
                                replies: 1000
                            )
                        }
                        .padding(.horizontal, 24)
                    }
                    .padding(.bottom, 150) // Room for the bottom toolbar
                }
            }
            .ignoresSafeArea()
            .background(Color.panelDark)
            
            // ── 2. Overlay Toolbars ─────────────────────────────────────────
            VStack {
                // Top Navigation Bar
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.black)
                            .padding(14)
                            .background(Color.white)
                            .clipShape(Circle())
                            .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                    }
                    
                    Spacer()
                    
                    Text("Chapter \(chapterNumber)")
                        .font(.rankTitle)
                        .foregroundColor(.panelDark)
                    
                    Spacer()
                    
                    Button(action: {
                        withAnimation { isLoved.toggle() }
                    }) {
                        Image(systemName: isLoved ? "heart.fill" : "heart")
                            .font(.system(size: 22, weight: .semibold))
                            .foregroundColor(isLoved ? .red : .panelDark)
                    }
                }
                .padding(.horizontal, 24)
                .padding(.top, 56)
                .padding(.bottom, 16)
                .background(Color(UIColor.systemGray6))
                .ignoresSafeArea(edges: .top)
                
                Spacer()
                
                // Bottom Toolbar
                HStack {
                    Spacer()
                    Button(action: {
                        // TODO: Toggle Light/Dark Mode
                    }) {
                        Image(systemName: "sun.max")
                            .font(.system(size: 22))
                            .foregroundColor(.panelDark)
                    }
                    
                    Spacer()
                    
                    HStack(spacing: 16) {
                        Button(action: { /* Previous */ }) {
                            Image(systemName: "backward.end")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.panelDark)
                                .frame(width: 54, height: 54)
                                .background(.ultraThinMaterial)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.white.opacity(0.6), lineWidth: 0))
                                .shadow(color: .black.opacity(0.15), radius: 8, x: 0, y: 4)
                        }
                        
                        Button(action: { /* Chapter List */ }) {
                            Image(systemName: "list.bullet")
                                .font(.system(size: 28, weight: .semibold))
                                .foregroundColor(.panelDark)
                                .frame(width: 72, height: 72)
                                .background(.ultraThinMaterial)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.white.opacity(0.6), lineWidth: 0))
                                .shadow(color: .black.opacity(0.15), radius: 10, x: 0, y: 5)
                        }
                        
                        Button(action: { /* Next */ }) {
                            Image(systemName: "forward.end")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.panelDark)
                                .frame(width: 54, height: 54)
                                .background(.ultraThinMaterial)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.white.opacity(0.6), lineWidth: 0))
                                .shadow(color: .black.opacity(0.15), radius: 8, x: 0, y: 4)
                        }
                    }
                    
                    Spacer()
                    
                    Button(action: { /* Settings */ }) {
                        Image(systemName: "gearshape")
                            .font(.system(size: 22))
                            .foregroundColor(.panelDark)
                    }
                    Spacer()
                }
                .padding(.horizontal, 24)
                .padding(.top, 16)
                .padding(.bottom, 34)
                .background(Color(UIColor.systemGray6))
                .ignoresSafeArea(edges: .bottom)
            }
        }
        .navigationBarHidden(true)
        .toolbar(.hidden, for: .tabBar)
    }
}


#Preview {
    NavigationStack {
        ComicReadingView(chapterNumber: 10)
    }
}
