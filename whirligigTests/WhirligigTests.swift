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

    let motionDataFirst = MotionData.mocked()
    let motionDataSecond = MotionData.mocked()
    let motionDataThird = MotionData.mocked()

    let expectedEvents: [Recorded<Event<MotionData>>] = [
      Recorded.next(200, motionDataFirst),
      Recorded.next(400, motionDataSecond),
      Recorded.next(600, motionDataThird)
    ]

    let motionDataObservable = scheduler.createHotObservable([
      Recorded.next(200, motionDataFirst),
      Recorded.next(400, motionDataSecond),
      Recorded.next(600, motionDataThird)
    ])

    let viewModel: MotionViewModelProtocol = MotionViewModelTestMock(testableMotionData: motionDataObservable)

    let motionDataObserver = scheduler.createObserver(MotionData.self)
    scheduler.scheduleAt(0) {
      viewModel.motionUpdates()
        .asObservable()
        .subscribe(motionDataObserver)
        .disposed(by: self.disposeBag)
    }
    scheduler.start()

    XCTAssertEqual(motionDataObserver.events, expectedEvents)
  }
  
  func testMotionDataError() {
    let scheduler = TestScheduler(initialClock: 0)

    let expectedEvents: [Recorded<Event<MotionData>>] = [
      Recorded.error(100, MotionError.notAvailable)
    ]

    let events: [Recorded<Event<MotionData>>] = [.error(100, MotionError.notAvailable)]
    let motionDataObservable = scheduler.createHotObservable(events)

    let viewModel: MotionViewModelProtocol = MotionViewModelTestMock(testableMotionData: motionDataObservable)

    let motionDataObserver = scheduler.createObserver(MotionData.self)
    scheduler.scheduleAt(0) {
      viewModel.motionUpdates()
        .asObservable()
        .subscribe(motionDataObserver)
        .disposed(by: self.disposeBag)
    }
    scheduler.start()

    XCTAssertEqual(motionDataObserver.events, expectedEvents)
  }
}
