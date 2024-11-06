//
//  RecordingContentView.swift
//  TikTok
//
//  Created by Macbook on 06/03/24.
//

import SwiftUI
import AVKit

struct RecordingContentView: View {
  @StateObject var cameraModel = CameraViewModel()
  var body: some View {
    
    NavigationView {
      ZStack(alignment: .bottom) {
        
        // MARK: Camera View
        CameraView()
          .environmentObject(cameraModel)
          .ignoresSafeArea()
        
        // MARK: Controls
        ZStack{
          Button {
            cameraModel.isRecording ? cameraModel.stopRecording() : cameraModel.startRecording()
          }
        label: {
          Image(systemName: "video.bubble")
          
            .resizable()
            .renderingMode(.template)
          
            .aspectRatio(contentMode: .fit)
            .foregroundColor(.black)
            .opacity(cameraModel.isRecording ? 0 : 1)
            .padding(12)
            .frame(width: 60, height: 60)
          
            .background{
              Circle()
                .stroke(cameraModel.isRecording ? Color.clear : Color.black)
            }
            .padding(6)
            .background {
              Circle()
                .fill(cameraModel.isRecording ? Color.red : Color.white)
            }
        }
          
          Button {
            if let _ = cameraModel.previewURL {
              cameraModel.showPreview.toggle()
            }
          } label: {
            Group {
              if cameraModel.isMergingStarted {
                //merging video
                ProgressView()
                  .tint(.pink)
              }
              else {
                if cameraModel.previewURL != nil {
                  NavigationLink(destination: MainEditorView(selectedVideoURl: cameraModel.previewURL)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)) {
                      Label {
                        Image(systemName: "chevron.right")
                          .font(.callout)
                      } icon: {
                        Text("Preview")
                      }
                      .foregroundStyle(Color.black)
                      
                    }
                }
              }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 8)
            .background {
              Capsule()
                .fill(.white)
            }
          }.frame(maxWidth: .infinity, alignment: .bottomTrailing)
            .padding(.trailing)
            .opacity(cameraModel.isRecording ? 0 : 1)
        }
        .frame(maxHeight: .infinity, alignment: .bottom)
        .padding(.bottom,10)
        .padding(.bottom,30)
        
        Button {
          cameraModel.recordeduration = 0
          cameraModel.previewURL = nil
          cameraModel.recordedURLs.removeAll()
        } label: {
          Text("Reset")
            .font(.title3)
            .foregroundStyle(Color.white)
            .padding(.top, 25)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding()
        .padding(.top)
      }
      .ignoresSafeArea()
      .animation(.easeInOut, value: cameraModel.showPreview)
      .preferredColorScheme(.light)
    }
  }
}


#Preview {
  RecordingContentView()
}
