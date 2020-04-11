//
//  RxSwift+CoreMotion.swift
//  Whirligig
//
//  Created by Kristaps Grinbergs on 11/04/2020.
//  Copyright © 2020 fassko. All rights reserved.
//

import CoreMotion
import Foundation

import RxSwift

/// https://github.com/RxSwiftCommunity/RxCoreMotion/blob/master/Pod/Classes/MotionActivityManager.swift

private var accelerationKey: UInt8 = 0

enum MotionError: Error {
  case notAvailable
}

extension Reactive where Base: CMMotionManager {
  var acceleration: Observable<MotionData> {
    if !self.base.isAccelerometerAvailable {
      return Observable.error(MotionError.notAvailable)
    }
    
    /// Memoize this closure,
    /// because we don't want to create a different `RxSwift.Observable` for each `acceleration` variable call.
    /// See `Memoization.memoize` for more information about memoization in `CMMotionManager` instances
    return memoize(key: &accelerationKey) {
      Observable.create { observer in
        let motionManager = self.base
        
        let operationQueue = OperationQueue()
        operationQueue.maxConcurrentOperationCount = 1
        motionManager.deviceMotionUpdateInterval = Constants.motionUpdateInerval
        
        if let currentQueue = OperationQueue.current {
          motionManager.startDeviceMotionUpdates(using: .xArbitraryCorrectedZVertical,
                                                 to: currentQueue) { data, error in
            if let error = error {
              observer.onError(error)
            } else if let attitude = data?.attitude {
              let rotationMatrix = RotationMatrix(m11: attitude.rotationMatrix.m11,
                                                  m12: attitude.rotationMatrix.m12,
                                                  m13: attitude.rotationMatrix.m13,
                                                  m21: attitude.rotationMatrix.m21,
                                                  m22: attitude.rotationMatrix.m22,
                                                  m23: attitude.rotationMatrix.m23,
                                                  m31: attitude.rotationMatrix.m31,
                                                  m32: attitude.rotationMatrix.m32,
                                                  m33: attitude.rotationMatrix.m22)
              
              let motionData = MotionData(yaw: attitude.yaw,
                                          pitch: attitude.pitch,
                                          roll: attitude.roll,
                                          rotationMatrix: rotationMatrix)
              observer.on(.next(motionData))
            }
          }
        }
        
        return Disposables.create {
          motionManager.stopAccelerometerUpdates()
        }
      }.share(replay: 1)
    }
  }
}
