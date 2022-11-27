//
//  FootprintWriteViewController.swift
//  Footprint-iOS
//
//  Created by 송영모 on 2022/11/06.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import UIKit
import PhotosUI
import RxSwift
import ReactorKit
import RxDataSources

class FootprintWriteViewController: NavigationBarViewController, View {

    // MARK: - Constants
    
    fileprivate struct Text {
        static let cancleButton: String = "취소"
        static let titleLabel: String = "발자국 남기기"
        static let saveButton: String = "저장"
        static let textViewPlaceholder: String = "본문에 #을 이용해 태그를 입력해보세요! (최대 5개)"
        static let addPictureButton: String = "사진 추가하기"
    }
    
    fileprivate struct Font {
        static let cancleButton: UIFont = .systemFont(ofSize: 16, weight: .medium)
        static let titleLabel: UIFont = .systemFont(ofSize: 16, weight: .bold)
        static let saveButton: UIFont = .systemFont(ofSize: 12, weight: .bold)
        static let textView: UIFont = .systemFont(ofSize: 14, weight: .regular)
        static let addPictureButton: UIFont = .systemFont(ofSize: 14, weight: .medium)
    }
    
    fileprivate struct Color {
        static let cancleButton: UIColor = FootprintIOSAsset.Colors.blackM.color
        static let titleLabel: UIColor = FootprintIOSAsset.Colors.blackD.color
        static let saveButton: UIColor = FootprintIOSAsset.Colors.blueM.color
        static let saveButtonTitle: UIColor = .white
        static let divider: UIColor = FootprintIOSAsset.Colors.whiteD.color
        static let textView: UIColor = FootprintIOSAsset.Colors.blackD.color
        static let textViewPlaceholder: UIColor = FootprintIOSAsset.Colors.whiteD.color
        static let addPictureButton: UIColor = FootprintIOSAsset.Colors.blackM.color
    }
    
    // MARK: - Properties
    
    typealias Reactor = FootprintWriteReactor
    
    typealias DataSource = RxCollectionViewSectionedReloadDataSource<ImageSectionModel>
    
