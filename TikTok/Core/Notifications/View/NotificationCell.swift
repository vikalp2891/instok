//
//  NotificationCell.swift
//  TikTok
//
//  Created by Macbook  on 05/03/24.
//

import SwiftUI

struct NotificationCell: View {
  let notification: NotificationMokeApiModels
  
  var body: some View {
    HStack {
      AsyncImage(url: URL(string: notification.profileImageURL)) { phase in
        if let image = phase.image {
          image
            .resizable()
            .frame(width: 32, height: 32)
            .foregroundStyle(Color(.systemGray))
            .clipShape(Circle())
        } else {
          Image(systemName: "person.circle.fill")
            .resizable()
            .frame(width: 32, height: 32)
            .foregroundStyle(Color(.systemGray))
        }
      }
      
      HStack {
        Text(notification.userName)
          .font(.footnote)
          .fontWeight(.semibold) +
        
        Text(" ") +
        
        Text(notification.message)
          .font(.footnote) +
        
        Text(" ") +
        
        Text(notification.time)
          .font(.caption)
          .foregroundStyle(.gray)
      }
      
      Spacer()
      
      AsyncImage(url: URL(string: notification.profileImageURL)) { phase in
        if let image = phase.image {
          image
            .resizable()
            .frame(width: 48, height: 48)
            .clipShape(RoundedRectangle(cornerRadius: 6))
          
        } else {
          Rectangle()
            .frame(width: 48, height: 48)
            .clipShape(RoundedRectangle(cornerRadius: 6))
        }
      }
      
      
    }
    .padding(.horizontal)
  }
}

#Preview {
  NotificationCell(notification: NotificationMokeApiModels(id: NSUUID().uuidString, userName: "@CookingCraze", message: "Just uploaded a new recipe for cheesy pasta! ", time: "1h", profileImageURL: "https://randomuser.me/api/portraits/women/32.jpg", postImageURL: "https://source.unsplash.com/food/300x200"))
}
