//
//  Rx+Ext.swift
//  Footprint-iOS
//
//  Created by 송영모 on 2022/09/05.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

public extension Reactive where Base: UIViewController {
    var viewDidLoad: ControlEvent<Void> {
        let source = methodInvoked(#selector(Base.viewDidLoad)).map { _ in }
        return ControlEvent(events: source)
    }

    var viewWillAppear: ControlEvent<Bool> {
        let source = methodInvoked(#selector(Base.viewWillAppear)).map { $0.first as? Bool ?? false }
        return ControlEvent(events: source)
    }
}


public extension Reactive where Base: UIScrollView {
    var pageSet: ControlEvent<Int> {
        let event = base.rx.didScroll
            .withLatestFrom(base.rx.contentOffset)
            .map { offset -> Int in
                let screenWidth = UIScreen.main.bounds.width
                let page = round(offset.x/screenWidth)
                return Int(page)
            }
        return ControlEvent(events: event)
    }
}
