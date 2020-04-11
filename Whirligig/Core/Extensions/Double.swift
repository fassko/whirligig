//
//  Double.swift
//  Whirligig
//
//  Created by Kristaps Grinbergs on 11/04/2020.
//  Copyright © 2020 fassko. All rights reserved.
//

import Foundation

extension Double {
  func rounded(toPlaces places: Int = 5) -> String {
    String(format: "%.\(places)f", self)
  }
}
