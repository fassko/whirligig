//
//  CommandLine.swift
//  Whirligig
//
//  Created by Kristaps Grinbergs on 11/04/2020.
//  Copyright © 2020 fassko. All rights reserved.
//

import Foundation

extension CommandLine {
  static var mockGyroData: Bool {
    CommandLine.arguments.contains("-mockGyroData")
  }
}
