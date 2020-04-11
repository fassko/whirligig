//
//  CommandLine.swift
//  Whirligig
//
//  Created by Kristaps Grinbergs on 11/04/2020.
//  Copyright © 2020 fassko. All rights reserved.
//

import Foundation

extension CommandLine {
  static var mockMotionData: Bool {
    CommandLine.arguments.contains("-mockMotionData")
  }
  
  static var unitTests: Bool {
    CommandLine.arguments.contains("-unitTests")
  }
}
