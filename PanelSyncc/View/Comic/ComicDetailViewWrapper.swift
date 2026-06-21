//
//  ComicDetailViewWrapper.swift
//  PanelSyncc
//
//  Created by Amelia Putri Aftiana on 21/06/26.
//


import SwiftUI

// MARK: - Comic Detail Wrapper with Dummy Data Fallback
struct ComicDetailViewWrapper: View {
    let webtoon: Webtoon
    @ObservedObject var dataLoader: WebtoonDataLoader
    
    var body: some View {
        // Check if database has data for this comic, otherwise create dummy data
        let actualChapters = dataLoader.chapters.filter { $0.comicId == webtoon.id }
        let actualComments = dataLoader.comments.filter { $0.comicId == webtoon.id }
        
        ComicDetailView(
            webtoon: webtoon,
            chapters: actualChapters.isEmpty ? generateDummyChapters(for: webtoon.id) : actualChapters,
            comments: actualComments.isEmpty ? generateDummyComments(for: webtoon.id) : actualComments,
            featuredCollections: dataLoader.collections,
            peopleAlsoLike: []
        )
        .onAppear {
            dataLoader.loadAllData(for: webtoon.id)
        }
    }
    
    // Fallback Dummy Data Generators
    private func generateDummyChapters(for comicId: Int) -> [ComicChapter] {
        return [
            ComicChapter(id: "ch-3", comicId: comicId, chapterNumber: 3, title: "The Turning Point", views: 15200, loves: 4100, comments: 230, imageUrl: ""),
            ComicChapter(id: "ch-2", comicId: comicId, chapterNumber: 2, title: "An Unexpected Journey", views: 18400, loves: 5200, comments: 410, imageUrl: ""),
            ComicChapter(id: "ch-1", comicId: comicId, chapterNumber: 1, title: "The Beginning", views: 24500, loves: 8300, comments: 950, imageUrl: "")
        ]
    }
    
    private func generateDummyComments(for comicId: Int) -> [ComicComment] {
        return [
            ComicComment(id: "cmt-1", comicId: comicId, user: CommentUser(id: "u1", username: "ComicFan99", avatarUrl: nil), rating: 5, text: "The art style in this series is absolutely gorgeous! Highly recommend.", likes: 450, replies: 12, isLikedByCurrentUser: true, createdAt: Date()),
            ComicComment(id: "cmt-2", comicId: comicId, user: CommentUser(id: "u2", username: "ReaderX", avatarUrl: nil), rating: 4, text: "Great story so far. The pacing is a bit slow in the beginning but it gets so much better.", likes: 120, replies: 3, isLikedByCurrentUser: false, createdAt: Date().addingTimeInterval(-86400))
        ]
    }
}

