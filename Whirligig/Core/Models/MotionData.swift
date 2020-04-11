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
