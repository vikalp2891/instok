//
//  CommentViewModel.swift
//  TikTok
//
//  Created by Macbook  on 07/03/24.
//

import SwiftUI

class CommentViewModel: ObservableObject {
  
  @Published var commentItems: [CommentMokeApiModels] = [
    CommentMokeApiModels(id: NSUUID().uuidString, userName: "@TravelGrandpa", message: "Sharing adventures from my trip to Italy! 🇮🇹", time: "5h", profileImageURL: "https://randomuser.me/api/portraits/men/79.jpg"),
    CommentMokeApiModels(id: NSUUID().uuidString, userName: "@CraftyAmelia", message: "New DIY project: Upcycled denim tote bag! ♻️", time: "6h", profileImageURL: "https://randomuser.me/api/portraits/men/14.jpg"),
    CommentMokeApiModels(id: NSUUID().uuidString, userName: "@ScienceNoah", message: "Did you know the human brain has about 86 billion neurons? ", time: "7h", profileImageURL: "https://randomuser.me/api/portraits/women/25.jpg"),
  ]
}
