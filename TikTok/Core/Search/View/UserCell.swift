//
//  UserCell.swift
//  TikTok
//
//  Created by Macbook  on 05/03/24.
//

import SwiftUI

struct UserCell: View {
  
  let user: ExploreMokeApiModels
  
  var body: some View {
    HStack(spacing: 12) {
      AsyncImage(url: URL(string: user.profileImageURL)) { phase in
        if let image = phase.image {
          image
            .resizable()
            .frame(width: 48, height: 48)
            .foregroundStyle(Color(.systemGray))
            .clipShape(Circle())
        } else {
          Image(systemName: "person.circle.fill")
            .resizable()
            .frame(width: 48, height: 48)
            .foregroundStyle(Color(.systemGray))
        }
      }
      
      VStack(alignment: .leading) {
        Text(user.userName)
          .font(.subheadline)
          .fontWeight(.semibold)
        
        Text(user.name)
          .font(.footnote)
      }
      
      Spacer()
    }
    .padding(.horizontal)
  }
}

#Preview {
  UserCell(user: ExploreMokeApiModels(id: NSUUID().uuidString, userName: "@CulinaryCrystal", name: "Crystal Jones", profileImageURL: "https://randomuser.me/api/portraits/women/32.jpg"))
}
