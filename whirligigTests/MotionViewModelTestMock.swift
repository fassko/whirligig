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
  
  private let testableMotionData: TestableObservable<MotionData>
  
  init(testableMotionData: TestableObservable<MotionData>) {
    self.testableMotionData = testableMotionData
  }
  
  func motionUpdates() -> Observable<MotionData> {
    testableMotionData.asObservable()
  }
}
