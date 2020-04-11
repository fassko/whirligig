//
//  MotionViewModel.swift
//  Whirligig
//
//  Created by Kristaps Grinbergs on 10/04/2020.
//  Copyright © 2020 fassko. All rights reserved.
//

import CoreMotion
import Foundation

import RxSwift

struct MotionViewModel: MotionViewModelProtocol {
  private let motionManager = CMMotionManager()
  
  func gyroUpdates() -> Observable<GyroData> {
    Observable<GyroData>.create { observer in
      self.motionManager.rx.acceleration?
        .subscribe(onNext: { gyroData in
          observer.onNext(gyroData)
        }, onError: { error in
          observer.onError(error)
        }).disposed(by: self.disposeBag)
      
      return Disposables.create()
    }
  }
  
  private let disposeBag = DisposeBag()
}
