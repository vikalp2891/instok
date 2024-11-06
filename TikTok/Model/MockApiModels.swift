//
//  FakeApiModels.swift
//  TikTok
//
//  Created by Macbook  on 05/03/24.
//

import Foundation

struct ExploreMokeApiModels: Codable, Identifiable {
    let id: String
    let userName: String
    let name: String
    let profileImageURL: String
}

struct NotificationMokeApiModels: Codable, Identifiable {
    let id: String
    let userName: String
    let message: String
    let time: String
    let profileImageURL: String
    let postImageURL: String
}

struct CommentMokeApiModels: Codable, Identifiable {
    let id: String
    let userName: String
    let message: String
    let time: String
    let profileImageURL: String
}

struct ProfileMockApiModels: Codable, Identifiable {
    let id: String
    let userName: String
    let following: String
    let followers: String
    let likes: String
    let profileImageURL: String
    var posts: [String] = FeedMockVideoApiModels().videoUrls + FeedMockVideoApiModels().videoUrls
}

struct FeedMockApiModel: Codable, Identifiable {
    let id: String
    let userName: String
    let caption: String
    let likeCount: Int
    let commentCount: String
    let bookmarkCount: String
    let profileImageURL: String
    let shareCount: String
    let videoURL: String
}

struct FeedMockVideoApiModels {
    let videoUrls = [
        "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
        "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
        "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
        "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4",
        "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4",
        "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4",
        "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4"
    ]
}
