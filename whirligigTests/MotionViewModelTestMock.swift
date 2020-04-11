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
  
  private let testableGyroData: TestableObservable<GyroData>
  
  init(testableGyroData: TestableObservable<GyroData>) {
    self.testableGyroData = testableGyroData
  }
  
  func gyroUpdates() -> Observable<GyroData> {
    testableGyroData.asObservable()
  }
}
