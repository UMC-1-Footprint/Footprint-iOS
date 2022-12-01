//
//  BottomSheetViewController.swift
//  Footprint-iOSTests
//
//  Created by 김영인 on 2022/11/28.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import UIKit

import SnapKit
import RxGesture
import Then

enum BottomSheetType {
    case fix
    case drag
}

class BottomSheetViewController: BaseViewController {
    
    // MARK: - Properties
    
    var type: BottomSheetType
    
    // MARK: - UI Components
    
    private let backgroundView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    private let bottomSheetView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 20
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        $0.layer.masksToBounds = true
    }
    
    // MARK: - Initializer
    
    init(type: BottomSheetType) {
        self.type = type
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        showBottomSheet()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        hideBottomSheet()
    }
    
    // MARK: - Setup Methods
    
    override func setupProperty() {
        super.setupProperty()
        
        view.backgroundColor = .clear
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubviews([backgroundView, bottomSheetView])
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        backgroundView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(-1000)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    override func setupBind() {
        super.setupBind()
        
        bottomSheetView.rx.panGesture()
            .withUnretained(self)
            .bind { this, gesture in
                let transition = gesture.translation(in: this.view)
                
                guard
                    transition.y > 0,
                    this.type == .drag else { return }
                
                switch gesture.state {
                case .changed:
                    this.bottomSheetView.transform = CGAffineTransform(translationX: 0, y: transition.y)
                case .ended:
                    if transition.y < (this.bottomSheetView.bounds.height / 3) {
                        this.bottomSheetView.transform = .identity
                    } else {
                        this.dismiss(animated: true)
                    }
                default:
                    break
                }
            }
            .disposed(by: disposeBag)
        
        backgroundView.rx.tapGesture()
            .when(.recognized)
            .withUnretained(self)
            .bind { this, _ in
                this.dismiss(animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    // MARK: - Methods
    
    func addContentView(view: UIView) {
        bottomSheetView.addSubview(view)
        
        bottomSheetView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(view.snp.height)
        }
        
        view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func showBottomSheet() {
        UIView.animate(withDuration: 0.2, delay: 0.0, options: [.curveEaseInOut]) {
            self.backgroundView.backgroundColor = .clear.withAlphaComponent(0.25)
        }
    }
    
    private func hideBottomSheet() {
        UIView.animate(withDuration: 0.2, delay: 0.0, options: [.curveEaseInOut]) {
            self.backgroundView.alpha = 0
        }
    }
}
