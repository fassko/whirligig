//
//  WhirligigImageView.swift
//  Whirligig
//
//  Created by Kristaps Grinbergs on 11/04/2020.
//  Copyright © 2020 fassko. All rights reserved.
//

import UIKit

class WhirligigImageView: UIImageView {
  func rotate(with motionData: MotionData) {
    /// https://stackoverflow.com/questions/56753665/swift-3d-rotation-of-uiimageview-cgaffinetransform-or-catransform3d
    var transform: CATransform3D
    
    transform = CATransform3DMakeRotation(CGFloat(motionData.pitch), 1, 0, 0) // X rotation
    transform = CATransform3DRotate(transform, CGFloat(motionData.roll), 0, 1, 0) // Y rotation
    transform = CATransform3DRotate(transform, CGFloat(motionData.yaw), 0, 0, 1) // Z rotation
    
    // Transform taking in consideration coordinate space
    let rotationMatrix = motionData.rotationMatrix
    transform = CATransform3D(
      m11: CGFloat(rotationMatrix.m11), m12: CGFloat(rotationMatrix.m12), m13: CGFloat(rotationMatrix.m13), m14: 0,
      m21: CGFloat(rotationMatrix.m21), m22: CGFloat(rotationMatrix.m22), m23: CGFloat(rotationMatrix.m23), m24: 0,
      m31: CGFloat(rotationMatrix.m31), m32: CGFloat(rotationMatrix.m32), m33: CGFloat(rotationMatrix.m33), m34: 0,
      m41: 0, m42: 0, m43: 0, m44: 1)
    
    layer.transform = transform
    setNeedsDisplay()
  }
}
