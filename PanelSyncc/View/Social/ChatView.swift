//
//  ChatView.swift
//  PanelSyncc
//
//  Created by Amelia Putri Aftiana on 21/06/26.
//


import SwiftUI

struct ChatView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var messageText: String = ""
    
    var body: some View {
        ZStack(alignment: .top) {
            Color(UIColor.systemGray6).ignoresSafeArea()
            
            VStack(spacing: 0) {
                // ── 1. Header ──────────────────────────────────────────────
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.panelDark)
                            .frame(width: 44, height: 44)
                            .background(Color.white)
                            .clipShape(Circle())
                    }
                    
                    Spacer()
                    
                    VStack(spacing: 2) {
                        Text("Kim Mingyu")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.panelDark)
                        Text("Online")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(.panelDark)
                    }
                    
                    Spacer()
                    
                    Button(action: { /* Actions */ }) {
                        Image(systemName: "ellipsis")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.panelDark)
                            .frame(width: 44, height: 44)
                            .background(Color.white)
                            .clipShape(Circle())
                    }
                }
                .padding(.horizontal)
                .padding(.top, 10)
                .padding(.bottom, 12)
                
                // ── 2. Chat Area ───────────────────────────────────────────
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 16) {
                        
                        // ── Date Pill 1 ──
                        Text("Mon, 8 Jun")
                            .font(.caption)
                            .fontWeight(.medium)
                            .foregroundColor(.panelWhite)
                            .padding(.horizontal, 14)
                            .padding(.vertical, 6)
                            .background(Color.panelDark)
                            .clipShape(Capsule())
                            .padding(.top, 16)
                        
                        // Received Message 1
                        HStack(alignment: .top, spacing: 12) {
                            Circle().fill(Color(white: 0.8)).frame(width: 40, height: 40)
                            ChatBubble(text: "Hey, have you read that new fantasy comic everyone is talking about?", isSentByMe: false)
                            Spacer(minLength: 40)
                        }
                        
                        // Received Message 2
                        HStack(alignment: .top, spacing: 12) {
                            // Invisible circle to keep alignment
                            Circle().fill(Color.clear).frame(width: 40, height: 40)
                            ChatBubble(text: "I think it's called 'Star'. The art style looks absolutely incredible from what I saw.", isSentByMe: false, showTail: false)
                            Spacer(minLength: 40)
                        }
                        
                        // Sent Comic Card
                        HStack(alignment: .top, spacing: 12) {
                            Spacer(minLength: 40)
                            ComicShareCard()
                        }
                        
                        // ── Date Pill 2 ──
                        Text("Tue, 9 Jun")
                            .font(.caption)
                            .fontWeight(.medium)
                            .foregroundColor(.panelWhite)
                            .padding(.horizontal, 14)
                            .padding(.vertical, 6)
                            .background(Color.panelDark)
                            .clipShape(Capsule())
                            .padding(.top, 8)
                        
                        // Received Message 3
                        HStack(alignment: .top, spacing: 12) {
                            Circle().fill(Color(white: 0.8)).frame(width: 40, height: 40)
                            ChatBubble(text: "Yes! That's the exact one. I'm going to start reading it tonight.", isSentByMe: false)
                            Spacer(minLength: 40)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                }

                // ── 3. Bottom Input Bar ────────────────────────────────────
                HStack(spacing: 12) {
                    Button(action: { /* Add attachment */ }) {
                        Image(systemName: "plus")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.panelDark)
                            .frame(width: 44, height: 44)
                            .background(Color.panelSecondary)
                            .clipShape(Circle())
                    }

                    HStack {
                        TextField("Text Message", text: $messageText)
                            .foregroundColor(.panelDark)

                        Button(action: { /* Voice memo */ }) {
                            Image(systemName: "mic")
                                .foregroundColor(.panelDark)
                        }
                    }
                    .padding(.horizontal, 16)
                    .frame(height: 44)
                    .background(Color.panelSecondary)
                    .cornerRadius(22)

                    Button(action: { /* Send message */ }) {
                        Image(systemName: "paperplane.fill")
                            .font(.system(size: 20))
                            .foregroundColor(.black)
                            .frame(width: 44, height: 44)
                            .background(Color.panelSecondary)
                            .clipShape(Circle())
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 16)
            }
        }
        .navigationBarHidden(true)
        .toolbar(.hidden, for: .tabBar)
    }
}

// MARK: - Chat Components

struct ChatBubble: View {
    let text: String
    let isSentByMe: Bool
    var showTail: Bool = true

    var body: some View {
        Text(text)
            .font(.subheadline)
            .foregroundColor(isSentByMe ? .white : .black)
            .padding(16)
            .background(isSentByMe ? Color.panelDark : Color.panelSecondary)
            .clipShape(ChatBubbleShape(isSentByMe: isSentByMe, showTail: showTail))
    }
}

