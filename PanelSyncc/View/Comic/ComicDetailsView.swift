//
//  ComicDetailView.swift
//  PanelSyncc
//
//  Created by Amelia Putri Aftiana on 18/06/26.
//

import SwiftUI

// MARK: - ComicDetailView

struct ComicDetailView: View {
    @StateObject private var dataLoader = WebtoonDataLoader()
    let webtoon: Webtoon
    let chapters: [ComicChapter]
    let comments: [ComicComment]
    let featuredCollections: [ComicCollection]
    let peopleAlsoLike: [ComicCollection]
    
    @State private var isBookmarked: Bool = false
    @State private var showFullSynopsis: Bool = false
    @State private var showRatingPopup: Bool = false
    @State private var scrollOffset: CGFloat = 0
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 0) {
                // ── 1. Header Image ────────────────────────────────────────
                ZStack(alignment: .bottom) {
                    
                    // Handles both Web URLs and Local Assets
                    if webtoon.thumbnail.hasPrefix("http") {
                        AsyncImage(url: webtoon.thumbnailURL) { phase in
                            switch phase {
                            case .success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                            case .failure(_):
                                Color.gray.opacity(0.25)
                                    .overlay(
                                        Image(systemName: "photo")
                                            .font(.system(size: 40))
                                            .foregroundColor(.gray)
                                    )
                            case .empty:
                                Color.gray.opacity(0.25)
                                    .overlay(ProgressView().tint(.white))
                            @unknown default:
                                Color.gray.opacity(0.25)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 280)
                        .clipped()
                    } else {
                        // Local Asset Image
                        Image(webtoon.thumbnail)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(maxWidth: .infinity)
                            .frame(height: 280)
                            .clipped()
                    }
                    
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color.clear,
                            Color(UIColor.systemBackground).opacity(0.3),
                            Color(UIColor.systemBackground)
                        ]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                }
                
                // ── Main Content VStack ────────────────────────────────────
                VStack(alignment: .leading, spacing: 20) {
                    
                    // ── 2. Rating & Genres ─────────────────────────────────
                    VStack(alignment: .leading, spacing: 10) {
                        
                        Button(action: {
                            showRatingPopup = true
                        }) {
                            StarRatingView(rating: webtoon.rating)
                        }
                        
                        HStack(spacing: 8) {
                            Text(webtoon.genre)
                                .font(.caption)
                                .padding(.horizontal)
                                .padding(.vertical, 4)
                                .background(Color.gray.opacity(0.2))
                                .foregroundColor(.primary)
                                .clipShape(Capsule())
                        }
                    }
                    .padding(.horizontal)
                    
                    // ── 3. Title, Author, Quick-Stats ──────────────────────
                    VStack(alignment: .leading, spacing: 6) {
                        Text(webtoon.title)
                            .font(.libraryTitle)
                            .foregroundColor(.panelDark)
                        
                        Text("By \(webtoon.author)")
                            .font(.rankCardFontDescription)
                            .foregroundColor(.panelPrimary)
                        
                        HStack(spacing: 6) {
                            QuickStatChip(icon: "heart.fill", value: webtoon.like)
                            Text("·").foregroundColor(.secondary)
                            QuickStatChip(icon: "bookmark.fill", value: webtoon.subscribe)
                            Text("·").foregroundColor(.secondary)
                            QuickStatChip(icon: "eye.fill", value: webtoon.view)
                            Text("·").foregroundColor(.secondary)
                            Text(webtoon.status.displayName)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(.horizontal)
                    
                    // ── 4. Action Buttons ──────────────────────────────────
                    HStack(spacing: 12) {
                        NavigationLink(destination: ComicReadingView(chapterNumber: chapters.first?.chapterNumber ?? 1)) {
                            HStack(spacing: 8) {
                                Image(systemName: "book")
                                    .font(.system(size: 15, weight: .semibold))
                                Text("Read First Chapter")
                                    .font(.buttonFontOnboard)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(Color.panelDark)
                            .foregroundColor(Color.panelWhite)
                            .cornerRadius(12)
                        }
                        
                        Button {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                isBookmarked.toggle()
                            }
                        } label: {
                            Image(systemName: isBookmarked ? "bookmark.fill" : "bookmark")
                                .font(.system(size: 18, weight: .semibold))
                                .padding(16)
                                .background(Color.panelDark)
                                .foregroundColor(Color.panelWhite)
                                .cornerRadius(12)
                        }
                    }
                    .padding(.horizontal)
                    
                    // ── 5. Synopsis ────────────────────────────────────────
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Text("Synopsis")
                                .font(.subHead)
                            Spacer()
                            Button(showFullSynopsis ? "Show Less" : "Read More") {
                                withAnimation(.easeInOut) {
                                    showFullSynopsis.toggle()
                                }
                            }
                            .font(.seeAll)
                            .underline()
                            .foregroundColor(.panelSecondary)
                        }
                        
                        Text(webtoon.summary)
                            .font(.body)
                            .foregroundColor(.secondary)
                            .lineLimit(showFullSynopsis ? nil : 3)
                            .multilineTextAlignment(.leading)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding(.horizontal)
                    
                    // ── 6. Chapters ────────────────────────────────────────
                    VStack(alignment: .leading, spacing: 12) {
                        SectionHeader(title: "Chapters") {
                            // Navigate to full chapters list
                        }
                        .padding(.horizontal)
                        
                        VStack(spacing: 8) {
                            ForEach(chapters.prefix(4)) { chapter in
                                NavigationLink(destination: ComicReadingView(chapterNumber: chapter.chapterNumber)) {
                                    ChapterRowCard(
                                        chapterNumber: chapter.chapterNumber,
                                        chapterTitle: chapter.title,
                                        views: chapter.views,
                                        loves: chapter.loves,
                                        comments: chapter.comments,
                                        imageUrl: chapter.imageUrl.isEmpty ? String(format: "%02d", Int.random(in: 1...10)) : chapter.imageUrl
                                    )
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    // ── 7. Comments ────────────────────────────────────────
                    VStack(alignment: .leading, spacing: 16) {
                        SectionHeader(title: "Comments") {
                            // Navigate to all comments screen
                        }
                        .padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(comments.prefix(5)) { comment in
                                    RatingCommentCard(
                                        username: comment.user.username,
                                        rating: comment.rating,
                                        commentText: comment.text,
                                        likes: comment.likes,
                                        replies: comment.replies
                                    )
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    
                    // ── 8. Featured in Collections ─────────────────────────
                    VStack(alignment: .leading, spacing: 12) {
                        SectionHeader(title: "Featured in Collections") {
                            // Navigate to full collections list
                        }
                        .padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(featuredCollections) { item in
                                    CollectionsCard(
                                        title: item.title,
                                        author: item.author,
                                        imageUrl: item.imageUrl.isEmpty ? String(format: "%02d", Int.random(in: 1...10)) : item.imageUrl
                                    )
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    
                    // ── 9. People Also Like ────────────────────────────────
                    VStack(alignment: .leading, spacing: 12) {
                        SectionHeader(title: "People Also Like") {
                            // Navigate to similar comics list
                        }
                        .padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(dataLoader.webtoons.dropFirst().prefix(10)) { comic in
                                    // NEW: Wrapped in NavigationLink to navigate to the detailed comic view
                                    NavigationLink(destination: ComicDetailViewWrapper(webtoon: comic, dataLoader: dataLoader)) {
                                        PortraitComicCard(
                                            title: comic.title,
                                            rating: String(format: "%.1f", comic.rating),
                                            readers: comic.view,
                                            // NEW: Forces a random image from your local assets, ignoring the JSON web URL
                                            imageUrl: String(format: "%02d", Int.random(in: 1...10))
                                        )
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    
                    Spacer(minLength: 40)
                }
                .padding(.top, 16)
            }
            .background(
                GeometryReader { proxy in
                    Color.clear
                        .preference(
                            key: ScrollOffsetKey.self,
                            value: -proxy.frame(in: .named("scroll")).minY
                        )
                }
            )
        }
        .coordinateSpace(name: "scroll")
        .onPreferenceChange(ScrollOffsetKey.self) { value in
            withAnimation(.easeInOut(duration: 0.2)) {
                scrollOffset = value
            }
        }
        .ignoresSafeArea(edges: .top)
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .tabBar)
        .overlay(alignment: .top) {
            
            HStack {
                Button { dismiss() } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.black)
                        .padding(13)
                        .background(Color.white)
                        .clipShape(Circle())
                        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                }
                Spacer()
                Button {
                    // Show options sheet
                } label: {
                    Image(systemName: "ellipsis")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.black)
                        .padding(16)
                        .background(Color.white)
                        .clipShape(Circle())
                        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                }
            }
            .padding(.horizontal)
            .padding(.top, 10)
            .opacity(scrollOffset > 100 ? 0 : 1)
        }
        .sheet(isPresented: $showRatingPopup) {
            RatingPopupView(title: webtoon.title)
                .presentationDetents([.large])
                .presentationDragIndicator(.visible)
                .presentationBackground(.ultraThinMaterial)
        }
        .onAppear {
            dataLoader.loadWebtoons()
        }
    }
}

// MARK: - Scroll Offset Key

struct ScrollOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

// MARK: - Rating Popup View

struct RatingPopupView: View {
    let title: String
    
    @Environment(\.dismiss) private var dismissSheet
    
    @State private var selectedRating: Int = 0
    @State private var reviewText: String = ""
    
    var body: some View {
        VStack(spacing: 20) {
            
            // Header Row
            ZStack {
                Text("Rating")
                    .font(.otherTitle)
                
                HStack {
                    Button(action: {
                        dismissSheet()
                    }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.black)
                            .padding(16)
                            .background(Color.white)
                            .clipShape(Circle())
                            .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                    }
                    Spacer()
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 32)
            
            // Titles
            VStack(spacing: 8) {
                Text(title)
                    .font(.topPicksTitle)
                
                Text("How would you rate this comic?")
                    .font(.bodyText)
                    .foregroundColor(.panelDark)
            }
            
            // Interactive Stars
            HStack(spacing: 12) {
                ForEach(1...5, id: \.self) { index in
                    Image(systemName: index <= selectedRating ? "star.fill" : "star")
                        .font(.system(size: 30))
                        .foregroundColor(.primary)
                        .onTapGesture {
                            withAnimation {
                                selectedRating = index
                            }
                        }
                }
            }
            .padding(.vertical, 10)
            
            // Text Area
            ZStack(alignment: .topLeading) {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(UIColor.systemBackground).opacity(0.7))
                    .shadow(color: .black.opacity(0.05), radius: 5, y: 2)
                
                TextEditor(text: $reviewText)
                    .padding(12)
                    .scrollContentBackground(.hidden)
                    .background(Color.clear)
                
                if reviewText.isEmpty {
                    Text("Write a review (optional)\nWhat did you think of the stories?")
                        .foregroundColor(.gray)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 24)
                        .allowsHitTesting(false)
                }
            }
            .frame(height: 140)
            .padding(.horizontal)
            
            Spacer()
            
            // Submit Button
            Button(action: {
                dismissSheet()
            }) {
                Text("Submit Rating")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(Color.black)
                    .cornerRadius(12)
            }
            .padding(.horizontal)
            .padding(.bottom, 30)
        }
    }
}

// MARK: - Sub-views

private struct SectionHeader: View {
    let title: String
    let onSeeAll: () -> Void
    
    var body: some View {
        HStack {
            Text(title)
                .font(.subHead)
            Spacer()
            Button("See All", action: onSeeAll)
                .font(.seeAll)
                .underline()
                .foregroundColor(.panelSecondary)
        }
    }
}

private struct QuickStatChip: View {
    let icon: String
    let value: String
    
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: icon)
                .font(.system(size: 12, weight: .semibold))
            Text(value)
                .font(.subheadline)
                .fontWeight(.semibold)
        }
        .foregroundColor(.primary)
    }
}

