//
//  MainCoordinator.swift
//  Whirligig
//
//  Created by Kristaps Grinbergs on 10/04/2020.
//  Copyright © 2020 fassko. All rights reserved.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
  
  let window: UIWindow?
  
  init(_ window: UIWindow?) {
    self.window = window
  }
  
  func start() {
    let motionViewController = MotionViewController.instantiate()
    window?.rootViewController = motionViewController
  }
  
}
