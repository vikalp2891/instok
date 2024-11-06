//
//  CustomSlider.swift
//  TikTok
//
//  Created by Macbook  on 13/03/24.
//

import SwiftUI

struct CustomSlider<Value, Track, Thumb>: View
where Value: BinaryFloatingPoint, Value.Stride: BinaryFloatingPoint, Track: View, Thumb: View {

  @Binding var value: Value
  let bounds: ClosedRange<Value>
  let step: Value
  let minimumValueLabel: Text?
  let maximumValueLabel: Text?
  let onEditingChanged: ((Bool) -> Void)?
  let onChanged: (() -> Void)?
  let track: () -> Track
  let thumb: () -> Thumb
  let thumbSize: CGSize
  
  @State private var xOffset: CGFloat = 0
  @State private var lastOffset: CGFloat = 0
  @State private var trackSize: CGSize = .zero
  @State private var isOnChange: Bool = false
  
  
  init(value: Binding<Value>,
       in bounds: ClosedRange<Value> = 0...1,
       step: Value = 0.001,
       minimumValueLabel: Text? = nil,
       maximumValueLabel: Text? = nil,
       onEditingChanged: ((Bool) -> Void)? = nil,
       onChanged: (() -> Void)? = nil,
       track: @escaping () -> Track,
       thumb: @escaping () -> Thumb,
       thumbSize: CGSize) {
    _value = value
    self.bounds = bounds
    self.step = step
    self.minimumValueLabel = minimumValueLabel
    self.maximumValueLabel = maximumValueLabel
    self.onEditingChanged = onEditingChanged
    self.onChanged = onChanged
    self.track = track
    self.thumb = thumb
    self.thumbSize = thumbSize
  }
  
  private var percentage: Value {
    1 - (bounds.upperBound - value) / (bounds.upperBound - bounds.lowerBound)
  }
  
  private var fillWidth: CGFloat {
    trackSize.width * CGFloat(percentage)
  }
  
  var body: some View {
    HStack {
      minimumValueLabel
      ZStack {
        track()
          .measureSize {
            let firstInit = (trackSize == .zero)
            trackSize = $0
            if firstInit {
              xOffset = (trackSize.width - thumbSize.width) * CGFloat(percentage)
              lastOffset = xOffset
            }
          }
          .onChange(of: value) { _ in
            if !isOnChange{
              xOffset = (trackSize.width - thumbSize.width) * CGFloat(percentage)
              lastOffset = xOffset
            }
          }
      }

      .frame(width: trackSize.width, height: trackSize.height)
      .overlay(thumb()
        .position(x: thumbSize.width / 2,
                  y: thumbSize.height / 2)

        .frame(width: thumbSize.width, height: thumbSize.height)
        .offset(x: xOffset)
        .gesture(DragGesture(minimumDistance: 0).onChanged({ gestureValue in
          if abs(gestureValue.translation.width) < 0.1 {
            lastOffset = xOffset
            onEditingChanged?(true)
            isOnChange = true
          }

          let availableWidth = trackSize.width - thumbSize.width
          xOffset = max(0, min(lastOffset + gestureValue.translation.width, availableWidth))

          let newValue = (bounds.upperBound - bounds.lowerBound) * Value(xOffset / availableWidth) + bounds.lowerBound
          let steppedNewValue = (round(newValue / step) * step)
          value = min(bounds.upperBound, max(bounds.lowerBound, steppedNewValue))
          onChanged?()
        }).onEnded({ _ in
          onEditingChanged?(false)
          isOnChange = false
        })),
               alignment: .leading)
      
      maximumValueLabel
    }
    .frame(height: max(trackSize.height, thumbSize.height))
  }
}

struct CustomSlider_Previews: PreviewProvider {
  static var previews: some View {
    CustomSlider(value: .constant(10),
                 in: 10...255,
                 step: 90,
                 minimumValueLabel: Text("Min"),
                 maximumValueLabel: Text("Max"),
                 onEditingChanged: { started in
      print("started custom slider: \(started)")
    }, track: {
      Capsule()
        .foregroundColor(.init(red: 0.9, green: 0.9, blue: 0.9))
        .frame(width: 200, height: 5)
    }, thumb: {
      Circle()
        .foregroundColor(.white)
        .shadow(radius: 20 / 1)
    }, thumbSize: CGSize(width: 20, height: 20))
  }
}

struct SizePreferenceKey: PreferenceKey {
  static var defaultValue: CGSize = .zero
  
  static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
    value = nextValue()
  }
}

struct MeasureSizeModifier: ViewModifier {
  func body(content: Content) -> some View {
    content.background(GeometryReader { geometry in
      Color.clear.preference(key: SizePreferenceKey.self,
                             value: geometry.size)
    })
  }
}

extension View {
  func measureSize(perform action: @escaping (CGSize) -> Void) -> some View {
    self.modifier(MeasureSizeModifier())
      .onPreferenceChange(SizePreferenceKey.self, perform: action)
  }
}
