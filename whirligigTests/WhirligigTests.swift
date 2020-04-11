//
//  whirligigTests.swift
//  whirligigTests
//
//  Created by Kristaps Grinbergs on 10/04/2020.
//  Copyright © 2020 fassko. All rights reserved.
//

import XCTest

@testable import Whirligig

import RxSwift
import RxBlocking
import RxTest

class WhirligigTests: XCTestCase {
  let disposeBag = DisposeBag()
  
  func testMock() {
    let scheduler = TestScheduler(initialClock: 0)
    
    let gyroDataFirst = GyroData.mocked()
    let gyroDataSecond = GyroData.mocked()
    let gyroDataThird = GyroData.mocked()
    
    let expectedEvents: [Recorded<Event<GyroData>>] = [
      Recorded.next(200, gyroDataFirst),
      Recorded.next(400, gyroDataSecond),
      Recorded.next(600, gyroDataThird)
    ]
    
    let gyroDataObservable = scheduler.createHotObservable([
      Recorded.next(200, gyroDataFirst),
      Recorded.next(400, gyroDataSecond),
      Recorded.next(600, gyroDataThird)
    ])
    
    let viewModel: MotionViewModelProtocol = MotionViewModelTestMock(testableGyroData: gyroDataObservable)
    
    let gyroDataObserver = scheduler.createObserver(GyroData.self)
    scheduler.scheduleAt(0) {
      viewModel.gyroUpdates()
      .asObservable()
      .subscribe(gyroDataObserver)
      .disposed(by: self.disposeBag)
    }
    scheduler.start()

    XCTAssertEqual(gyroDataObserver.events, expectedEvents)
  }
}

extension GyroData {
  static func mocked() -> Self {
    GyroData(x: Double.random(in: 0...1),
             y: Double.random(in: 0...1),
             z: Double.random(in: 0...1),
             pitch: Double.random(in: 0...1))
  }
}
