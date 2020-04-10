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
  
  @IBOutlet weak var whirligigImageView: UIImageView!
  
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
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    viewModel?
      .gyroDataProvider
      .asObservable()
      .subscribeNext(weak: self, { (obj) -> (GyroData) -> Void in { gyroData in
          obj.rotate(with: gyroData)
        }
      })
      .disposed(by: rx.disposeBag)
  }
  
  private func rotate(with gyroData: GyroData) {
    let rotation = CGFloat(atan2(gyroData.x, gyroData.y) - .pi)
    whirligigImageView?.transform = CGAffineTransform(rotationAngle: rotation)
  }
}
