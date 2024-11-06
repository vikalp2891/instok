//
//  Router.swift
//  TikTok
//
//  Created by Macbook  on 26/03/24.
//

import SwiftUI

final class Router: ObservableObject {
  
  public enum Destination: Codable, Hashable {
    case cameraRecording
    case mainEditorView(selectedVideoURl: URL)
  }
  
  @Published var navPath = NavigationPath()
  
  func navigate(to destination: Destination) {
    navPath.append(destination)
  }
  
  func navigateBack() {
    navPath.removeLast()
  }
  
  func navigateToRoot() {
    navPath.removeLast(navPath.count)
  }
}
