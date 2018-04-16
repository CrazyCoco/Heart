//
//  DataExtension.swift
//  YRJSwiftKit
//
//  Created by YURENJIE on 2018/4/9.
//  Copyright © 2018年 yurenjie. All rights reserved.
//

import UIKit

// MARK: - Properties
public extension Data {
    
    /// SwifterSwift: Return data as an array of bytes.
    public var bytes: [UInt8] {
        return [UInt8](self)
    }
    
}

// MARK: - Methods
public extension Data {
    
    /// SwifterSwift: String by encoding Data using the given encoding (if applicable).
    ///
    /// - Parameter encoding: encoding.
    /// - Returns: String by encoding Data using the given encoding (if applicable).
    public func string(encoding: String.Encoding) -> String? {
        return String(data: self, encoding: encoding)
    }
    
}
