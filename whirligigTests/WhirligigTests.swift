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

class WhirligigTests: XCTestCase {
  let disposeBag = DisposeBag()
  
  func testGyroData() throws {
    let recorder = Recorder<GyroData>()
    let gyroDataMocks: [GyroData] = [
      .mocked(),
      .mocked(),
      .mocked()
    ]
    let viewModel = MotionViewModelTestMock(gyroData: gyroDataMocks)
    
    recorder.on(valueSubject: viewModel.gyroDataProvider)
    viewModel.startGyroUpdates()
    
    waitOrFail(timeout: 1)
    XCTAssertEqual(recorder.items, gyroDataMocks)
  }
}

extension GyroData {
  static func mocked() -> Self {
    GyroData(x: Double.random(in: 0...1),
             y: Double.random(in: 0...1),
             z: Double.random(in: 0...1))
  }
}

extension XCTestCase {
  func waitOrFail(timeout: TimeInterval) {
    let expectation = self.expectation(description: #function)
    
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + timeout, execute: {
      expectation.fulfill()
    })
    
    wait(for: [expectation], timeout: timeout + 2)
  }
}

class Recorder<T> {
  var items = [T]()
  let bag = DisposeBag()
  
  func on(arraySubject: PublishSubject<[T]>) {
    arraySubject.subscribe(onNext: { value in
      self.items = value
    }).disposed(by: bag)
  }
  
  func on(valueSubject: PublishSubject<T>) {
    valueSubject.subscribe(onNext: { value in
      self.items.append(value)
    }).disposed(by: bag)
  }
}
