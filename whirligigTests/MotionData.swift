//
//  MotionData.swift
//  Whirligig
//
//  Created by Kristaps Grinbergs on 11/04/2020.
//  Copyright © 2020 fassko. All rights reserved.
//

import Foundation

@testable import Whirligig

extension MotionData {
  static func mocked() -> Self {
    let rotationMatrix = RotationMatrix(m11: Double.random(in: -1...1),
                                        m12: Double.random(in: -1...1),
                                        m13: Double.random(in: -1...1),
                                        m21: Double.random(in: -1...1),
                                        m22: Double.random(in: -1...1),
                                        m23: Double.random(in: -1...1),
                                        m31: Double.random(in: -1...1),
                                        m32: Double.random(in: -1...1),
                                        m33: Double.random(in: -1...1))
    
    return MotionData(yaw: Double.random(in: -1...1),
                      pitch: Double.random(in: -1...1),
                      roll: Double.random(in: -1...1),
                      rotationMatrix: rotationMatrix)
  }
}
