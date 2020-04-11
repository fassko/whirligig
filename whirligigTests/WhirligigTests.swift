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
import RxTest

class WhirligigTests: XCTestCase {
  let disposeBag = DisposeBag()
  
  func testMotionData() {
    let scheduler = TestScheduler(initialClock: 0)

    let gyroDataFirst = MotionData.mocked()
    let gyroDataSecond = MotionData.mocked()
    let gyroDataThird = MotionData.mocked()

    let expectedEvents: [Recorded<Event<MotionData>>] = [
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

    let gyroDataObserver = scheduler.createObserver(MotionData.self)
    scheduler.scheduleAt(0) {
      viewModel.motionUpdates()
        .asObservable()
        .subscribe(gyroDataObserver)
        .disposed(by: self.disposeBag)
    }
    scheduler.start()

    XCTAssertEqual(gyroDataObserver.events, expectedEvents)
  }
  
  func testMotionDataError() {
    let scheduler = TestScheduler(initialClock: 0)

    let expectedEvents: [Recorded<Event<MotionData>>] = [
      Recorded.error(100, MotionError.notAvailable)
    ]

    let events: [Recorded<Event<MotionData>>] = [.error(100, MotionError.notAvailable)]
    let gyroDataObservable = scheduler.createHotObservable(events)

    let viewModel: MotionViewModelProtocol = MotionViewModelTestMock(testableGyroData: gyroDataObservable)

    let gyroDataObserver = scheduler.createObserver(MotionData.self)
    scheduler.scheduleAt(0) {
      viewModel.motionUpdates()
        .asObservable()
        .subscribe(gyroDataObserver)
        .disposed(by: self.disposeBag)
    }
    scheduler.start()

    XCTAssertEqual(gyroDataObserver.events, expectedEvents)
  }
}
