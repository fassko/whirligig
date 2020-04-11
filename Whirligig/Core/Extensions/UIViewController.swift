//
//  UIViewController.swift
//  Whirligig
//
//  Created by Kristaps Grinbergs on 11/04/2020.
//  Copyright © 2020 fassko. All rights reserved.
//

import UIKit

extension UIViewController {
  func showError(with error: Error) {
    let alert = UIAlertController(title: "Whirligig", message: error.localizedDescription, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
    present(alert, animated: true)
  }
}
