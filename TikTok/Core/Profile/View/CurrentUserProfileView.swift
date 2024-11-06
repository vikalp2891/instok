//
//  CurrentUserProfileView.swift
//  TikTok
//
//  Created by Macbook  on 05/03/24.
//

import SwiftUI

struct CurrentUserProfileView: View {
  
  @StateObject private var viewModel = ProfileViewModel()
  
  var body: some View {
    NavigationStack {
      ScrollView(showsIndicators: false) {
        VStack(spacing: 2) {
          ProfileHeaderView(userProfile: viewModel.userProfile)
          PostGridView(posts: viewModel.userProfile.posts)
        }
        .padding(.top)
      }
      .navigationTitle("Profile")
      .navigationBarTitleDisplayMode(.inline)
    }
  }
}

#Preview {
  CurrentUserProfileView()
}
