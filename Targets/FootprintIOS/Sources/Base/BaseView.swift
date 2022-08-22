//
//  BaseView.swift
//  Footprint-iOS
//
//  Created by 송영모 on 2022/08/22.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

protocol BaseViewProtocol {
    func setupProperty()
    func setupDelegate()
    func setupHierarchy()
    func setupLayout()
    func setupBind()
}

class BaseView: UIView, BaseViewProtocol {
    var disposeBag = DisposeBag()
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupProperty()
        setupDelegate()
        setupHierarchy()
        setupLayout()
        setupBind()
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    func setupProperty() { }
    
    func setupDelegate() { }
    
    func setupHierarchy() { }
    
    func setupLayout() { }
    
    func setupBind() { }
}
