//
//  FeedViewModel.swift
//  TikTok
//
//  Created by Macbook  on 05/03/24.
//

import Foundation

class FeedViewModel: ObservableObject {
  
  let feedItems: [FeedMockApiModel] = [
    FeedMockApiModel(id: NSUUID().uuidString, userName: "@CulinaryCrysta", caption: "Big Buck Bunny", likeCount: 25, commentCount: "7", bookmarkCount: "3", profileImageURL: "https://randomuser.me/api/portraits/women/32.jpg", shareCount: "28", videoURL: FeedMockVideoApiModels().videoUrls[0]),
    
    FeedMockApiModel(id: NSUUID().uuidString, userName: "@ThePlantParenthood", caption: "For Bigger Blazes", likeCount: 5, commentCount: "3", bookmarkCount: "23", profileImageURL: "https://randomuser.me/api/portraits/women/22.jpg", shareCount: "27", videoURL: FeedMockVideoApiModels().videoUrls[2]),
    
    FeedMockApiModel(id: NSUUID().uuidString, userName: "@Jokes4Geeks", caption: "For Bigger Fun", likeCount: 155, commentCount: "7", bookmarkCount: "3", profileImageURL: "https://randomuser.me/api/portraits/men/69.jpg", shareCount: "27", videoURL: FeedMockVideoApiModels().videoUrls[3]),
    
    FeedMockApiModel(id: NSUUID().uuidString, userName: "@GlobetrottingGrandpa", caption: "For Bigger Joyrides", likeCount: 125, commentCount: "57", bookmarkCount: "8", profileImageURL: "https://randomuser.me/api/portraits/men/79.jpg", shareCount: "27", videoURL: FeedMockVideoApiModels().videoUrls[4]),
    
    FeedMockApiModel(id: NSUUID().uuidString, userName: "@DIYDandelion", caption: "For Bigger Meltdowns", likeCount: 225, commentCount: "17", bookmarkCount: "13", profileImageURL: "https://randomuser.me/api/portraits/men/14.jpg", shareCount: "27", videoURL: FeedMockVideoApiModels().videoUrls[5])
  ]
}
