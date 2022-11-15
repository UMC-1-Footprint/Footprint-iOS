//
//  AddPictureButtonView.swift
//  Footprint-iOS
//
//  Created by 송영모 on 2022/11/13.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import UIKit

class AddPictureButtonView: BaseView {
    
    // MARK: - UI Components
    
    let divider: UIView = .init()
    let cameraImageView: UIImageView = .init()
    let addPictureButton: UIButton = .init(type: .system)
    
    // MARK: - Setup Methods
    
    override func setupProperty() {
        super.setupProperty()
        
        divider.backgroundColor = FootprintIOSAsset.Colors.whiteD.color
        
        cameraImageView.image = FootprintIOSAsset.Images.iconCamera.image
        
        addPictureButton.setTitle("사진 추가하기", for: .normal)
        addPictureButton.tintColor = FootprintIOSAsset.Colors.blackM.color
        addPictureButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubviews([
            divider,
            cameraImageView,
            addPictureButton
        ])
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        divider.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        cameraImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(18)
            $0.width.equalTo(20)
            $0.height.equalTo(18)
        }
        
        addPictureButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(cameraImageView.snp.trailing).offset(10)
        }
    }
}
