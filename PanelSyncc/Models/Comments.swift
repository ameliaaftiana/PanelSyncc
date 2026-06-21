//
//  Comments.swift
//  PanelSyncc
//
//  Created by Amelia Putri Aftiana on 19/06/26.
//

import Foundation

// MARK: - Comment Models

struct ComicComment: Identifiable, Codable, Hashable {
    let id: String
    let comicId: Int
    let user: CommentUser
    let rating: Int
    let text: String
    
    // Using var for properties that might change locally (like toggling a like)
    var likes: Int
    var replies: Int
    var isLikedByCurrentUser: Bool
    
    let createdAt: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case comicId = "comic_id"
        case user
        case rating
        case text
        case likes
        case replies
        case isLikedByCurrentUser = "is_liked_by_current_user"
        case createdAt = "created_at"
    }
}

struct CommentUser: Identifiable, Codable, Hashable {
    let id: String
    let username: String
    let avatarUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case username
        case avatarUrl = "avatar_url"
    }
}

// MARK: - Chapter Model
struct ComicChapter: Identifiable, Codable, Hashable {
    let id: String
    let comicId: Int
    let chapterNumber: Int
    let title: String
    let views: Int
    let loves: Int
    let comments: Int
    let imageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case comicId = "comic_id"
        case chapterNumber = "chapter_number"
        case title
        case views
        case loves
        case comments
        case imageUrl = "image_url"
    }
}

// MARK: - Collection Model
struct ComicCollection: Identifiable, Codable, Hashable {
    let id: String
    let title: String
    let author: String
    let imageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case author
        case imageUrl = "image_url"
    }
}
