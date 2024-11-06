//
//  UIImage+Ext.swift
//  TikTok
//
//  Created by Macbook  on 13/03/24.
//

import Foundation
import SwiftUI

extension UIImage{
  
  func resize(to size: CGSize, scale: CGFloat = 1.0) -> UIImage{
    let format = UIGraphicsImageRendererFormat.default()
    format.scale = scale
    let renderer = UIGraphicsImageRenderer(size: size, format: format)
    return renderer.image { _ in draw(in: CGRect(origin: .zero, size: size))}
  }
}

