//
//  PostGridView.swift
//  TikTok
//
//  Created by Macbook  on 05/03/24.
//

import SwiftUI
import AVFoundation


struct PostGridView: View {
  
  let posts: [String]
  
  private let items = [
    GridItem(.flexible(), spacing: 1),
    GridItem(.flexible(), spacing: 1),
    GridItem(.flexible(), spacing: 1)
  ]
  
  private let width =  (UIScreen.main.bounds.width / 3) - 2
  @State private var loadedImages: [String: UIImage?] = [:]
  var body: some View {
    LazyVGrid(columns: items, spacing: 2) {
      ForEach(posts.indices, id: \.self) { post in
        if let image = loadedImages[posts[post]] {
          if image != nil {
            Image(uiImage: image!)
              .resizable()
              .frame(width: width, height: 180)
          } else {
            Rectangle()
              .frame(width: width, height: 180)
          }
        } else {
          ProgressView()
            .frame(width: width, height: 180)
            .onAppear {
              DispatchQueue.global().async {
                loadedImages[posts[post]] = getMiddleFrameImage(from: posts[post])
              }
            }
        }
      }
    }
  }
  
  func getMiddleFrameImage(from videoURL: String) -> UIImage? {
    
    guard let url = URL(string: videoURL) else {
      print("Invalid video URL")
      return nil
    }
    
    let asset = AVAsset(url: url)
    let duration = CMTimeGetSeconds(asset.duration)
    let middleTime = CMTimeMakeWithSeconds(duration / 2, preferredTimescale: 600)
    
    let imageGenerator = AVAssetImageGenerator(asset: asset)
    imageGenerator.appliesPreferredTrackTransform = true
    
    do {
      let cgImage = try imageGenerator.copyCGImage(at: middleTime, actualTime: nil)
      return UIImage(cgImage: cgImage)
    } catch {
      print("Error generating middle frame image: \(error.localizedDescription)")
      return nil
    }
  }
}


#Preview {
  PostGridView(posts: FeedMockVideoApiModels().videoUrls)
}
