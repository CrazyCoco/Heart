//
//  StringExtension.swift
//  YRJSwiftKit
//
//  Created by YURENJIE on 2018/4/9.
//  Copyright © 2018年 yurenjie. All rights reserved.
//

import UIKit


// MARK: - Properties
public extension String {
    
    /// SwifterSwift: 字符串从base64解码
    ///
    ///        "SGVsbG8gV29ybGQh".base64Decoded = Optional("Hello World!")
    ///
    public var base64Decoded: String? {
        guard let decodedData = Data(base64Encoded: self) else { return nil }
        return String(data: decodedData, encoding: .utf8)
    }
    
    /// SwifterSwift: 用base64编码的字符串
    ///
    ///        "Hello World!".base64Encoded -> Optional("SGVsbG8gV29ybGQh")
    ///
    public var base64Encoded: String? {
        let plainData = data(using: .utf8)
        return plainData?.base64EncodedString()
    }
    
    /// SwifterSwift: 字符串的字符数组
    ///
    public var charactersArray: [Character] {
        return Array(self)
    }
    
    /// SwifterSwift: CamelCase of string.
    ///
    ///        "sOme vAriable naMe".camelCased -> "someVariableName"
    ///
    public var camelCased: String {
        let source = lowercased()
        let first = source[..<source.index(after: source.startIndex)]
        if source.contains(" ") {
            let connected = source.capitalized.replacingOccurrences(of: " ", with: "")
            let camel = connected.replacingOccurrences(of: "\n", with: "")
            let rest = String(camel.dropFirst())
            return first + rest
        }
        let rest = String(source.dropFirst())
        return first + rest
    }
    
    
    /// SwifterSwift: 检查字符串是否包含一个或多个表情符号
    ///
    ///        "Hello 😀".containEmoji -> true
    ///
    public var containEmoji: Bool {
        for scalar in unicodeScalars {
            switch scalar.value {
            case 0x3030, 0x00AE, 0x00A9, // Special Characters
            0x1D000...0x1F77F, // Emoticons
            0x2100...0x27BF, // Misc symbols and Dingbats
            0xFE00...0xFE0F, // Variation Selectors
            0x1F900...0x1F9FF: // Supplemental Symbols and Pictographs
                return true
            default:
                continue
            }
        }
        return false
    }
    
    
    /// SwifterSwift: 字符串的第一个字符
    ///
    ///        "Hello".firstCharacterAsString -> Optional("H")
    ///        "".firstCharacterAsString -> nil
    ///
    public var firstCharacterAsString: String? {
        guard let first = self.first else { return nil }
        return String(first)
    }
    
    /// SwifterSwift: 检查字符串是否包含一个或多个字母
    ///
    ///        "123abc".hasLetters -> true
    ///        "123".hasLetters -> false
    ///
    public var hasLetters: Bool {
        return rangeOfCharacter(from: .letters, options: .numeric, range: nil) != nil
    }
    
    /// SwifterSwift: 检查字符串是否包含一个或多个数字
    ///
    ///        "abcd".hasNumbers -> false
    ///        "123abc".hasNumbers -> true
    ///
    public var hasNumbers: Bool {
        return rangeOfCharacter(from: .decimalDigits, options: .literal, range: nil) != nil
    }
    
    /// SwifterSwift: 检查字符串是否只包含字母
    ///
    ///        "abc".isAlphabetic -> true
    ///        "123abc".isAlphabetic -> false
    ///
    public var isAlphabetic: Bool {
        let hasLetters = rangeOfCharacter(from: .letters, options: .numeric, range: nil) != nil
        let hasNumbers = rangeOfCharacter(from: .decimalDigits, options: .literal, range: nil) != nil
        return hasLetters && !hasNumbers
    }
    
