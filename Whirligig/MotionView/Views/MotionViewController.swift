//
//  ViewController.swift
//  whirligig
//
//  Created by Kristaps Grinbergs on 10/04/2020.
//  Copyright © 2020 fassko. All rights reserved.
//

import UIKit

import NSObject_Rx
import RxAnimated
import RxCocoa
import RxSwift
import RxSwiftExt

class MotionViewController: UIViewController, Storyboarded {
  
  @IBOutlet private weak var yawValueLabel: UILabel!
  @IBOutlet private weak var pitchValueLabel: UILabel!
  @IBOutlet private weak var rollValueLabel: UILabel!
  
  @IBOutlet private weak var whirligigImageView: WhirligigImageView!
  
  var viewModel: MotionViewModelProtocol?

  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    guard viewModel?.isAccelerometerAvailable ?? false else {
      return
    }
    
    startRotation()
    setupValueFields()
  }
  
  private func startRotation() {
    viewModel?
      .motionUpdates()
      .asObservable()
      .subscribe(weak: self, onNext: { obj -> (MotionData) -> Void in { motionData in
          obj.whirligigImageView.rotate(with: motionData)
        }
      }, onError: { obj -> (Error) -> Void in { error in
          obj.showError(with: error)
        }
      })
      .disposed(by: rx.disposeBag)
  }
  
  private func setupValueFields() {
    let gyroUpdates = viewModel?
      .motionUpdates()
      .asObservable()
      .ignoreErrors()
    
    gyroUpdates?
      .map { motionData in
        motionData.yaw.rounded()
      }
      .distinctUntilChanged()
      .bind(animated: yawValueLabel.rx.animated.fade(duration: 0.15).text)
      .disposed(by: rx.disposeBag)

     gyroUpdates?
      .map { motionData in
        motionData.pitch.rounded()
      }
      .distinctUntilChanged()
      .bind(to: pitchValueLabel.rx.animated.fade(duration: 0.15).text)
      .disposed(by: rx.disposeBag)

    gyroUpdates?
      .map { motionData in
        motionData.roll.rounded()
      }
      .distinctUntilChanged()
      .bind(to: rollValueLabel.rx.animated.fade(duration: 0.15).text)
      .disposed(by: rx.disposeBag)
  }
}
