//
//  ProfileHeaderView.swift
//  TikTok
//
//  Created by Macbook  on 05/03/24.
//

import SwiftUI

struct ProfileHeaderView: View {
  let userProfile: ProfileMockApiModels
  let imageUrl = URL(string: "https://randomuser.me/api/portraits/men/79.jpg")!
  
  var body: some View {
    VStack {
      VStack(spacing: 16) {
        VStack(spacing: 8) {
          AsyncImage(url: URL(string: userProfile.profileImageURL)) { phase in
            switch phase {
            case .empty:
              ZStack {
                Image(systemName: "person.circle.fill")
                  .resizable()
                  .frame(width: 80, height: 80)
                  .foregroundStyle(Color(.systemGray))
                ProgressView()
              }
              
            case .success(let image):
              image
                .resizable()
                .frame(width: 80, height: 80)
                .foregroundStyle(Color(.systemGray))
                .clipShape(Circle())
            case .failure(_):
              Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 80, height: 80)
                .foregroundStyle(Color(.systemGray))
            @unknown default:
              Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 80, height: 80)
                .foregroundStyle(Color(.systemGray))
            }
          }
          
          
          Text(userProfile.userName)
            .font(.subheadline)
            .fontWeight(.semibold)
        }
        
        HStack(spacing: 16) {
          UserStatView(count: userProfile.following, title: "Following")
          UserStatView(count: userProfile.followers, title: "Followers")
          UserStatView(count: userProfile.likes, title: "Likes")
        }
        
        Button {
          
        } label: {
          Text("Edit Profile")
            .font(.subheadline)
            .fontWeight(.semibold)
            .frame(width: 360, height: 32)
            .foregroundStyle(Color(.label))
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 6))
        }
        
        Divider()
      }
    }
  }
}

#Preview {
  ProfileHeaderView(userProfile: ProfileMockApiModels(id: NSUUID().uuidString, userName: "@lewis.hamalton", following: "5", followers: "1", likes: "15", profileImageURL: "https://randomuser.me/api/portraits/men/79.jpg"))
}

struct UserStatView: View {
  
  let count:String
  let title: String
  
  var body: some View {
    VStack {
      Text(count)
        .font(.subheadline)
        .fontWeight(.bold)
      
      Text(title)
        .font(.caption)
        .foregroundStyle(.gray)
    }
    .frame(width: 80, alignment: .center)
  }
}
