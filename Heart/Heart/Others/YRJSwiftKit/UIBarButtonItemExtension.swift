//
//  UIBarButtonItemExtension.swift
//  YRJSwiftKit
//
//  Created by YURENJIE on 2018/4/9.
//  Copyright © 2018年 yurenjie. All rights reserved.
//

import UIKit

// MARK: - Methods
public extension UIBarButtonItem {
    
    /// SwifterSwift: Add Target to UIBarButtonItem
    ///
    /// - Parameters:
    ///   - target: target.
    ///   - action: selector to run when button is tapped.
    public func addTargetForAction(_ target: AnyObject, action: Selector) {
        self.target = target
        self.action = action
    }
    
}