    /// SwifterSwift: 检查字符串是否包含至少一个字母和一个数字
    ///
    ///        // useful for passwords
    ///        "123abc".isAlphaNumeric -> true
    ///        "abc".isAlphaNumeric -> false
    ///
    public var isAlphaNumeric: Bool {
        let hasLetters = rangeOfCharacter(from: .letters, options: .numeric, range: nil) != nil
        let hasNumbers = rangeOfCharacter(from: .decimalDigits, options: .literal, range: nil) != nil
        let comps = components(separatedBy: .alphanumerics)
        return comps.joined(separator: "").count == 0 && hasLetters && hasNumbers
    }
    
    
    /// SwifterSwift: 检查字符串是否是有效的电子邮件格式
    ///
    ///        "john@doe.com".isEmail -> true
    ///
    public var isEmail: Bool {
        return matches(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}")
    }
    
    /// SwifterSwift: 检查字符串是否是有效的URL
    ///
    ///        "https://google.com".isValidUrl -> true
    ///
    public var isValidUrl: Bool {
        return URL(string: self) != nil
    }
    
    /// SwifterSwift: 检查字符串是否是有效的方案URL
    ///
    ///        "https://google.com".isValidSchemedUrl -> true
    ///        "google.com".isValidSchemedUrl -> false
    ///
    public var isValidSchemedUrl: Bool {
        guard let url = URL(string: self) else { return false }
        return url.scheme != nil
    }
    
    /// SwifterSwift: 检查字符串是否是有效的https URL
    ///
    ///        "https://google.com".isValidHttpsUrl -> true
    ///
    public var isValidHttpsUrl: Bool {
        guard let url = URL(string: self) else { return false }
        return url.scheme == "https"
    }
    
    /// SwifterSwift: 检查字符串是否是有效的http URL
    ///
    ///        "http://google.com".isValidHttpUrl -> true
    ///
    public var isValidHttpUrl: Bool {
        guard let url = URL(string: self) else { return false }
        return url.scheme == "http"
    }
    
    /// SwifterSwift: 检查字符串是否是有效的文件URL
    ///
    ///        "file://Documents/file.txt".isValidFileUrl -> true
    ///
    public var isValidFileUrl: Bool {
        return URL(string: self)?.isFileURL ?? false
    }
    
    
    /// SwifterSwift: 验证字符串是否与正则表达式匹配
    ///
    /// - Parameter pattern: Pattern to verify.
    /// - Returns: true if string matches the pattern.
    public func matches(pattern: String) -> Bool {
        return range(of: pattern,
                     options: String.CompareOptions.regularExpression,
                     range: nil, locale: nil) != nil
    }
    
    
    /// SwifterSwift: 检查字符串是否是有效的Swift码
    ///
    /// Note:
    /// In North America, "." is the decimal separator,
    /// while in many parts of Europe "," is used,
    ///
    ///        "123".isNumeric -> true
    ///     "1.3".isNumeric -> true (en_US)
    ///     "1,3".isNumeric -> true (fr_FR)
    ///        "abc".isNumeric -> false
    ///
    public var isNumeric: Bool {
        let scanner = Scanner(string: self)
        scanner.locale = NSLocale.current
        return scanner.scanDecimal(nil) && scanner.isAtEnd
    }
    
