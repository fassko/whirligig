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
  var xValue = PublishSubject<String>()
  var yValue = PublishSubject<String>()
  var zValue = PublishSubject<String>()
  
  var gyroDataProvider = PublishSubject<GyroData>()
  
  func startGyroUpdates() {
    Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { _ in
      let x = Double.random(in: 0...1)
      let y = Double.random(in: 1...2)
      let z = Double.random(in: 2...3)
      let gyroData = GyroData(x: x, y: y, z: z)
      
      self.xValue.on(.next(String(x)))
      self.yValue.on(.next(String(y)))
      self.zValue.on(.next(String(z)))
      
      self.gyroDataProvider.on(.next(gyroData))
    }
  }
}
