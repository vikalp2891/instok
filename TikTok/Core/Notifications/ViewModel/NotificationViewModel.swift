//
//  NotificationViewModel.swift
//  TikTok
//
//  Created by Macbook  on 05/03/24.
//

import SwiftUI

class NotificationViewModel: ObservableObject {
  
  let notificationItems: [NotificationMokeApiModels] = [
    NotificationMokeApiModels(id: NSUUID().uuidString, userName: "@CookingCraze", message: "Just uploaded a new recipe for cheesy pasta! ", time: "1h", profileImageURL: "https://randomuser.me/api/portraits/women/32.jpg", postImageURL: "https://source.unsplash.com/food/300x200"),
    NotificationMokeApiModels(id: NSUUID().uuidString, userName: "@BeatsByEthan", message: "New music dropping soon! Stay tuned ", time: "2h", profileImageURL: "https://randomuser.me/api/portraits/men/23.jpg", postImageURL: "https://source.unsplash.com/music/300x200"),
    NotificationMokeApiModels(id: NSUUID().uuidString, userName: "@PlantyParadise", message: "Plant of the day: Monstera Deliciosa! ", time: "3h", profileImageURL: "https://randomuser.me/api/portraits/women/22.jpg", postImageURL: "https://source.unsplash.com/nature/300x200"),
    NotificationMokeApiModels(id: NSUUID().uuidString, userName: "@TechieDavid", message: "Solved a coding challenge! ", time: "4h", profileImageURL: "https://randomuser.me/api/portraits/men/69.jpg", postImageURL: "https://source.unsplash.com/tech/300x200"),
    NotificationMokeApiModels(id: NSUUID().uuidString, userName: "@TravelGrandpa", message: "Sharing adventures from my trip to Italy! 🇮🇹", time: "5h", profileImageURL: "https://randomuser.me/api/portraits/men/79.jpg", postImageURL: "https://source.unsplash.com/travel/300x200"),
    NotificationMokeApiModels(id: NSUUID().uuidString, userName: "@CraftyAmelia", message: "New DIY project: Upcycled denim tote bag! ♻️", time: "6h", profileImageURL: "https://randomuser.me/api/portraits/men/14.jpg", postImageURL: "https://source.unsplash.com/craft/300x200"),
    NotificationMokeApiModels(id: NSUUID().uuidString, userName: "@ScienceNoah", message: "Did you know the human brain has about 86 billion neurons? ", time: "7h", profileImageURL: "https://randomuser.me/api/portraits/women/25.jpg", postImageURL: "https://source.unsplash.com/science/300x200"),
    NotificationMokeApiModels(id: NSUUID().uuidString, userName: "@PawsomeSophia", message: "Meet our newest rescue pup, Charlie!", time: "8h", profileImageURL: "https://randomuser.me/api/portraits/women/50.jpg", postImageURL: "https://source.unsplash.com/animals/300x200"),
    NotificationMokeApiModels(id: NSUUID().uuidString, userName: "@FashionEmily", message: "Obsessed with this new vintage dress! ", time: "9h", profileImageURL: "https://randomuser.me/api/portraits/men/69.jpg", postImageURL: "https://source.unsplash.com/fashion/300x200"),
    NotificationMokeApiModels(id: NSUUID().uuidString, userName: "@BookishMichael", message: "Just finished reading 'The Lord of the Rings' - epic! ", time: "10h", profileImageURL: "https://randomuser.me/api/portraits/men/89.jpg", postImageURL: "https://source.unsplash.com/books/300x200")
  ]
}
