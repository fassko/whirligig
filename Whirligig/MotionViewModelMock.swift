//
//  MotionViewModelMock.swift
//  Whirligig
//
//  Created by Kristaps Grinbergs on 10/04/2020.
//  Copyright © 2020 fassko. All rights reserved.
//

import Foundation

import RxSwift

struct MotionViewModelMock: MotionViewModelProtocol {
  var isAccelerometerAvailable: Bool {
    true
  }
  
  func motionUpdates() -> Observable<MotionData> {
    Observable<MotionData>.create { observer in
      Timer.scheduledTimer(withTimeInterval: Constants.motionUpdateInerval, repeats: true) { _ in
        let yaw = Double.random(in: -1...1)
        let pitch = Double.random(in: -1...1)
        let roll = Double.random(in: -1...1)
        
        let rotationMatrix = RotationMatrix(m11: Double.random(in: -1...1),
                                            m12: Double.random(in: -1...1),
                                            m13: Double.random(in: -1...1),
                                            m21: Double.random(in: -1...1),
                                            m22: Double.random(in: -1...1),
                                            m23: Double.random(in: -1...1),
                                            m31: Double.random(in: -1...1),
                                            m32: Double.random(in: -1...1),
                                            m33: Double.random(in: -1...1))
        
        let gyroData = MotionData(yaw: yaw,
                                  pitch: pitch,
                                  roll: roll,
                                  rotationMatrix: rotationMatrix)
        
        observer.on(.next(gyroData))
      }
      
      return Disposables.create()
    }
  }
}
