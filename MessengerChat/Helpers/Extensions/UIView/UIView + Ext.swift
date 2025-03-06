//
//  UIView + Ext.swift
//  MessengerChat
//
//  Created by sunflow on 28/2/25.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
}
