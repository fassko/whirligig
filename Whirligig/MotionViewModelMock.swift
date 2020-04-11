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
  
  var gyroDataProvider = PublishSubject<GyroData>()
  
  func startGyroUpdates() {
    Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { _ in
      let x = Double.random(in: -1...1)
      let y = Double.random(in: -1...1)
      let z = Double.random(in: -1...1)
      let gyroData = GyroData(x: x, y: y, z: z, pitch: Double.random(in: -1...1))
      
      self.gyroDataProvider.on(.next(gyroData))
    }
  }
}
