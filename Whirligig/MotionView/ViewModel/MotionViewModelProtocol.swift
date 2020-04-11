//
//  MotionViewModelProtocol.swift
//  Whirligig
//
//  Created by Kristaps Grinbergs on 10/04/2020.
//  Copyright © 2020 fassko. All rights reserved.
//

import Foundation

import RxSwift

protocol MotionViewModelProtocol {
  var isAccelerometerAvailable: Bool { get }
  
  func motionUpdates() -> Observable<MotionData>
}
