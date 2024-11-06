//
//  cameraModelView.swift
//  TikTok
//
//  Created by Macbook on 06/03/24.
//

import SwiftUI
import AVFoundation

// MARK: Capture Video

struct CameraView: View {
  @StateObject private var cameraModel = CameraViewModel()
  @State private var player = AVPlayer()
  @EnvironmentObject var router: Router
  @State private var isBottomSheetShowing = false
  @State private var capturedImage: UIImage?
  @State private var imageCaptured = false
  
  @State private var progress: CGFloat = 0.0
  let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
  @State private var showAlert = false
  @State private var showFilters = false
  
  var body: some View {
    ZStack {
      
      if let filteredImage = cameraModel.filteredImage {
        Image(uiImage: filteredImage)
          .resizable()
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .aspectRatio(contentMode: .fill)
        
          .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
            .onEnded({ value in
              if value.translation.width < 0 {
                // left
              }
              
              if value.translation.width > 0 {
                // right
              }
              if value.translation.height < 0 {
                // up
              }
              
              if value.translation.height > 0 {
                // down
              }
            }))
        
      }
      GeometryReader { size in
        VStack {
          if !cameraModel.isRecording {
            HStack {
              Button {
                self.showAlert = true
              } label: {
                Image(systemName: "x.circle.fill")
                  .resizable()
                  .foregroundColor(.gray)
                  .frame(width: 25, height: 25)
              }
              .frame(width: 50, height: 50)
              .background(.white)
              .clipShape(RoundedRectangle(cornerRadius: 12))
              .padding(.leading, 12)
              
              
              Button {
                cameraModel.isFrontCamera.toggle()
                cameraModel.flipCameras()
              } label: {
                Image(systemName: "arrow.triangle.2.circlepath.camera")
                  .resizable()
                  .frame(width: 45, height: 38)
                  .foregroundColor(.white)
              }
              .padding(.horizontal, 24)
            }
            .background(.gray.opacity(0.4))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding(.top, 12)
            .padding(.horizontal, 4)
          }
          
          
          Spacer()
          
          ZStack() {
            ZStack {
              
              VStack {
                ZStack {
                  HStack() {
                    Spacer()
                    if !cameraModel.isRecording && cameraModel.previewURL != nil {
                      ZStack {
                        Button {
                          router.navigate(to: .mainEditorView(selectedVideoURl: cameraModel.previewURL!))
                        } label: {
                          HStack {
                            Text("Preview")
                              .font(.title3)
                              .foregroundStyle(.gray)
                            
                            Image(systemName: "arrowshape.right.fill")
                              .foregroundColor(.gray)
                          }
                          .padding(.vertical, 12)
                          .padding(.horizontal, 12)
                        }
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                      }
                      .padding()
                    }
                  }
                  .frame(maxWidth: .infinity)
                  
                  ZStack {
                    Circle()
                      .stroke(lineWidth: 4) // Decrease stroke width for background circle
                      .opacity(cameraModel.isRecording ? 0.6 : 0.3)
                      .foregroundColor(.white)
                      .frame(width: 80, height: 80)
                    
                    Circle()
                      .trim(from: 0.0, to: progress)
                      .stroke(style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
                      .foregroundColor(.white)
                      .rotationEffect(.degrees(-90))
                      .frame(width: 80, height: 80)
                    
                    
                    
                    
                    Button {
                      if !cameraModel.isRecording {
                        cameraModel.previewURL = nil
                        cameraModel.startRecording()
                      } else {
                        cameraModel.stopRecording()
                      }
                    } label: {
                      Circle()
                        .frame(width: 55, height: 55)
                        .foregroundColor(cameraModel.isRecording ? .red : .white)
                    }
                    
                    if cameraModel.isRecording {
                      Button {
                        if cameraModel.isRecording {
                          cameraModel.stopRecording()
                        }
                      } label: {
                        Circle()
                          .frame(width: 75, height: 75)
                          .foregroundColor(.red)
                      }
                    }
                  }
                }
              }
              
              
              
            }
            .frame(maxWidth: .infinity)
            .onReceive(timer) { _ in
              if cameraModel.recordeduration <= cameraModel.maxDuration && cameraModel.isRecording {
                debugPrint("RD-\(cameraModel.recordeduration) - MD-\(cameraModel.maxDuration)")
                withAnimation {
                  cameraModel.recordeduration += 0.1
                  progress = CGFloat(cameraModel.recordeduration / cameraModel.maxDuration)
                }
              }
              if cameraModel.recordeduration >= cameraModel.maxDuration && cameraModel.isRecording {
                cameraModel.stopRecording()
              }
            }
            
            
          }
          .padding()
        }
        
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    .onAppear {
      cameraModel.checkPermission()
    }
    .onDisappear {
      cameraModel.session.stopRunning()
    }
    .sheet(isPresented: $showAlert) {
      ConfirmationView(isPresented: $showAlert, onDelete: {
        progress = 0.0
        cameraModel.recordeduration = 0.0
        cameraModel.previewURL = nil
        cameraModel.recordedURLs = []
      })
      .presentationDetents([.fraction(0.2), .height(200), .medium, .large])
    }
    .sheet(isPresented: $showFilters, onDismiss: {
      // Code to execute when the sheet is dismissed
      print("Sheet dismissed!")
      imageCaptured = false
    }) {
      if let capturedImage = capturedImage {
        EmptyView()
      } else {
        Text("No image captured yet")
      }
    }
    .presentationDetents([.fraction(0.2), .height(200), .medium, .large])
    .background(.black)
  }
}

#Preview {
  CameraView()
}

struct ConfirmationView: View {
  @Binding var isPresented: Bool
  let onDelete: () -> Void
  
  var body: some View {
    ZStack {
      Color.black.opacity(0).ignoresSafeArea()
      VStack {
        Text("Are you sure you want to delete the recording?")
        HStack {
          Spacer()
          
          Button("Delete") {
            onDelete()
            isPresented = false
          }
          .foregroundColor(.red)
          .padding()
          
          Spacer()
          
          Button("Cancel") {
            isPresented = false
          }
          .foregroundStyle(.black)
          .padding()
          
          Spacer()
        }
      }
      .padding()
      .background(.white)
      .frame(maxWidth: .infinity)
    }
    .frame(maxWidth: .infinity)
  }
}
