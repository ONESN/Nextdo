//
//  Color+Extensions.swift
//  Nextdo
//
//  Created by 君の名は on 9/18/24.
//

import SwiftUI

extension Color {
    // 将 Color 转换为十六进制字符串
    func toHex() -> String? {
        let uic = UIColor(self)
        guard let components = uic.cgColor.components, components.count >= 3 else {
            return nil
        }
        
        let r = Float(components[0])
        let g = Float(components[1])
        let b = Float(components[2])
        
        // 将 RGB 值转换为两位十六进制格式
        return String(format: "%02X%02X%02X", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255))
    }
    
    // 从十六进制字符串创建 Color
    init(hex: String) {
        var cleanedHex = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // 移除 '#' 前缀
        if cleanedHex.hasPrefix("#") {
            cleanedHex.remove(at: cleanedHex.startIndex)
        }
        
        // 如果十六进制字符串长度不够，填充为标准的6位RGB
        if cleanedHex.count == 6 {
            var rgb: UInt64 = 0
            Scanner(string: cleanedHex).scanHexInt64(&rgb)
            
            let red = Double((rgb & 0xFF0000) >> 16) / 255.0
            let green = Double((rgb & 0x00FF00) >> 8) / 255.0
            let blue = Double(rgb & 0x0000FF) / 255.0
            
            self.init(red: red, green: green, blue: blue)
        } else {
            // 默认黑色，如果格式不对
            self.init(red: 0, green: 0, blue: 0)
        }
    }
}
