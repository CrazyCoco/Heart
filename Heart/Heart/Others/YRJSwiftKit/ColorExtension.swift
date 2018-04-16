//
//  ColorExtension.swift
//  YRJSwiftKit
//
//  Created by YURENJIE on 2018/4/9.
//  Copyright © 2018年 yurenjie. All rights reserved.
//

import UIKit

public typealias Color = UIColor

// MARK: - Properties
public extension Color {
    
    /// SwifterSwift:随机颜色
    public static var randomColor : Color {
        let r = Int(arc4random_uniform(255))
        let g = Int(arc4random_uniform(255))
        let b = Int(arc4random_uniform(255))
        return Color(red: r, green: g, blue: b)!
    }
    
    /// facebook的颜色
    public static let facebookColor = Color(red: 59, green: 89, blue: 152)!
    
    /// SwifterSwift: hex #FFCDD2
    public static let red100                = Color(hex: 0xFFCDD2)!
    
}


// MARK: - Methods
public extension Color {
    
    /// SwifterSwift: 混合两种颜色
    ///
    /// - Parameters:
    ///   - color1: 第一种颜色混合
    ///   - intensity1: 第一种颜色的强度(默认为0.5)
    ///   - color2: 第二种颜色混合
    ///   - intensity2: 第二色强度(默认为0.5)
    /// - Returns: 通过混合第一和seond颜色创建的颜色
    public static func blend(_ color1: Color, intensity1: CGFloat = 0.5, with color2: Color, intensity2: CGFloat = 0.5) -> Color {
        
        let total = intensity1 + intensity2
        let level1 = intensity1/total
        let level2 = intensity2/total
        
        guard level1 > 0 else { return color2 }
        guard level2 > 0 else { return color1 }
        
        let components1: [CGFloat] = {
            let c = color1.cgColor.components!
            return c.count == 4 ? c : [c[0], c[0], c[0], c[1]]
        }()
        let components2: [CGFloat] = {
            let c = color2.cgColor.components!
            return c.count == 4 ? c : [c[0], c[0], c[0], c[1]]
        }()
        
        let r1 = components1[0]
        let r2 = components2[0]
        
        let g1 = components1[1]
        let g2 = components2[1]
        
        let b1 = components1[2]
        let b2 = components2[2]
        
        let a1 = color1.cgColor.alpha
        let a2 = color2.cgColor.alpha
        
        let r = level1*r1 + level2*r2
        let g = level1*g1 + level2*g2
        let b = level1*b1 + level2*b2
        let a = level1*a1 + level2*a2
        
        return Color(red: r, green: g, blue: b, alpha: a)
    }
    
    
    /// SwifterSwift: 点亮一种颜色
    ///
    ///     let color = Color(red: r, green: g, blue: b, alpha: a)
    ///     let lighterColor: Color = color.lighten(by: 0.2)
    ///
    /// - Parameter percentage: 用来照亮颜色的百分比
    /// - Returns: 颜色变亮
    public func lighten(by percentage: CGFloat = 0.2) -> Color {
        
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        return Color(red: min(r + percentage, 1.0),
                     green: min(g + percentage, 1.0),
                     blue: min(b + percentage, 1.0),
                     alpha: a)
    }
    
    /// SwifterSwift: 变黑颜色
    ///
    ///     let color = Color(red: r, green: g, blue: b, alpha: a)
    ///     let darkerColor: Color = color.darken(by: 0.2)
    ///
    /// - Parameter percentage: 使颜色变暗的百分比
    /// - Returns: 颜色变黑
    public func darken(by percentage: CGFloat = 0.2) -> Color {
        
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        return Color(red: max(r - percentage, 0),
                     green: max(g - percentage, 0),
                     blue: max(b - percentage, 0),
                     alpha: a)
    }
    
}

// MARK: - Initializers
public extension Color {
    
