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

fileprivate var accelerationKey: UInt8 = 0

enum MotionError: Error {
  case notAvailable
}

extension Reactive where Base: CMMotionManager {
  var acceleration: Observable<GyroData> {
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
        
        motionManager.startDeviceMotionUpdates(to: .main) { data, error in
          if let error = error {
            observer.onError(error)
          } else if let gravity = data?.gravity {
            observer.on(.next(GyroData(x: gravity.x, y: gravity.y, z: gravity.z)))
          }
        }
        
        return Disposables.create {
          motionManager.stopAccelerometerUpdates()
        }
      }.share(replay: 1)
    }
  }
}
