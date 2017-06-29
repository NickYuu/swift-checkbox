//
//  TestController.swift
//  checkbox_test
//
//  Created by TsungHan on 2017/6/29.
//  Copyright © 2017年 TsungHan. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class TestController: UIViewController {
    
    @IBOutlet weak var add: UIButton!
    @IBOutlet weak var rru03: UIButton!
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    fileprivate let bag = DisposeBag()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        add.rx.tap
            .subscribe(onNext: { [unowned self] in
                let v = self.slider.value + 0.5
                self.slider.setValue(v, animated: true)
                print(self.slider.value)
            })
            .addDisposableTo(bag)
        
        rru03.rx.tap
            .subscribe(onNext: { [unowned self] in
                let v = self.slider.value - 0.5
                self.slider.setValue(v, animated: true)
            })
            .addDisposableTo(bag)
        
        
        slider.rx.value
            .subscribe(onNext: { [unowned self] in
                let v = roundf($0 * 2.0) * 0.5
                self.slider.setValue(v, animated: true)
                self.label.text = String(v)
            }).addDisposableTo(bag)
        
        
    }

}