private struct StarRatingView: View {
    let rating: Double
    
    var body: some View {
        HStack(spacing: 3) {
            ForEach(0..<5, id: \.self) { index in
                Image(systemName: starName(for: index))
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.yellow)
            }
            Text(String(format: "%.1f", rating))
                .font(.subHead)
                .foregroundColor(.panelDark)
        }
    }
    
    private func starName(for index: Int) -> String {
        let filled = Int(rating)
        let hasHalf = (rating - Double(filled)) >= 0.5
        if index < filled { return "star.fill" }
        if index == filled && hasHalf { return "star.leadinghalf.filled" }
        return "star"
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        ComicDetailView(
            webtoon: Webtoon(
                id: 1193,
                title: "The Comic Title",
                author: "The Creator",
                genre: "Fantasy",
                thumbnail: "01", // Testing with Local Asset string
                summary: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum sit amet vestibulum lorem. Vivamus posuere convallis est, a porttitor odio tempor non. Sed lobortis aliquet convallis. Maecenas vel magna vitae lorem ipsum consectetur.",
                episodes: 64,
                view: "31K",
                like: "12.4K",
                subscribe: "5.3K",
                rating: 4.5,
                status: .ongoing
            ),
            chapters: [
                ComicChapter(id: "ch-010", comicId: 1193, chapterNumber: 10, title: "Apayah Ini", views: 12500, loves: 4500, comments: 320, imageUrl: ""),
                ComicChapter(id: "ch-009", comicId: 1193, chapterNumber: 9, title: "Apayah Ini", views: 11000, loves: 4000, comments: 290, imageUrl: ""),
                ComicChapter(id: "ch-008", comicId: 1193, chapterNumber: 8, title: "Apayah Ini", views: 9800, loves: 3500, comments: 260, imageUrl: ""),
                ComicChapter(id: "ch-007", comicId: 1193, chapterNumber: 7, title: "Apayah Ini", views: 8500, loves: 3000, comments: 230, imageUrl: "")
            ],
            comments: [
                ComicComment(
                    id: "cmt-001",
                    comicId: 1193,
                    user: CommentUser(id: "usr-101", username: "The Username", avatarUrl: nil),
                    rating: 5,
                    text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    likes: 119,
                    replies: 1000,
                    isLikedByCurrentUser: true,
                    createdAt: Date()
                ),
                ComicComment(
                    id: "cmt-002",
                    comicId: 1193,
                    user: CommentUser(id: "usr-102", username: "AnotherUser", avatarUrl: nil),
                    rating: 4,
                    text: "Great comic! The art style is amazing.",
                    likes: 85,
                    replies: 200,
                    isLikedByCurrentUser: false,
                    createdAt: Date().addingTimeInterval(-86400)
                )
            ],
            featuredCollections: [
                ComicCollection(id: "col-1", title: "Fantasy Essentials", author: "Curator", imageUrl: ""),
                ComicCollection(id: "col-2", title: "Top Rated 2026", author: "Admin", imageUrl: "")
            ],
            peopleAlsoLike: []
        )
    }
}
