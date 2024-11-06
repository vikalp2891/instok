//
//  VideoViewModel.swift
//  TikTok
//
//  Created by Macbook on 06/03/24.
//

import Foundation
import AVFoundation
import SwiftUI
import Swift

class CameraViewModel: NSObject, ObservableObject, AVCaptureFileOutputRecordingDelegate, AVCaptureVideoDataOutputSampleBufferDelegate {
  @Published var session = AVCaptureSession()
  @Published var alert = false
  @Published var output = AVCaptureMovieFileOutput()
  @Published var preview: AVCaptureVideoPreviewLayer!
  @Published var filteredImage: UIImage?
  
  // MARK: Video recorder properties
  @Published var isRecording: Bool = false
  @Published var recordedURLs: [URL] = []
  @Published var previewURL: URL?
  @Published var isMergingStarted: Bool = false
  @Published var showPreview: Bool = false
  @Published var isFrontCamera: Bool = false
  
  // MARK: Tpo progress bar
  @Published var recordeduration: TimeInterval = 0
  @Published var maxDuration: TimeInterval = 15
  
  func checkPermission() {
    switch AVCaptureDevice.authorizationStatus(for: .video) {
    case .authorized:
      setUp()
    case .notDetermined:
      AVCaptureDevice.requestAccess(for: .video) { status in
        DispatchQueue.main.async {
          if status {
            self.setUp()
          }
        }
      }
    case .denied:
      alert.toggle()
    default:
      break
    }
  }
  
  func setUp() {
    DispatchQueue.main.async { [self] in
      do {
        session.beginConfiguration()
        session.sessionPreset = .high // Adjust session preset as needed
        let cameraDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: isFrontCamera ? .front : .back)
        let videoInput = try AVCaptureDeviceInput(device: cameraDevice!)
        let videoOutput = AVCaptureVideoDataOutput()
        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "sample buffer delegate"))
        let audioDevice = AVCaptureDevice.default(for: .audio)
        let audioInput = try AVCaptureDeviceInput(device: audioDevice!)
        if session.canAddOutput(videoOutput) {
          session.addOutput(videoOutput)
        }
        if session.canAddInput(videoInput) && session.canAddInput(audioInput) {
          session.addInput(videoInput)
          session.addInput(audioInput)
        }
        if session.canAddOutput(output) {
          session.addOutput(output)
        }
        session.commitConfiguration()
        DispatchQueue.global(qos: .background).async {
          self.session.startRunning()
        }
      } catch {
        print(error.localizedDescription)
      }
    }
  }
  
  func tearDownSession() {
    DispatchQueue.main.async { [self] in
      session.beginConfiguration()
      
      // Remove inputs
      session.inputs.forEach { input in
        session.removeInput(input)
      }
      
      // Remove outputs
      session.outputs.forEach { output in
        session.removeOutput(output)
      }
      
      session.commitConfiguration()
    }
  }
  
  func flipCameras() {
    tearDownSession()
    setUp()
  }

  
  func startRecording() {
    let tempURL = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true).appendingPathComponent("\(Date()).mov")
    output.startRecording(to: tempURL, recordingDelegate: self)
    isRecording = true
  }
  
  func stopRecording() {
    output.stopRecording()
    isRecording = false
  }
  
  func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
    guard let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
    var ciImage = CIImage(cvPixelBuffer: imageBuffer)
    ciImage = ciImage.oriented(forExifOrientation: 6)
    let filteredImage = ciImage
    
    if let cgImage = CIContext().createCGImage(filteredImage, from: filteredImage.extent) {
      let uiImage = UIImage(cgImage: cgImage)
      DispatchQueue.main.async {
         self.filteredImage = uiImage
      }
    }
  }
  
  func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
    if let error = error {
      print(error.localizedDescription)
      return
    }
    
    recordedURLs.append(outputFileURL)
    
    // If this is the first recorded video, set the preview URL to this video
    if recordedURLs.count == 1 {
      previewURL = outputFileURL
      return
    }
    self.previewURL = nil
    self.isMergingStarted = true
    // Merging videos
    let assets = recordedURLs.compactMap { url -> AVURLAsset in
      return AVURLAsset(url: url)
    }
    
    mergeVideos(assets: assets) { (outputURL, error) in
      self.isMergingStarted = false
      if let error = error {
        print(error.localizedDescription)
      } else if let finalURL = outputURL {
        print("Final merged URL: \(finalURL)")
        DispatchQueue.main.async {
          self.previewURL = finalURL
        }
      }
    }
  }
  
  func mergeVideos(assets: [AVURLAsset], completion: @escaping (_ outputURL: URL?, _ error: Error?) -> ()) {
    let composition = AVMutableComposition()
    var insertTime: CMTime = .zero
    
    guard let videoTrack = composition.addMutableTrack(withMediaType: .video, preferredTrackID: kCMPersistentTrackID_Invalid) else { return }
    guard let audioTrack = composition.addMutableTrack(withMediaType: .audio, preferredTrackID: kCMPersistentTrackID_Invalid) else { return }
    
    let rotationAngle: CGFloat = 3 * .pi / 2
    let transform = CGAffineTransform(rotationAngle: rotationAngle)
    if UIDevice.current.orientation.isPortrait {
        videoTrack.preferredTransform = transform.rotated(by: .pi)
    } else {
        videoTrack.preferredTransform = transform
    }
    
    for asset in assets {
      do {
        let videoAssetTrack = asset.tracks(withMediaType: .video)[0]
        let audioAssetTrack = asset.tracks(withMediaType: .audio).first
        
        let duration = asset.duration
        
        try videoTrack.insertTimeRange(CMTimeRange(start: .zero, duration: duration), of: videoAssetTrack, at: insertTime)
        
        if let audioAssetTrack = audioAssetTrack {
          try audioTrack.insertTimeRange(CMTimeRange(start: .zero, duration: duration), of: audioAssetTrack, at: insertTime)
        }
        
        insertTime = CMTimeAdd(insertTime, duration)
      } catch {
        completion(nil, error) // Pass error to the completion handler
        return
      }
    }
    
    let tempURL = URL(fileURLWithPath: NSTemporaryDirectory() + "Load \(Date()).mp4")
    
    let exporter = AVAssetExportSession(asset: composition, presetName: AVAssetExportPresetHighestQuality)
    exporter?.outputFileType = .mp4
    exporter?.outputURL = tempURL
    
    exporter?.exportAsynchronously {
      DispatchQueue.main.async {
        if let exporter = exporter {
          switch exporter.status {
          case .failed:
            completion(nil, exporter.error) // Pass error to the completion handler
          case .completed:
            completion(exporter.outputURL, nil) // Pass outputURL to the completion handler
          default:
            break
          }
        } else {
          completion(nil, NSError(domain: "ExportSessionError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Exporter is nil"])) // Pass error to the completion handler
        }
      }
    }
  }
}
