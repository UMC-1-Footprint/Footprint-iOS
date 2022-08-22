//
//  BaseViewController.swift
//  Footprint-iOS
//
//  Created by 송영모 on 2022/08/22.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import UIKit
import RxSwift

class BaseViewController: UIViewController, BaseViewProtocol {
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupProperty()
        setupDelegate()
        setupHierarchy()
        setupLayout()
        setupBind()
    }

    func setupProperty() { }
    
    func setupDelegate() { }
    
    func setupHierarchy() { }
    
    func setupLayout() { }
    
    func setupBind() { }
}
