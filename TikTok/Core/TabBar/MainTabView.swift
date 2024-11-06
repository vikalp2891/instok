//
//  MainTabView.swift
//  TikTok
//
//  Created by Macbook  on 05/03/24.
//

import SwiftUI

struct MainTabView: View {
  
  @State private var selectedTab = 0
  
  var body: some View {
    TabView(selection: $selectedTab) {
      FeedView()
        .padding(.bottom, 1)
        .toolbarBackground(.black, for: .tabBar)
        .tabItem {
          Image(systemName: selectedTab == 0 ? "house.fill" : "house")
          Text("Home")
        }
        .background(.black)
        .onAppear { selectedTab = 0 }
        .tag(0)
      
      ExploreView()
        .preferredColorScheme(.light)
        .toolbarBackground(.white, for: .tabBar)
        .padding(.bottom, 1)
        .tabItem {
          Image(systemName: selectedTab == 1 ? "person.2.fill" : "person.2")
          Text("Friends")
        }
        .background(.white)
        .onAppear { selectedTab = 1 }
        .tag(1)
      
      CameraView()
        .preferredColorScheme(.light)
        .toolbarBackground(.black, for: .tabBar)
        .padding(.bottom, 1)
        .tabItem {
          Image(systemName: selectedTab == 2 ? "plus.rectangle.fill" : "plus.rectangle")
            .renderingMode(.original)
          Text("Reel")
        }
        .background(.black)
        .onAppear { selectedTab = 2 }
        .tag(2)
      
      NotificationsView()
        .preferredColorScheme(.light)
        .toolbarBackground(.white, for: .tabBar)
        .padding(.bottom, 1)
        .tabItem {
          Image(systemName: selectedTab == 3 ? "heart.fill" : "heart")
          Text("Inbox")
        }
        .background(.white)
        .onAppear { selectedTab = 3 }
        .tag(3)
      
      CurrentUserProfileView()
        .preferredColorScheme(.light)
        .toolbarBackground(.white, for: .tabBar)
        .padding(.bottom, 1)
        .tabItem {
          Image(systemName: selectedTab == 4 ? "person.fill" : "person")
          Text("Profile")
        }
        .background(.white)
        .onAppear { selectedTab = 4 }
        .tag(4)
    }
    .tint(selectedTab == 0 ? .white : selectedTab == 2 ? .white : .black)
  }
}

#Preview {
  MainTabView()
}
