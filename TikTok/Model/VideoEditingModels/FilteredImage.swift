//
//  FilteredImage.swift
//  TikTok
//
//  Created by Macbook  on 13/03/24.
//

import Foundation
import SwiftUI
import CoreImage

struct FilteredImage: Identifiable{
  var id: UUID = UUID()
  var image: UIImage
  var filter: CIFilter
}


enum CorrectionType: String, CaseIterable{
  case brightness = "Brightness"
  case contrast = "Contrast"
  case saturation = "Saturation"
  
  var key: String{
    switch self {
    case .brightness: return kCIInputBrightnessKey
    case .contrast: return kCIInputContrastKey
    case .saturation: return kCIInputSaturationKey
    }
  }
}


struct ColorCorrection{
  var brightness: Double = 0
  var contrast: Double = 0
  var saturation: Double = 0
}
