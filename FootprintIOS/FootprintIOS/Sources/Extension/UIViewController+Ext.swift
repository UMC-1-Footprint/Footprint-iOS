//
//  UIViewController+Ext.swift
//  Footprint-iOS
//
//  Created by 송영모 on 2022/11/06.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import UIKit

extension UIViewController {
    func navigationWrap() -> UINavigationController {
        return UINavigationController(rootViewController: self)
    }
    
    func hideKeyboard() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(endEditing)))
    }
    
    @objc func endEditing() {
        view.endEditing(true)
    }
}
