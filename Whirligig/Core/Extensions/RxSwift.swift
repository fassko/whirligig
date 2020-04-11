//
//  RxSwift.swift
//  Whirligig
//
//  Created by Kristaps Grinbergs on 11/04/2020.
//  Copyright © 2020 fassko. All rights reserved.
//

import Foundation

import RxSwift

extension ObservableType {
  func flatMap<A: AnyObject, O: ObservableType>(
    weak obj: A,
    selector: @escaping (A, Self.Element) throws -> O) -> Observable<O.Element> {
    flatMap { [weak obj] value -> Observable<O.Element> in
      try obj.map { try selector($0, value).asObservable() } ?? .empty()
    }
  }
}
