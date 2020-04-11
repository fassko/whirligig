//
//  GyroData.swift
//  Whirligig
//
//  Created by Kristaps Grinbergs on 11/04/2020.
//  Copyright © 2020 fassko. All rights reserved.
//

import Foundation

@testable import Whirligig

extension GyroData {
  static func mocked() -> Self {
    GyroData(x: Double.random(in: 0...1),
             y: Double.random(in: 0...1),
             z: Double.random(in: 0...1))
  }
}
