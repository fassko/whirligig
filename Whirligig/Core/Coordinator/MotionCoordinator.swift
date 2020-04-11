//
//  MotionCoordinator.swift
//  Whirligig
//
//  Created by Kristaps Grinbergs on 10/04/2020.
//  Copyright © 2020 fassko. All rights reserved.
//

import Foundation
import UIKit

class MotionCoordinator: Coordinator {
  
  let window: UIWindow?
  
  init(_ window: UIWindow?) {
    self.window = window
  }
  
  func start() {
    let motionViewController = MotionViewController.instantiate()
    
    motionViewController.viewModel = {
      if CommandLine.mockGyroData {
         return MotionViewModelMock()
      } else {
        return MotionViewModel()
      }
    }()
    
    window?.rootViewController = motionViewController
  }
}
