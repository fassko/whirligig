//
//  MotionViewModel.swift
//  Whirligig
//
//  Created by Kristaps Grinbergs on 10/04/2020.
//  Copyright © 2020 fassko. All rights reserved.
//

import CoreMotion
import Foundation

import RxSwift

struct MotionViewModel: MotionViewModelProtocol {
  
  private let motionManager = CMMotionManager()
  private let motionUpdateQueue = OperationQueue.current
  
  private let disposeBag = DisposeBag()
  
  init() {
    motionManager.gyroUpdateInterval = 0.2
  }
  
  func gyroUpdates() -> Observable<GyroData> {
    Observable<GyroData>.create { observer in
      self.motionManager.startDeviceMotionUpdates(to: .main) { data, error in
        if let error = error {
          observer.onError(error)
        } else if let data = data {
          
          let x = data.gravity.x
          let y = data.gravity.y
          let z = data.gravity.z
          let gyroData = GyroData(x: x,
                                  y: y,
                                  z: z)
          
          observer.onNext(gyroData)
        }
      }
      
      return Disposables.create()
    }
  }
    
//    motionManager.startGyroUpdates(to: motionUpdateQueue!) { data, error in
//      if let error = error {
//        self.gyroDataProvider.on(.error(error))
//      } else if let data = data {
//
//
//
//        let x = data.rotationRate.x
//        let y = data.rotationRate.y
//        let z = data.rotationRate.z
//        let gyroData = GyroData(x: x,
//                                y: y,
//                                z: z)
//        self.gyroDataProvider.on(.next(gyroData))
//      }
//    }
}
