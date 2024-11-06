//
//  FeedView.swift
//  TikTok
//
//  Created by Macbook  on 05/03/24.
//

import SwiftUI
import AVKit

struct FeedView: View {
  
  @StateObject private var viewModel = FeedViewModel()
  @State private var scrollPosition: String?
  @State private var player = AVPlayer()
  
  var body: some View {
    ScrollView(showsIndicators: false) {
      LazyVStack(spacing: 0) {
        ForEach(viewModel.feedItems) { post in
          FeedCell(post: post, player: player)
            .id(post.id)
            .onAppear {
              playInitialVideoIfNeccessary()
            }
        }
      }
      .scrollTargetLayout()
    }
    .onAppear { player.play() }
    .scrollPosition(id: $scrollPosition)
    .scrollTargetBehavior(.paging)
    .ignoresSafeArea()
    .onChange(of: scrollPosition) { oldValue, newValue in
      playVideoOnChangeOfScrollPosition(postId: newValue)
    }
    .onDisappear {
      player.pause()
    }
  }
  
  func playInitialVideoIfNeccessary() {
    guard
      scrollPosition == nil,
      let post = viewModel.feedItems.first,
      player.currentItem == nil else { return }
    
    let item = AVPlayerItem(url: URL(string: post.videoURL)!)
    DispatchQueue.main.async {
      player.replaceCurrentItem(with: item)
    }
  }
  
  func playVideoOnChangeOfScrollPosition(postId: String?) {
    guard let currentPost = viewModel.feedItems.first(where: { $0.id == postId }) else { return }
    player.replaceCurrentItem(with: nil)
    
    let playerItem = AVPlayerItem(url: URL(string: currentPost.videoURL)!)
    //DispatchQueue.main.async {
    player.replaceCurrentItem(with: playerItem)
    //}
  }
}

#Preview {
  FeedView()
}
