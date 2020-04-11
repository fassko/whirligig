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
  var gyroDataProvider = PublishSubject<GyroData>()
  
  private let motionManager = CMMotionManager()
  
  init() {
    motionManager.gyroUpdateInterval = Constants.motionUpdateInerval
  }
  
  func startGyroUpdates() {
    motionManager.startDeviceMotionUpdates(to: .main) { data, error in
      if let error = error {
        self.gyroDataProvider.on(.error(error))
      } else if let data = data {
        
        let x = data.gravity.x
        let y = data.gravity.y
        let z = data.gravity.z
        let gyroData = GyroData(x: x,
                                y: y,
                                z: z)
        
        self.gyroDataProvider.on(.next(gyroData))
      }
    }
  }
  
  private let disposeBag = DisposeBag()
    
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