    /// SwifterSwift: 检查字符串是否只包含数字
    ///
    ///     "123".isDigits -> true
    ///     "1.3".isDigits -> false
    ///     "abc".isDigits -> false
    ///
    public var isDigits: Bool {
        return CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: self))
    }
    
    /// SwifterSwift: 字符串的最后一个字符
    ///
    ///        "Hello".lastCharacterAsString -> Optional("o")
    ///        "".lastCharacterAsString -> nil
    ///
    public var lastCharacterAsString: String? {
        guard let last = self.last else { return nil }
        return String(last)
    }
    
    /// SwifterSwift: Latinized string.
    ///
    ///        "Hèllö Wórld!".latinized -> "Hello World!"
    ///
    public var latinized: String {
        return folding(options: .diacriticInsensitive, locale: Locale.current)
    }
    
    /// SwifterSwift: Bool value from string (if applicable).
    ///
    ///        "1".bool -> true
    ///        "False".bool -> false
    ///        "Hello".bool = nil
    ///
    public var bool: Bool? {
        let selfLowercased = trimmed.lowercased()
        if selfLowercased == "true" || selfLowercased == "1" {
            return true
        } else if selfLowercased == "false" || selfLowercased == "0" {
            return false
        }
        return nil
    }
    
    /// SwifterSwift: String with no spaces or new lines in beginning and end.
    ///
    ///        "   hello  \n".trimmed -> "hello"
    ///
    public var trimmed: String {
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    
    /// SwifterSwift: Date object from "yyyy-MM-dd" formatted string.
    ///
    ///        "2007-06-29".date -> Optional(Date)
    ///
    public var date: Date? {
        let selfLowercased = trimmed.lowercased()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: selfLowercased)
    }
    
    /// SwifterSwift: Date object from "yyyy-MM-dd HH:mm:ss" formatted string.
    ///
    ///        "2007-06-29 14:23:09".dateTime -> Optional(Date)
    ///
    public var dateTime: Date? {
        let selfLowercased = trimmed.lowercased()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.date(from: selfLowercased)
    }
    
    /// SwifterSwift: Integer value from string (if applicable).
    ///
    ///        "101".int -> 101
    ///
    public var int: Int? {
        return Int(self)
    }
    
    /// SwifterSwift: URL from string (if applicable).
    ///
    ///        "https://google.com".url -> URL(string: "https://google.com")
    ///        "not url".url -> nil
    ///
    public var url: URL? {
        return URL(string: self)
    }
    
    
    /// SwifterSwift: Readable string from a URL string.
    ///
    ///        "it's%20easy%20to%20decode%20strings".urlDecoded -> "it's easy to decode strings"
    ///
    public var urlDecoded: String {
        return removingPercentEncoding ?? self
    }
    
    /// SwifterSwift: URL escaped string.
    ///
    ///        "it's easy to encode strings".urlEncoded -> "it's%20easy%20to%20encode%20strings"
    ///
    public var urlEncoded: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    /// SwifterSwift: String without spaces and new lines.
    ///
    ///        "   \n Swifter   \n  Swift  ".withoutSpacesAndNewLines -> "SwifterSwift"
    ///
    public var withoutSpacesAndNewLines: String {
        return replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "\n", with: "")
    }
    
    /// SwifterSwift: 检查给定的字符串是否只包含空格
    public var isWhitespace: Bool {
        return self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
}

// MARK: - NSString extensions
public extension String {
    
    /// SwifterSwift: NSString from a string.
    public var nsString: NSString {
        return NSString(string: self)
    }
    
    /// SwifterSwift: NSString lastPathComponent.
    public var lastPathComponent: String {
        return (self as NSString).lastPathComponent
    }
    
    /// SwifterSwift: NSString pathExtension.
    public var pathExtension: String {
        return (self as NSString).pathExtension
    }
    
    /// SwifterSwift: NSString deletingLastPathComponent.
    public var deletingLastPathComponent: String {
        return (self as NSString).deletingLastPathComponent
    }
    
    /// SwifterSwift: NSString deletingPathExtension.
    public var deletingPathExtension: String {
        return (self as NSString).deletingPathExtension
    }
    
    /// SwifterSwift: NSString pathComponents.
    public var pathComponents: [String] {
        return (self as NSString).pathComponents
    }
    
    /// SwifterSwift: NSString appendingPathComponent(str: String)
    ///
    /// - Parameter str: the path component to append to the receiver.
    /// - Returns: a new string made by appending aString to the receiver, preceded if necessary by a path separator.
    public func appendingPathComponent(_ str: String) -> String {
        return (self as NSString).appendingPathComponent(str)
    }
    
    /// SwifterSwift: NSString appendingPathExtension(str: String)
    ///
    /// - Parameter str: The extension to append to the receiver.
    /// - Returns: a new string made by appending to the receiver an extension separator followed by ext (if applicable).
    public func appendingPathExtension(_ str: String) -> String? {
        return (self as NSString).appendingPathExtension(str)
    }
}

