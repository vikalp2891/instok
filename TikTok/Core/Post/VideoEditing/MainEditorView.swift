//
//  MainEditorView.swift
//  TikTok
//
//  Created by Macbook  on 13/03/24.
//

import SwiftUI

struct MainEditorView: View {
  @Environment(\.scenePhase) private var scenePhase
  @Environment(\.dismiss) private var dismiss
  var selectedVideoURl: URL?
  @State var isFullScreen: Bool = false
  @State var showVideoQualitySheet: Bool = false
  @State var showRecordView: Bool = false
  @StateObject var editorVM = EditorViewModel()
  @StateObject var audioRecorder = AudioRecorderManager()
  @StateObject var videoPlayer = VideoPlayerManager()
  @StateObject var textEditor = TextEditorViewModel()
  
  var body: some View {
    ZStack{
      GeometryReader { proxy in
        VStack(spacing: 0){
          headerView
          PlayerHolderView(isFullScreen: $isFullScreen, editorVM: editorVM, videoPlayer: videoPlayer, textEditor: textEditor)
            .frame(height: proxy.size.height / (isFullScreen ?  1.25 : 1.8))
            .padding(.top, -60)
          PlayerControl(isFullScreen: $isFullScreen, recorderManager: audioRecorder, editorVM: editorVM, videoPlayer: videoPlayer, textEditor: textEditor)
            .padding(.top, -10)
          ToolsSectionView(videoPlayer: videoPlayer, editorVM: editorVM, textEditor: textEditor)
            .opacity(isFullScreen ? 0 : 1)
            .padding(.top, 5)
        }
        .onAppear{
          setVideo(proxy)
        }
      }
      
      if showVideoQualitySheet, let video = editorVM.currentVideo{
        VideoExporterBottomSheetView(isPresented: $showVideoQualitySheet, video: video)
      }
    }
    .background(Color.black)
    .navigationBarHidden(true)
    .navigationBarBackButtonHidden(false)
    .ignoresSafeArea(.all, edges: .top)
    .statusBar(hidden: false)
    .blur(radius: textEditor.showEditor ? 10 : 0)
    .ignoresSafeArea(.keyboard, edges: .bottom)
    .overlay {
      if textEditor.showEditor{
        TextEditorView(viewModel: textEditor, onSave: editorVM.setText)
      }
    }
  }
}

#Preview {
  MainEditorView(selectedVideoURl: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4"))
}

extension MainEditorView{
  private var headerView: some View{
    HStack{
      Button {
        dismiss()
      } label: {
        Image(systemName: "arrowshape.backward.fill")
          .resizable()
      }
      .frame(width: 25, height: 25)
      
      Spacer()
      
      Button {
        editorVM.selectedTools = nil
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
          showVideoQualitySheet.toggle()
        }
      } label: {
        Image(systemName: "square.and.arrow.up.fill")
          .resizable()
      }
      .frame(width: 25, height: 25)
    }
    .foregroundColor(.white)
    .padding(.horizontal, 20)
    .frame(height: 40)
    .padding(.top, 40)
  }
  
  private func setVideo(_ proxy: GeometryProxy){
    if let selectedVideoURl{
      videoPlayer.loadState = .loaded(selectedVideoURl)
      editorVM.setNewVideo(selectedVideoURl, geo: proxy)
    }
  }
}
