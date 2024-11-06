//
//  ToolModel.swift
//  TikTok
//
//  Created by Macbook  on 13/03/24.
//

import Foundation


enum ToolEnum: Int, CaseIterable{
  case cut, speed, crop, audio, text, filters, corrections, frames
  
  var title: String{
    switch self {
    case .cut: return "Cut"
    case .speed: return "Speed"
    case .crop: return "Crop"
    case .audio: return "Audio"
    case .text: return "Text"
    case .filters: return "Filters"
    case .corrections: return "Corrections"
    case .frames: return "Frames"
    }
  }
  
  var image: String{
    switch self {
    case .cut: return "scissors"
    case .speed: return "timer"
    case .crop: return "crop"
    case .audio: return "waveform"
    case .text: return "t.square.fill"
    case .filters: return "camera.filters"
    case .corrections: return "circle.righthalf.filled"
    case .frames: return "person.crop.artframe"
    }
  }
  
  var timeState: TimeLineViewState{
    switch self{
    case .audio: return .audio
    case .text: return .text
    default: return .empty
    }
  }
}


