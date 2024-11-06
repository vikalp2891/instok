//
//  VideoItem.swift
//  TikTok
//
//  Created by Macbook  on 13/03/24.
//

import AVKit
import SwiftUI


struct VideoItem: Transferable {
  let url: URL
  
  static var transferRepresentation: some TransferRepresentation {
    FileRepresentation(contentType: .movie) { movie in
      SentTransferredFile(movie.url)
    } importing: { received in
      let id = UUID().uuidString
      let copy = URL.documentsDirectory.appending(path: "\(id).mp4")
      
      if FileManager.default.fileExists(atPath: copy.path()) {
        try FileManager.default.removeItem(at: copy)
      }
      
      try FileManager.default.copyItem(at: received.file, to: copy)
      return Self.init(url: copy)
    }
  }
}
