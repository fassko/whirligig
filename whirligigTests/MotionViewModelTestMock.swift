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
  var isAccelerometerAvailable: Bool {
    false
  }
  
  
  private let testableGyroData: TestableObservable<MotionData>
  
  init(testableGyroData: TestableObservable<MotionData>) {
    self.testableGyroData = testableGyroData
  }
  
  func motionUpdates() -> Observable<MotionData> {
    testableGyroData.asObservable()
  }
}