struct ComicShareCard: View {
    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 12) {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.panelPrimary)
                    .frame(width: 60, height: 60)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Star")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.panelWhite)
                    Text("By The Creator")
                        .font(.caption)
                        .foregroundColor(.panelWhite)
                    Text("Rating: 4.5")
                        .font(.caption2)
                        .foregroundColor(.panelWhite)
                }
                Spacer()
            }
            
            NavigationLink(destination: mockDestinationView()) {
                HStack(spacing: 8) {
                    Image(systemName: "book")
                    Text("Read Now")
                }
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundColor(.panelDark)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .background(Color.panelSecondary)
                .cornerRadius(12)
            }
        }
        .padding(12)
        .background(Color.panelDark)
        .clipShape(ChatBubbleShape(isSentByMe: true, showTail: true))
        .frame(maxWidth: 260)
    }
    
    // Helper to generate the ComicDetailView with comprehensive mock data
    private func mockDestinationView() -> some View {
        ComicDetailView(
            webtoon: Webtoon(
                id: 1193,
                title: "Star",
                author: "The Creator",
                genre: "Fantasy",
                thumbnail: "https://picsum.photos/seed/webtoon1193/300/420",
                summary: "In a world where magic is drawn from the constellations, Elara is born under a dark, forgotten star. Shunned by the luminous society of the Skyweavers, she must conceal her true powers. But when a celestial phenomenon threatens to extinguish the sun itself, Elara is forced to team up with a fallen knight. Together, they embark on a perilous journey across the astral plains to uncover the truth behind her origin and save their world from eternal night.",
                episodes: 64,
                view: "31K",
                like: "12.4K",
                subscribe: "5.3K",
                rating: 4.5,
                status: .ongoing
            ),
            chapters: [
                ComicChapter(id: "ch-010", comicId: 1193, chapterNumber: 10, title: "The Celestial Anomaly", views: 12500, loves: 4500, comments: 320, imageUrl: ""),
                ComicChapter(id: "ch-009", comicId: 1193, chapterNumber: 9, title: "Whispers of the Fallen", views: 11000, loves: 4000, comments: 290, imageUrl: ""),
                ComicChapter(id: "ch-008", comicId: 1193, chapterNumber: 8, title: "The Skyweaver's Decree", views: 9800, loves: 3500, comments: 260, imageUrl: ""),
                ComicChapter(id: "ch-007", comicId: 1193, chapterNumber: 7, title: "Shadows in the Starlight", views: 8500, loves: 3000, comments: 230, imageUrl: ""),
                ComicChapter(id: "ch-006", comicId: 1193, chapterNumber: 6, title: "A Reluctant Alliance", views: 8100, loves: 2800, comments: 210, imageUrl: ""),
                ComicChapter(id: "ch-005", comicId: 1193, chapterNumber: 5, title: "Echoes of the Dark Star", views: 7900, loves: 2500, comments: 195, imageUrl: "")
            ],
            comments: [
                ComicComment(
                    id: "cmt-001",
                    comicId: 1193,
                    user: CommentUser(id: "usr-101", username: "AvidReader", avatarUrl: nil),
                    rating: 5,
                    text: "The world-building in this series is phenomenal! Can't wait for the next chapter.",
                    likes: 342,
                    replies: 15,
                    isLikedByCurrentUser: true,
                    createdAt: Date()
                ),
                ComicComment(
                    id: "cmt-002",
                    comicId: 1193,
                    user: CommentUser(id: "usr-102", username: "FantasyGeek", avatarUrl: nil),
                    rating: 4,
                    text: "Art is 10/10. The pacing is a bit slow right now, but the mystery keeps me hooked.",
                    likes: 89,
                    replies: 4,
                    isLikedByCurrentUser: false,
                    createdAt: Date().addingTimeInterval(-86400)
                )
            ],
            featuredCollections: [
                ComicCollection(id: "col-1", title: "Top Fantasy 2026", author: "Curator", imageUrl: ""),
                ComicCollection(id: "col-2", title: "Must Reads", author: "Admin", imageUrl: "")
            ],
            peopleAlsoLike: []
        )
    }
}

// Custom Shape to draw the chat bubble with the little tail
struct ChatBubbleShape: Shape {
    var isSentByMe: Bool
    var showTail: Bool
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let radius: CGFloat = 16
        
        path.addRoundedRect(in: rect, cornerSize: CGSize(width: radius, height: radius))
        
        if showTail {
            if isSentByMe {
                path.move(to: CGPoint(x: rect.maxX, y: rect.midY - 8))
                path.addLine(to: CGPoint(x: rect.maxX + 8, y: rect.midY))
                path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY + 8))
            } else {
                path.move(to: CGPoint(x: rect.minX, y: rect.midY - 8))
                path.addLine(to: CGPoint(x: rect.minX - 8, y: rect.midY))
                path.addLine(to: CGPoint(x: rect.minX, y: rect.midY + 8))
            }
        }
        return path
    }
}

fileprivate struct ChatRoundedCornerShape: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

#Preview {
    NavigationStack {
        ChatView()
    }
}
