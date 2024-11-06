//
//  FeedCell.swift
//  TikTok
//
//  Created by Macbook  on 05/03/24.
//

import SwiftUI
import AVKit


struct FeedCell: View {
  let post: FeedMockApiModel
  var player = AVPlayer()
  
  @State private var showBookMarkAlert: Bool = false
  @State private var isLiked: Bool = false
  @State private var isBookmarked: Bool = false
  @State private var likeCount: Int = 0
  @State private var showSheet = false
  
  init(post: FeedMockApiModel, player: AVPlayer) {
    self.post = post
    self.player = player
  }
  
  var body: some View {
    ZStack {
      CustomVideoPlayer(player: player)
        .containerRelativeFrame([.horizontal, .vertical])
      
      VStack {
        Spacer()
        
        HStack(alignment: .bottom) {
          VStack(alignment: .leading) {
            Text(post.userName)
              .fontWeight(.semibold)
            
            Text(post.caption)
          }
          .foregroundStyle(.white)
          .font(.subheadline)
          
          Spacer()
          
          VStack(spacing: 26) {
            
            AsyncImage(url: URL(string: post.profileImageURL)) { phase in
              switch phase {
              case .empty:
                ZStack {
                  Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 48, height: 48)
                    .foregroundStyle(Color(.systemGray))
                  ProgressView()
                }
                
              case .success(let image):
                image
                  .resizable()
                  .frame(width: 48, height: 48)
                  .foregroundStyle(Color(.systemGray))
                  .clipShape(Circle())
              case .failure(_):
                Image(systemName: "person.circle.fill")
                  .resizable()
                  .frame(width: 48, height: 48)
                  .foregroundStyle(Color(.systemGray))
              @unknown default:
                Image(systemName: "person.circle.fill")
                  .resizable()
                  .frame(width: 48, height: 48)
                  .foregroundStyle(Color(.systemGray))
              }
            }
            
            Button {
              
            } label: {
              VStack {
                Button {
                  isLiked.toggle()
                  if isLiked {
                    likeCount += 1
                  } else {
                    likeCount -= 1
                  }
                } label: {
                  Image(systemName: isLiked ? "heart.fill" : "heart")
                    .resizable()
                    .frame(width: 32, height: 28)
                    .shadow(color: .gray, radius: 12)
                    .foregroundStyle(isLiked == true ? .red : .white)
                }
                
                
                Text(String(likeCount))
                  .font(.caption)
                  .shadow(color: .gray, radius: 12)
                  .foregroundStyle(.white)
                  .bold()
              }
              
            }
            
            Button {
              showSheet = true
            } label: {
              VStack {
                Image(systemName: "ellipsis.bubble")
                  .resizable()
                  .frame(width: 28, height: 30)
                  .shadow(color: .gray, radius: 12)
                  .foregroundStyle(.white)
                
                Text(post.commentCount)
                  .font(.caption)
                  .shadow(color: .gray, radius: 12)
                  .foregroundStyle(.white)
                  .bold()
              }
            }
            .sheet(isPresented: $showSheet){
              GeometryReader { geometry in
                CommentView()
                  .presentationDetents([.large])
              }
            }
            
            Button {
              
            } label: {
              VStack {
                Button {
                  isBookmarked.toggle()
                  if isBookmarked {
                    showBookMarkAlert = true
                  }
                } label: {
                  Image(systemName: isBookmarked ? "bookmark.fill" : "bookmark")
                    .resizable()
                    .frame(width: 24, height: 26)
                    .shadow(color: .gray, radius: 12)
                    .foregroundStyle(.white)
                }
                .alert("Post added to your bookmark",isPresented: $showBookMarkAlert) {
                  Button("OK"){
                    showBookMarkAlert = false
                  }
                }
                
                Text(post.bookmarkCount)
                  .font(.caption)
                  .shadow(color: .gray, radius: 12)
                  .foregroundStyle(.white)
                  .bold()
              }
            }
            
            Button {
              
            } label: {
              VStack {
                ShareLink(item: URL(string: post.videoURL)!) {
                  Image(systemName: "arrowshape.turn.up.right")
                    .resizable()
                    .frame(width: 26, height: 24)
                    .shadow(color: .gray, radius: 12)
                    .foregroundStyle(.white)
                  
                }
                .buttonStyle(.plain)
                
                Text(post.shareCount)
                  .font(.caption)
                  .shadow(color: .gray, radius: 12)
                  .foregroundStyle(.white)
                  .bold()
              }
            }
          }
        }
      }
      .padding()
    }
    .onTapGesture {
      switch player.timeControlStatus {
      case .paused:
        player.play()
      case .waitingToPlayAtSpecifiedRate:
        break
      case .playing:
        player.pause()
      @unknown default:
        break
      }
    }
    .onAppear{
      likeCount = post.likeCount
    }
  }
}

#Preview {
  FeedCell(post: FeedMockApiModel(id: NSUUID().uuidString, userName: "@CulinaryCrysta", caption: "Big Buck Bunny", likeCount: 25, commentCount: "7", bookmarkCount: "3", profileImageURL: "https://randomuser.me/api/portraits/women/32.jpg", shareCount: "27", videoURL: FeedMockVideoApiModels().videoUrls[0]), player: AVPlayer())
}
