//
//  ExploreView.swift
//  TikTok
//
//  Created by Macbook  on 05/03/24.
//

import SwiftUI

struct ExploreView: View {
  
  @StateObject private var viewModel = ExploreViewModel()
  
  var body: some View {
    NavigationStack {
      ScrollView {
        LazyVStack(spacing: 16) {
          ForEach(viewModel.exploreItems) { user in
            UserCell(user: user)
          }
        }
        .padding(.top)
      }
      .navigationTitle("Explore")
      .navigationBarTitleDisplayMode(.inline)
    }
  }
}

#Preview {
  ExploreView()
}