    private lazy var dataSource = DataSource { _, collectionView, indexPath, item -> UICollectionViewCell in
        switch item {
        case let .image(reactor):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ImageCollectionViewCell.self), for: indexPath) as? ImageCollectionViewCell else { return .init() }
            cell.reactor = reactor
            return cell
        }
    }
    
    // MARK: - UI Components
    
    let cancleButton: UIButton = .init(type: .system)
    let titleLabel: UILabel = .init()
    let saveButton: UIButton = .init()
    let divider: UIView = .init()
    let textView: UITextView = .init()
    let divider2: UIView = .init()
    let addPictureView: AddPictureButtonView = .init()
    lazy var accessoryView: AddPictureButtonView = .init(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: 44))
    let flowLayout: UICollectionViewFlowLayout = .init()
    lazy var collectionView: UICollectionView = .init(frame: .zero, collectionViewLayout: flowLayout)
    
    
    // MARK: - Initializer
    
    init(reactor: Reactor) {
        super.init(nibName: nil, bundle: nil)
        self.reactor = reactor
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        setNavigationBarHidden(true)
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        cancleButton.setTitle(Text.cancleButton, for: .normal)
        cancleButton.titleLabel?.font = Font.cancleButton
        cancleButton.tintColor = Color.cancleButton
        
        titleLabel.text = Text.titleLabel
        titleLabel.font = Font.titleLabel
        titleLabel.textColor = Color.titleLabel
        
        saveButton.setTitle(Text.saveButton, for: .normal)
        saveButton.titleLabel?.font = Font.saveButton
        saveButton.titleLabel?.textColor = Color.saveButtonTitle
        saveButton.backgroundColor = Color.saveButton
        saveButton.cornerRound(radius: 10)
        
        divider.backgroundColor = Color.divider
        
        textView.font = Font.textView
        textView.text = Text.textViewPlaceholder
        textView.textColor = Color.textViewPlaceholder
        textView.inputAccessoryView = accessoryView
        
        flowLayout.scrollDirection = .horizontal
        
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: ImageCollectionViewCell.self))
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isPagingEnabled = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification , object:nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification , object:nil)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubviews([
            cancleButton,
            titleLabel,
            saveButton,
            divider,
            textView,
            addPictureView,
            collectionView
        ])
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        cancleButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.centerY.equalTo(titleLabel)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.centerX.equalToSuperview()
        }
        
        saveButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalTo(titleLabel)
            $0.width.equalTo(43)
            $0.height.equalTo(24)
        }
        
        divider.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(divider.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(0)
        }
        
        textView.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview()
        }
        
        addPictureView.snp.makeConstraints {
            $0.height.equalTo(44)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(33)
        }
    }
    
    // MARK: - Bind Method
    
    func bind(reactor: Reactor) {
        textView.rx.didBeginEditing
            .withUnretained(self)
            .bind { this, _ in
                if this.textView.text == Text.textViewPlaceholder {
                    this.textView.text = nil
                    this.textView.textColor = Color.textView
                }
            }
            .disposed(by: disposeBag)
        
        textView.rx.text
            .compactMap{$0}
            .debounce(.milliseconds(200), scheduler:MainScheduler.instance)
            .map { .text($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        textView.rx.didEndEditing
            .withUnretained(self)
            .bind { this, _ in
                if this.textView.text.isEmpty {
                    this.textView.text = Text.textViewPlaceholder
                    this.textView.textColor = Color.textViewPlaceholder
                }
            }
            .disposed(by: disposeBag)
        
        addPictureView.addPictureButton.rx.tap
            .withUnretained(self)
            .bind { this, _ in
                this.goToPickerScreen()
            }
            .disposed(by: disposeBag)
        
        accessoryView.addPictureButton.rx.tap
            .withUnretained(self)
            .bind { this, _ in
                this.goToPickerScreen()
            }
            .disposed(by: disposeBag)
        
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
        reactor.state.map(\.sections)
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        reactor.state.map(\.sections)
            .bind { [weak self] sections in
                self?.showCollectionView(sections: sections)
            }
            .disposed(by: disposeBag)
    }
    
    private func showCollectionView(sections: [ImageSectionModel]) {
        if !sections.isEmpty {
            self.collectionView.snp.remakeConstraints {
                $0.top.equalTo(self.divider.snp.bottom).offset(16)
                $0.leading.trailing.equalToSuperview().inset(24)
                $0.height.equalTo(self.collectionView.frame.width)
            }
        }
        collectionView.performBatchUpdates(nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        textView.inputAccessoryView?.isHidden = false
        addPictureView.isHidden = true
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        textView.inputAccessoryView?.isHidden = true
        addPictureView.isHidden = false
    }
}

extension FootprintWriteViewController {
    private func goToPickerScreen() {
        var configure = PHPickerConfiguration()
        configure.selectionLimit = 10
        configure.filter = .images
        let picker = PHPickerViewController(configuration: configure)
        picker.delegate = self
        present(picker, animated: true)
        view.endEditing(false)
    }
}

extension FootprintWriteViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        reactor?.action.onNext(.resolve)
        for result in results {
            let itemProvider = result.itemProvider
            if itemProvider.canLoadObject(ofClass: UIImage.self) {
                itemProvider.loadObject(ofClass: UIImage.self) { [weak self] (image, error) in
                    DispatchQueue.main.async {
                        if let image = image as? UIImage {
                            self?.reactor?.action.onNext(.resolving(image))
                            if result.hashValue == results.last?.hashValue {
                                self?.reactor?.action.onNext(.resolved)
                            }
                        }
                    }
                }
            }
        }
    }
}

extension FootprintWriteViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let height = collectionView.bounds.height
        
        return .init(width: width, height: height)
    }
}

extension Reactive where Base: FootprintWriteViewController {
    var show: Binder<[ImageSectionModel]> {
        return Binder(self.base) { (viewController, sections) in
            if !sections.isEmpty {
                viewController.collectionView.snp.remakeConstraints {
                    $0.top.equalTo(viewController.divider.snp.bottom).offset(16)
                    $0.leading.trailing.equalToSuperview().inset(24)
                    $0.height.equalTo(viewController.collectionView.frame.width)
                }
            }
            viewController.collectionView.performBatchUpdates(nil)
        }
    }
}
