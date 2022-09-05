//
//  Menu.swift
//  Footprint-iOS
//
//  Created by 송영모 on 2022/08/31.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import UIKit
import Then

enum MenuType {
    case myInfo
    case notification
    case logout
    case signout
    case notice
    
    var image: UIImage {
        switch self {
        case .myInfo:
            return FootprintIOSAsset.Images.iconUser.image
        case .notification:
            return FootprintIOSAsset.Images.iconNotification.image
        case .logout:
            return FootprintIOSAsset.Images.iconLogout.image
        case .signout:
            return FootprintIOSAsset.Images.iconSignout.image
        case .notice:
            return FootprintIOSAsset.Images.iconSpeaker.image
        }
    }
    
    var title: String {
        switch self {
        case .myInfo:
            return "내 정보"
        case .notification:
            return "알림"
        case .logout:
            return "로그아웃"
        case .signout:
            return "회원 탈퇴"
        case .notice:
            return "공지사항"
        }
    }
    
    var trailingType: TrailingType {
        switch self {
        case .myInfo:
            return .button
        case .notification:
            return .toggle
        case .logout:
            return .none
        case .signout:
            return .none
        case .notice:
            return .none
        }
    }
    
    enum TrailingType {
        case none
        case button
        case toggle
    }
}

class Menu: BaseView {
    
    // MARK: - UI Components
    
    let leadingImageView: UIImageView = .init()
    let titleLabel: UILabel = .init()
    let toggle: UISwitch = .init()
    let button: UIButton = .init()
    
    // MARK: - Properties
    
    let type: MenuType
    
    // MARK: - Initializer
    
    init(type: MenuType) {
        self.type = type
        
        super.init(frame: .zero)
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        backgroundColor = .white
        
        leadingImageView.image = type.image
        
        titleLabel.text = type.title
        
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.tintColor = .black
        
        switch type.trailingType {
        case .none:
            toggle.isHidden = true
            button.isHidden = true
        case .button:
            toggle.isHidden = true
        case .toggle:
            button.isHidden = true
        }
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubviews([leadingImageView, titleLabel, toggle, button])
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        leadingImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(24)
            $0.width.height.equalTo(24)
            $0.centerY.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(leadingImageView.snp.trailing).offset(15)
            $0.centerY.equalTo(leadingImageView)
        }
        
        toggle.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(24)
            $0.centerY.equalTo(leadingImageView)
            $0.width.equalTo(50)
            $0.height.equalTo(28)
        }
        
        button.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(24)
            $0.centerY.equalTo(leadingImageView)
            $0.width.equalTo(28)
            $0.height.equalTo(28)
        }
    }
}