    /// SwifterSwift: 用可选的透明度从RGB值创建颜色
    ///
    /// - Parameters:
    ///   - red: red component.
    ///   - green: green component.
    ///   - blue: blue component.
    ///   - transparency: 可选的透明度值(默认值为1)
    public convenience init?(red: Int, green: Int, blue: Int, transparency: CGFloat = 1) {
        guard red >= 0 && red <= 255 else { return nil }
        guard green >= 0 && green <= 255 else { return nil }
        guard blue >= 0 && blue <= 255 else { return nil }
        
        var trans = transparency
        if trans < 0 { trans = 0 }
        if trans > 1 { trans = 1 }
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: trans)
    }
    
    /// SwifterSwift: 用可选透明的十六进制值创建颜色
    ///
    /// - Parameters:
    ///   - hex: hex Int (例子: 0xDECEB5)
    ///   - transparency: 可选透明度值(默认值为1)
    public convenience init?(hex: Int, transparency: CGFloat = 1) {
        var trans = transparency
        if trans < 0 { trans = 0 }
        if trans > 1 { trans = 1 }
        
        let red = (hex >> 16) & 0xff
        let green = (hex >> 8) & 0xff
        let blue = hex & 0xff
        self.init(red: red, green: green, blue: blue, transparency: trans)
    }
    
    
    /// SwifterSwift: 用可选透明的十六进制字符串创建颜色(如果适用)
    ///
    /// - Parameters:
    ///   - hexString: 十六进制字符串(例子:EDE7F6, 0xEDE7F6， #EDE7F6， #0ff, 0xF0F， ..)
    ///   - transparency: 透明度:可选透明度值(默认值为1)
    public convenience init?(hexString: String, transparency: CGFloat = 1) {
        var string = ""
        if hexString.lowercased().hasPrefix("0x") {
            string =  hexString.replacingOccurrences(of: "0x", with: "")
        } else if hexString.hasPrefix("#") {
            string = hexString.replacingOccurrences(of: "#", with: "")
        } else {
            string = hexString
        }
        
        if string.count == 3 { // convert hex to 6 digit format if in short format
            var str = ""
            string.forEach { str.append(String(repeating: String($0), count: 2)) }
            string = str
        }
        
        guard let hexValue = Int(string, radix: 16) else { return nil }
        
        var trans = transparency
        if trans < 0 { trans = 0 }
        if trans > 1 { trans = 1 }
        
        let red = (hexValue >> 16) & 0xff
        let green = (hexValue >> 8) & 0xff
        let blue = hexValue & 0xff
        self.init(red: red, green: green, blue: blue, transparency: trans)
    }
    
    /// SwifterSwift: 从颜色的互补色(如果适用的话)创建颜色
    ///
    /// - Parameter color: 需要颜色的颜色
    public convenience init?(complementaryFor color: Color) {
        let colorSpaceRGB = CGColorSpaceCreateDeviceRGB()
        let convertColorToRGBSpace: ((_ color: Color) -> Color?) = { color -> Color? in
            if color.cgColor.colorSpace!.model == CGColorSpaceModel.monochrome {
                let oldComponents = color.cgColor.components
                let components: [CGFloat] = [ oldComponents![0], oldComponents![0], oldComponents![0], oldComponents![1]]
                let colorRef = CGColor(colorSpace: colorSpaceRGB, components: components)
                let colorOut = Color(cgColor: colorRef!)
                return colorOut
            } else {
                return color
            }
        }
        
        let c = convertColorToRGBSpace(color)
        guard let componentColors = c?.cgColor.components else { return nil }
        
        let r: CGFloat = sqrt(pow(255.0, 2.0) - pow((componentColors[0]*255), 2.0))/255
        let g: CGFloat = sqrt(pow(255.0, 2.0) - pow((componentColors[1]*255), 2.0))/255
        let b: CGFloat = sqrt(pow(255.0, 2.0) - pow((componentColors[2]*255), 2.0))/255
        self.init(red: r, green: g, blue: b, alpha: 1.0)
    }
}

