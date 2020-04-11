//
//  MotionData.swift
//  Whirligig
//
//  Created by Kristaps Grinbergs on 11/04/2020.
//  Copyright © 2020 fassko. All rights reserved.
//

import Foundation

struct MotionData: Equatable {
  let yaw: Double
  let pitch: Double
  let roll: Double
  
  let rotationMatrix: RotationMatrix
}

extension MotionData {
  static func mocked() -> Self {
    MotionData(yaw: Double.random(in: -1...1),
               pitch: Double.random(in: -1...1),
               roll: Double.random(in: -1...1),
               rotationMatrix: RotationMatrix.mocked())
  }
}
