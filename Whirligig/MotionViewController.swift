//
//  ViewController.swift
//  whirligig
//
//  Created by Kristaps Grinbergs on 10/04/2020.
//  Copyright © 2020 fassko. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwiftExt
import NSObject_Rx

class MotionViewController: UIViewController, Storyboarded {

  var viewModel: MotionViewModelProtocol?
  
  @IBOutlet weak var xValueLabel: UILabel!
  @IBOutlet weak var yValueLabel: UILabel!
  @IBOutlet weak var zValueLabel: UILabel!
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    viewModel?.startGyroUpdates()
    
    viewModel?.xValue.asObservable()
      .bind(to: self.xValueLabel.rx.text)
      .disposed(by: rx.disposeBag)
    
    viewModel?.yValue.asObservable()
      .bind(to: self.yValueLabel.rx.text)
      .disposed(by: rx.disposeBag)
    
    viewModel?.zValue.asObservable()
      .bind(to: self.zValueLabel.rx.text)
      .disposed(by: rx.disposeBag)
  }
}
