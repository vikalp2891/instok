//
//  CommentCell.swift
//  TikTok
//
//  Created by Macbook  on 07/03/24.
//

import SwiftUI

struct CommentCell: View {
  
  let comment: CommentMokeApiModels
  
  var body: some View {
    HStack {
      AsyncImage(url: URL(string: comment.profileImageURL)) { phase in
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
        Text(comment.userName)
          .font(.footnote)
          .fontWeight(.semibold) +
        
        Text(" ") +
        
        Text(comment.message)
          .font(.footnote) +
        
        Text(" ") +
        
        Text(comment.time)
          .font(.caption)
          .foregroundStyle(.gray)
      }
      
      Spacer()
      
    }
    .padding(.horizontal)
  }
}

#Preview {
  CommentCell(comment: CommentMokeApiModels(id: NSUUID().uuidString, userName: "@CookingCraze", message: "Just uploaded a new recipe for cheesy pasta! ", time: "1h", profileImageURL: "https://randomuser.me/api/portraits/women/32.jpg"))
}
