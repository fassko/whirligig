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
  func gyroUpdates() -> Observable<GyroData> {
    Observable<GyroData>.create { observer in
      Timer.scheduledTimer(withTimeInterval: Constants.motionUpdateInerval, repeats: true) { _ in
        let x = Double.random(in: -1...1)
        let y = Double.random(in: -1...1)
        let z = Double.random(in: -1...1)
        let gyroData = GyroData(x: x, y: y, z: z)
        
        observer.on(.next(gyroData))
      }
      
      return Disposables.create()
    }
  }
}
