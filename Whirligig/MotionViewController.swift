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

class MotionViewController: UIViewController, Storyboarded {
  
  @IBOutlet weak var xValueLabel: UILabel!
  @IBOutlet weak var yValueLabel: UILabel!
  @IBOutlet weak var zValueLabel: UILabel!
  
  @IBOutlet weak var whirligigImageView: UIImageView!
  
  var viewModel: MotionViewModelProtocol?
  
  private var gyroDataProvider: Observable<GyroData>?
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    gyroDataProvider = viewModel?.gyroUpdates()
    
    gyroDataProvider?
      .asObservable()
      .flatMap(weak: self) { _, gyroData -> Observable<String> in
        Observable.just(gyroData.x.rounded())
      }
      .bind(to: xValueLabel.rx.text)
      .disposed(by: rx.disposeBag)
    
    gyroDataProvider?
      .asObservable()
      .flatMap(weak: self) { _, gyroData in
        Observable.just(gyroData.y.rounded())
      }
      .bind(to: yValueLabel.rx.text)
      .disposed(by: rx.disposeBag)
    
    gyroDataProvider?
      .asObservable()
      .flatMap(weak: self) { _, gyroData in
        Observable.just(gyroData.z.rounded())
      }
      .bind(to: zValueLabel.rx.text)
      .disposed(by: rx.disposeBag)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    gyroDataProvider?
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
