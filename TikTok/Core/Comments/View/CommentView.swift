//
//  CommentView.swift
//  TikTok
//
//  Created by Macbook  on 07/03/24.
//

import SwiftUI

struct CommentView: View {
  
  @StateObject private var viewModel = CommentViewModel()
  @State private var message: String = ""
  
  var body: some View {
    VStack {
      ScrollView(showsIndicators: false) {
        ZStack {
          VStack(spacing: 8) {
            ForEach(viewModel.commentItems) { comment in
              CommentCell(comment: comment)
                .padding(.top)
            }
            
          }
        }
      }
      .padding(.top)
      
      Spacer()
      
      HStack(alignment: .bottom) {
        InputField(onSend: { message in
          self.message = message
          viewModel.commentItems.append(CommentMokeApiModels(id: NSUUID().uuidString, userName: "@FashionEmily", message: message, time: "0m", profileImageURL: "https://randomuser.me/api/portraits/men/69.jpg"))
        })
      }
      .padding(.horizontal, 12)
    }
  }
}

#Preview {
  CommentView()
}


struct InputField: View {
  
  @State private var text: String = ""
  
  var onSend: (String) -> Void
  
  var body: some View {
    HStack(spacing: 10) {
      TextField("Enter message", text: $text)
        .textFieldStyle(.roundedBorder)
        .lineLimit(1) // Ensures single line
      
      Button(action: {
        onSend(text)
        text = "" // Clear input after sending
      }) {
        Image(systemName: "paperplane.fill")
          .foregroundColor(.blue)
      }
    }
  }
}
