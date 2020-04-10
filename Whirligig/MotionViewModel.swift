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
  
  var xValue = PublishSubject<String>()
  var yValue = PublishSubject<String>()
  var zValue = PublishSubject<String>()
  
  private let motionManager = CMMotionManager()
  private let motionUpdateQueue = OperationQueue.current
  
  private let disposeBag = DisposeBag()
  
  init() {
    motionManager.gyroUpdateInterval = 0.2
  }
  
  func startGyroUpdates() {
    gyroDataProvider.asObservable()
    .subscribe(onNext: { gyroData in
      self.xValue.on(.next(String(gyroData.x)))
      self.yValue.on(.next(String(gyroData.y)))
      self.zValue.on(.next(String(gyroData.z)))
    }, onError: { error in
      self.xValue.on(.error(error))
      self.yValue.on(.error(error))
      self.zValue.on(.error(error))
    })
    .disposed(by: disposeBag)
    
    motionManager.startDeviceMotionUpdates(to: .main) { data, error in
      if let error = error {
        self.gyroDataProvider.on(.error(error))
      } else if let data = data {
        
        let x = data.gravity.x
        let y = data.gravity.y
        let z = data.gravity.z
        let gyroData = GyroData(x: x,
                                y: y,
                                z: z,
                                pitch: data.attitude.pitch)
        self.gyroDataProvider.on(.next(gyroData))
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
}
