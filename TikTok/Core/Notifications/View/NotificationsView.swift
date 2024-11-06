//
//  NotificationsView.swift
//  TikTok
//
//  Created by Macbook  on 05/03/24.
//

import SwiftUI

struct NotificationsView: View {
  
  @StateObject private var viewModel = NotificationViewModel()
  
  var body: some View {
    NavigationStack {
      ScrollView(showsIndicators: false) {
        VStack() {
          ForEach(viewModel.notificationItems) { notification in
            NotificationCell(notification: notification)
              .padding(.top)
          }
        }
        
      }
      .navigationTitle("Notification")
      .navigationBarTitleDisplayMode(.inline)
    }
  }
}

#Preview {
  NotificationsView()
}
