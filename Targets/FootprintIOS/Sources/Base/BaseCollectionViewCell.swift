//
//  BaseCVC.swift
//  Footprint-iOS
//
//  Created by 송영모 on 2022/08/22.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import UIKit
import RxSwift

class BaseCollectionViewCell: UICollectionViewCell, BaseViewProtocol {
    var disposeBag = DisposeBag()
    
    // MARK: - Initializer
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupProperty()
        setupHierarchy()
        setupLayout()
        setupBind()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        disposeBag = DisposeBag()
    }
    
    // MARK: - Setup Methods
    
    func setupProperty() { }
    
    func setupDelegate() { }
    
    func setupHierarchy() { }
    
    func setupLayout() { }
    
    func setupBind() { }
}
