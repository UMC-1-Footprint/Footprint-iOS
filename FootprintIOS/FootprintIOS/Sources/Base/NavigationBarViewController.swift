//
//  NavigationBarViewController.swift
//  Footprint-iOS
//
//  Created by 송영모 on 2022/08/22.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import UIKit

class NavigationBar: UIView {
    var backButton = UIButton()
    var title = UILabel()
    var subTitle = UILabel()
    var rightButton = UIButton()
}

protocol BaseNavigationBarViewControllerProtocol: AnyObject {
    var statusBar: UIView { get }
    var navigationBar: NavigationBar { get }
    var contentView: UIView { get }
    
    func setupNavigationBar()
    func setNavigationBarBackgroundColor(_ color: UIColor?)
    func setNavigationBarHidden(_ hidden: Bool)
    func setNavigationBarBackButtonHidden(_ hidden: Bool)
    func setNavigationBarBackButtonTitleColor(_ color: UIColor?)
    func setNavigationBarTitleText(_ text: String?)
    func setNavigationBarTitleFont(_ font: UIFont?)
    func setNavigationBarTitleTextColor(_ color: UIColor?)
    func setNavigationBarSubTitleText(_ text: String?)
    func setNavigationBarSubTitleFont(_ font: UIFont?)
    func setNavigationBarSubTitleTextColor(_ color: UIColor?)
    func setNavigationBarBackButtonImage(_ image: UIImage?)
    func setNavigationRightButtonTitle(_ text: String?)
    func setNavigationBarRightButtonTitleColor(_ color: UIColor?)
    func setNavigationBarRightButtonTitleFont(_ font: UIFont?)
}

class NavigationBarViewController: BaseViewController, BaseNavigationBarViewControllerProtocol {
    
    // MARK: - UI Components
    
    var statusBar = UIView()
    var navigationBar = NavigationBar()
    var contentView = UIView()
    
    // MARK: - Properties
    
    // MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    // MARK: - Setup Methods
    
    override func setupProperty() {
        super.setupProperty()

        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubviews([statusBar, navigationBar, contentView])
      
        navigationBar.addSubviews([navigationBar.title, navigationBar.backButton, navigationBar.subTitle, navigationBar.rightButton])
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        statusBar.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(statusBar.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(60)
        }
        
        navigationBar.backButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(24)
        }
        
        navigationBar.title.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        navigationBar.subTitle.snp.makeConstraints {
            $0.leading.equalTo(navigationBar.title.snp.trailing).offset(12)
            $0.centerY.equalToSuperview()
        }
        
        navigationBar.rightButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.top.equalTo(statusBar.snp.bottom).offset(60)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
        }
    }
    
    override func setupBind() {
        navigationBar.backButton.rx.tap
            .bind { [weak self] _ in
                self?.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    func setupNavigationBar() { }
    
    func setNavigationBarBackgroundColor(_ color: UIColor?) {
        statusBar.backgroundColor = color
        navigationBar.backgroundColor = color
    }
    
    func setNavigationBarHidden(_ hidden: Bool) {
        navigationBar.isHidden = hidden
        
        contentView.snp.updateConstraints {
            $0.top.equalTo(statusBar.snp.bottom)
        }
    }
    
    func setNavigationBarBackButtonHidden(_ hidden: Bool) {
        navigationBar.backButton.isHidden = hidden
        
        if hidden {
            navigationBar.title.snp.updateConstraints {
                $0.leading.equalToSuperview().inset(24)
            }
        }
    }
    
    func setNavigationBarBackButtonTitleColor(_ color: UIColor?) {
        navigationBar.backButton.setTitleColor(color, for: .normal)
    }
    
    func setNavigationBarBackButtonImage(_ image: UIImage?) {
        navigationBar.backButton.setImage(image, for: .normal)
    }
    
    func setNavigationBarTitleText(_ text: String?) {
        navigationBar.title.text = text
    }
    
    func setNavigationBarTitleFont(_ font: UIFont?) {
        navigationBar.title.font = font
    }
    
    func setNavigationBarTitleTextColor(_ color: UIColor?) {
        navigationBar.title.textColor = color
    }
    
    func setNavigationBarSubTitleText(_ text: String?) {
        navigationBar.subTitle.text = text
    }
    
    func setNavigationBarSubTitleFont(_ font: UIFont?) {
        navigationBar.subTitle.font = font
    }
    
    func setNavigationBarSubTitleTextColor(_ color: UIColor?) {
        navigationBar.subTitle.textColor = color
    }
    
    func setNavigationRightButtonTitle(_ text: String?) {
        navigationBar.rightButton.setTitle(text, for: .normal)
    }
    
    func setNavigationBarRightButtonTitleColor(_ color: UIColor?) {
        navigationBar.rightButton.setTitleColor(color, for: .normal)
    }
    
    func setNavigationBarRightButtonTitleFont(_ font: UIFont?) {
        navigationBar.rightButton.titleLabel?.font = font
    }
}
