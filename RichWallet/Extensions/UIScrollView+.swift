//
//  UIScrollView+.swift
//  RichWallet
//
//  Created by Emir Alkal on 28.01.2023.
//

import UIKit

extension UIScrollView {
    func updateContentView() {
        contentSize.height = subviews.sorted(by: { $0.frame.maxY < $1.frame.maxY }).last?.frame.maxY ?? contentSize.height
    }
}
