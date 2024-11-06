//
//  ExploreViewModel.swift
//  TikTok
//
//  Created by Macbook  on 05/03/24.
//

import SwiftUI

class ExploreViewModel: ObservableObject {
  
  let exploreItems = [
    ExploreMokeApiModels(id: NSUUID().uuidString, userName: "@CulinaryCrystal", name: "Crystal Jones", profileImageURL: "https://randomuser.me/api/portraits/women/32.jpg"),
    ExploreMokeApiModels(id: NSUUID().uuidString, userName: "@BrushstrokeBeats", name: "Ethan Miller", profileImageURL: "https://randomuser.me/api/portraits/men/23.jpg"),
    ExploreMokeApiModels(id: NSUUID().uuidString, userName: "@ThePlantParenthood", name: "Maya Patel", profileImageURL: "https://randomuser.me/api/portraits/women/22.jpg"),
    ExploreMokeApiModels(id: NSUUID().uuidString, userName: "@Jokes4Geeks", name: "David Lee", profileImageURL: "https://randomuser.me/api/portraits/men/69.jpg"),
    ExploreMokeApiModels(id: NSUUID().uuidString, userName: "@GlobetrottingGrandpa", name: "William Thompson", profileImageURL: "https://randomuser.me/api/portraits/men/79.jpg"),
    ExploreMokeApiModels(id: NSUUID().uuidString, userName: "@DIYDandelion", name: "Amelia Garcia", profileImageURL: "https://randomuser.me/api/portraits/men/14.jpg"),
    ExploreMokeApiModels(id: NSUUID().uuidString, userName: "@ScienceSimplified", name: "Noah Rodriguez", profileImageURL: "https://randomuser.me/api/portraits/women/25.jpg"),
    ExploreMokeApiModels(id: NSUUID().uuidString, userName: "@PawsitivePaws", name: "Sophia Hernandez", profileImageURL: "https://randomuser.me/api/portraits/women/50.jpg"),
    ExploreMokeApiModels(id: NSUUID().uuidString, userName: "@VintageVibes", name: "Emily Chen", profileImageURL: "https://randomuser.me/api/portraits/men/69.jpg"),
    ExploreMokeApiModels(id: NSUUID().uuidString, userName: "@BookwormBibliophile", name: "Michael Kim", profileImageURL: "https://randomuser.me/api/portraits/men/89.jpg")
  ]
  
}
