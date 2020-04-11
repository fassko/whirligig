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
  var isAccelerometerAvailable: Bool {
    true
  }
  
  func motionUpdates() -> Observable<MotionData> {
    Observable<MotionData>.create { observer in
      Timer.scheduledTimer(withTimeInterval: Constants.motionUpdateInerval, repeats: true) { _ in
        observer.on(.next(MotionData.mocked()))
      }
      
      return Disposables.create()
    }
  }
}
