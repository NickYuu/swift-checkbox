//
//  ViewController.swift
//  checkbox_test
//
//  Created by TsungHan on 2017/6/12.
//  Copyright © 2017年 TsungHan. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ViewController: UIViewController {
    
    fileprivate let bag = DisposeBag()

    @IBOutlet weak var checkBtn: AIFlatSwitch!
    
    @IBOutlet weak var tableView: UITableView!
    
    var count = 5
    
    var checkData: [Variable<Bool>] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rxEvent()
        for _ in 0 ..< count {
            checkData.append(Variable(false))
        }
    }

    @IBAction func checkBtnClick(_ sender: AIFlatSwitch) {
        
    }

    @IBAction func btnClick(_ sender: UIButton) {
        self.checkData.enumerated().forEach {
            if $0.element.value {
                let indexPath = IndexPath(row: $0.offset, section: 0)
                let cell = self.tableView.cellForRow(at: indexPath) as! TableViewCell
                cell.label.text = "腳底按摩"
            }
        }
    }
    
    func rxEvent() {
        checkBtn.rx.controlEvent(UIControlEvents.touchUpInside)
            .subscribe(onNext: { [unowned self] in
                self.checkData.forEach {
                    $0.value = self.checkBtn.isSelected
                }
            }).addDisposableTo(bag)
        
        NotificationCenter.default.rx
            .notification(MPOSNoti.update.name)
            .subscribe(onNext: {[unowned self] _ in
                for i in 0 ..< self.checkData.count {
                    let indexPath = IndexPath(row: i, section: 0)
                    if let cell = self.tableView.cellForRow(at: indexPath) as? TableViewCell {
                        if self.checkData[i].value != cell.checkbox.isSelected {
                            self.checkData[i].value = cell.checkbox.isSelected
                        }
                    }
                }
            }).addDisposableTo(bag)
    }
    
    
}

extension ViewController: UITableViewDelegate {}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return checkData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        let check = checkData[indexPath.row]
        
        check.asObservable()
            .subscribe(onNext: {
                cell.checkbox.setSelected($0, animated: true)
            })
            .addDisposableTo(bag)
        
        return cell
    }
}

