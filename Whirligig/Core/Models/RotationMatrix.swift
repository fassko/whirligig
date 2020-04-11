//
//  RotationMatrix.swift
//  Whirligig
//
//  Created by Kristaps Grinbergs on 11/04/2020.
//  Copyright © 2020 fassko. All rights reserved.
//

import Foundation

struct RotationMatrix: Equatable {
  let m11, m12, m13: Double
  let m21, m22, m23: Double
  let m31, m32, m33: Double
}

extension RotationMatrix {
  static func mocked() -> Self {
    RotationMatrix(m11: Double.random(in: -1...1),
                   m12: Double.random(in: -1...1),
                   m13: Double.random(in: -1...1),
                   m21: Double.random(in: -1...1),
                   m22: Double.random(in: -1...1),
                   m23: Double.random(in: -1...1),
                   m31: Double.random(in: -1...1),
                   m32: Double.random(in: -1...1),
                   m33: Double.random(in: -1...1))
  }
}
