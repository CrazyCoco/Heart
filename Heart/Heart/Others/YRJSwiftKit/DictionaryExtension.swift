//
//  DictionaryExtension.swift
//  YRJSwiftKit
//
//  Created by YURENJIE on 2018/4/9.
//  Copyright © 2018年 yurenjie. All rights reserved.
//

import UIKit

// MARK: - Methods
public extension Dictionary {
    
    
    /// SwifterSwift: 检查字典中是否存在键
    ///
    ///        let dict: [String : Any] = ["testKey": "testValue", "testArrayKey": [1, 2, 3, 4, 5]]
    ///        dict.has(key: "testKey") -> true
    ///        dict.has(key: "anotherKey") -> false
    ///
    /// - Parameter key: key to search for
    /// - Returns: true if key exists in dictionary.
    public func has(key: Key) -> Bool {
        return index(forKey: key) != nil
    }
    
    /// SwifterSwift: 删除字典的所有键
    ///
    ///        var dict : [String : String] = ["key1" : "value1", "key2" : "value2", "key3" : "value3"]
    ///        dict.removeAll(keys: ["key1", "key2"])
    ///        dict.keys.contains("key3") -> true
    ///        dict.keys.contains("key1") -> false
    ///        dict.keys.contains("key2") -> false
    ///
    /// - Parameter keys: keys to be removed
    public mutating func removeAll(keys: [Key]) {
        keys.forEach({ removeValue(forKey: $0)})
    }
    
    /// SwifterSwift: Count dictionary entries that where function returns true.
    ///
    /// - Parameter where: condition to evaluate each tuple entry against.
    /// - Returns: Count of entries that matches the where clousure.
    public func count(where condition: @escaping ((key: Key, value: Value)) throws -> Bool) rethrows -> Int {
        var count: Int = 0
        try self.forEach {
            if try condition($0) {
                count += 1
            }
        }
        return count
    }
    
}

// MARK: - Operators
public extension Dictionary {
    
    /// SwifterSwift: 合并两个字典的键/值
    ///
    ///        let dict : [String : String] = ["key1" : "value1"]
    ///        let dict2 : [String : String] = ["key2" : "value2"]
    ///        let result = dict + dict2
    ///        result["key1"] -> "value1"
    ///        result["key2"] -> "value2"
    ///
    /// - Parameters:
    ///   - lhs: dictionary
    ///   - rhs: dictionary
    /// - Returns: An dictionary with keys and values from both.
    public static func + (lhs: [Key: Value], rhs: [Key: Value]) -> [Key: Value] {
        var result = lhs
        rhs.forEach { result[$0] = $1 }
        return result
    }
    
    /// SwifterSwift: 将第二个字典的键和值附加到第一个字典中
    ///
    ///        var dict : [String : String] = ["key1" : "value1"]
    ///        let dict2 : [String : String] = ["key2" : "value2"]
    ///        dict += dict2
    ///        dict["key1"] -> "value1"
    ///        dict["key2"] -> "value2"
    ///
    /// - Parameters:
    ///   - lhs: dictionary
    ///   - rhs: dictionary
    public static func += (lhs: inout [Key: Value], rhs: [Key: Value]) {
        rhs.forEach { lhs[$0] = $1}
    }
    
    /// SwifterSwift: 从字典中删除数组中包含的内容
    ///
    ///        let dict : [String : String] = ["key1" : "value1", "key2" : "value2", "key3" : "value3"]
    ///        let result = dict-["key1", "key2"]
    ///        result.keys.contains("key3") -> true
    ///        result.keys.contains("key1") -> false
    ///        result.keys.contains("key2") -> false
    ///
    /// - Parameters:
    ///   - lhs: dictionary
    ///   - rhs: array with the keys to be removed.
    /// - Returns: a new dictionary with keys removed.
    public static func - (lhs: [Key: Value], keys: [Key]) -> [Key: Value] {
        var result = lhs
        result.removeAll(keys: keys)
        return result
    }
    
    /// SwifterSwift: 从字典中删除数组中包含的内容
    ///
    ///        var dict : [String : String] = ["key1" : "value1", "key2" : "value2", "key3" : "value3"]
    ///        dict-=["key1", "key2"]
    ///        dict.keys.contains("key3") -> true
    ///        dict.keys.contains("key1") -> false
    ///        dict.keys.contains("key2") -> false
    ///
    /// - Parameters:
    ///   - lhs: dictionary
    ///   - rhs: array with the keys to be removed.
    public static func -= (lhs: inout [Key: Value], keys: [Key]) {
        lhs.removeAll(keys: keys)
    }

}
