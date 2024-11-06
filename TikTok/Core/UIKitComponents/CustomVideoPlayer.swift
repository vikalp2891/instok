//
//  CustomVideoPlayer.swift
//  TikTok
//
//  Created by Macbook  on 05/03/24.
//

import SwiftUI
import AVKit

struct CustomVideoPlayer: UIViewControllerRepresentable {
  var player: AVPlayer
  
  func makeUIViewController(context: Context) -> some UIViewController {
    let controller = AVPlayerViewController()
    controller.player = player
    controller.showsPlaybackControls = false
    controller.exitsFullScreenWhenPlaybackEnds = true
    controller.allowsPictureInPicturePlayback = true
    controller.videoGravity = .resizeAspectFill
    return controller
  }
  
  func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}
