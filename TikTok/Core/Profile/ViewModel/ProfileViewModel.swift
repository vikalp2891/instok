//
//  ProfileViewModel.swift
//  TikTok
//
//  Created by Macbook  on 05/03/24.
//

import SwiftUI

class ProfileViewModel: ObservableObject {
  let userProfile: ProfileMockApiModels = ProfileMockApiModels(id: NSUUID().uuidString, userName: "@lewis.hamalton", following: "5", followers: "1", likes: "15", profileImageURL: "https://randomuser.me/api/portraits/men/79.jpg")
}
