//
//  UIStackView+.swift
//  Footprint-iOS
//
//  Created by 김영인 on 2022/10/25.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import UIKit

extension UIStackView {
     func addArrangedSubviews(_ views: UIView...) {
         for view in views {
             self.addArrangedSubview(view)
         }
     }
}
