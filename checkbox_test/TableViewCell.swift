//
//  TableViewCell.swift
//  checkbox_test
//
//  Created by TsungHan on 2017/6/12.
//  Copyright © 2017年 TsungHan. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TableViewCell: UITableViewCell {
    
    let bag = DisposeBag()

    @IBOutlet weak var checkbox: AIFlatSwitch!
    @IBOutlet weak var label: UILabel!
    
    
    
    
    @IBAction func checkboxClick(_ sender: AIFlatSwitch) {
        MPOSNoti.update.post()
    }

}
