//
//  MPOSNoti.swift
//  checkbox_test
//
//  Created by TsungHan on 2017/6/12.
//  Copyright © 2017年 TsungHan. All rights reserved.
//

import Foundation

enum MPOSNoti: Notifiable {
    case upload
    case infoBtn
    case slTeacher
    case update
    
    var name: Notification.Name {
        switch self {
        case .upload:       // 上船訂單
            return Notification.Name(rawValue: "upload")
        case .infoBtn:      // 點擊TableView裡面的詳細按鈕
            return Notification.Name(rawValue: "infoBtn")
        case .slTeacher:    // 詳細訂單的老師修改
            return Notification.Name(rawValue: "slTeacher")
        case .update:       // update SL TableView
            return Notification.Name(rawValue: "update")
        }
    }
}

protocol Notifiable {
    var name: Notification.Name { get }
    func observe<T: AnyObject>(by observer: T, withSelector selector: Selector, object: Any?)
    func post(object: Any? ,userInfo: [AnyHashable: Any]?)
    static func remove<T: AnyObject>(observer: T)
}

extension Notifiable {
    func observe<T: AnyObject>(by observer: T, withSelector selector: Selector, object: Any? = nil) {
        NotificationCenter.default.addObserver(observer, selector: selector, name: self.name, object: object)
    }
    
    func post(object: Any? = nil, userInfo: [AnyHashable: Any]? = nil) {
        NotificationCenter.default.post(name: self.name, object: object, userInfo: userInfo)
    }
    
    static func remove<T: AnyObject>(observer: T) {
        NotificationCenter.default.removeObserver(observer)
    }
}
