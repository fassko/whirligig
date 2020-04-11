//
//  ViewController.swift
//  whirligig
//
//  Created by Kristaps Grinbergs on 10/04/2020.
//  Copyright © 2020 fassko. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa
import RxSwiftExt
import NSObject_Rx
import RxAnimated

class MotionViewController: UIViewController, Storyboarded {
  
  @IBOutlet weak var xValueLabel: UILabel!
  @IBOutlet weak var yValueLabel: UILabel!
  @IBOutlet weak var zValueLabel: UILabel!
  
  @IBOutlet weak var whirligigImageView: UIImageView!
  
  var viewModel: MotionViewModelProtocol?
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    setupValueFields()
    startRotation()
    viewModel?.startGyroUpdates()
  }
  
  private func startRotation() {
    viewModel?.gyroDataProvider
    .subscribeNext(weak: self, { (obj) -> (GyroData) -> Void in { gyroData in
        obj.rotate(with: gyroData)
      }
    })
    .disposed(by: rx.disposeBag)
  }
  
  private func setupValueFields() {

    viewModel?.gyroDataProvider
      .map { gyroData in
        gyroData.x.rounded()
      }
      .distinctUntilChanged()
      .bind(to: xValueLabel.rx.animated.fade(duration: 0.15).text)
      .disposed(by: rx.disposeBag)

    viewModel?.gyroDataProvider
      .map { gyroData in
        gyroData.y.rounded()
      }
      .distinctUntilChanged()
      .bind(to: yValueLabel.rx.animated.fade(duration: 0.15).text)
      .disposed(by: rx.disposeBag)

    viewModel?.gyroDataProvider
      .map { gyroData in
        gyroData.z.rounded()
      }
      .distinctUntilChanged()
      .bind(to: zValueLabel.rx.animated.fade(duration: 0.15).text)
      .disposed(by: rx.disposeBag)
  }
  
  private func rotate(with gyroData: GyroData) {
    let rotation = CGFloat(atan2(gyroData.x, gyroData.y) - .pi)
    whirligigImageView?.transform = CGAffineTransform(rotationAngle: rotation)
  }
}
