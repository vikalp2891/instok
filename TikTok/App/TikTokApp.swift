//
//  TikTokApp.swift
//  TikTok
//
//  Created by Macbook  on 05/03/24.
//

import SwiftUI

@main
struct TikTokApp: App {
  @ObservedObject var router = Router()
  
  var body: some Scene {
    WindowGroup {
      NavigationStack(path: $router.navPath) {
        MainTabView()
          .navigationDestination(for: Router.Destination.self) { destination in
            switch destination {
            case .cameraRecording:
              CameraView()
            case .mainEditorView(let url):
              MainEditorView(selectedVideoURl: url)
            }
          }
      }
      .environmentObject(router)
    }
  }
}
