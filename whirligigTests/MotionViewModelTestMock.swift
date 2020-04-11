//
//  MotionViewModelTestMock.swift
//  Whirligig
//
//  Created by Kristaps Grinbergs on 11/04/2020.
//  Copyright © 2020 fassko. All rights reserved.
//

import Foundation

@testable import Whirligig

import RxSwift
import RxTest

struct MotionViewModelTestMock: MotionViewModelProtocol {
  var gyroDataProvider = PublishSubject<GyroData>()
  
  private let gyroData: [GyroData]
  
  init(gyroData: [GyroData]) {
    self.gyroData = gyroData
  }
  
  func startGyroUpdates() {
    gyroData.forEach {
      gyroDataProvider.on(.next($0))
    }
  }
}
