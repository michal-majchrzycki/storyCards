//
//  UIFont+SwiftIconFont.swift
//  SwiftIconFont
//
//  Created by Sedat Ciftci on 18/03/16.
//  Copyright © 2016 Sedat Gokbek Ciftci. All rights reserved.
//

import UIKit

public struct SwiftIcon {
    let font: Fonts
    let code: String
    let color: UIColor
    let imageSize: CGSize
    let fontSize: CGFloat
}

public enum Fonts: String {
    case gameIcon = "game-icons"
    case rpgAwesome = "rpg-awesome"
    
    var fontName: String {
        switch self {
        case .gameIcon:
            return "game-icons"
        case .rpgAwesome:
            return "rpg-awesome"
        }
    }
}

func replace(withText string: NSString) -> NSString {
    if string.lowercased.range(of: "-") != nil {
        return string.replacingOccurrences(of: "-", with: "_") as NSString
    }
    return string
}

func getAttributedString(_ text: NSString, ofSize size: CGFloat) -> NSMutableAttributedString {
    let attributedString = NSMutableAttributedString(string: text as String)
    
    for substring in ((text as String).split{$0 == " "}.map(String.init)) {
        var splitArr = ["", ""]
        splitArr = substring.split{$0 == ":"}.map(String.init)
        if splitArr.count < 2 {
            continue
        }
        
        
        let substringRange = text.range(of: substring)
        
        let fontPrefix: String  = splitArr[0].lowercased()
        var fontCode: String = splitArr[1]
        
        if fontCode.lowercased().range(of: "_") != nil {
            fontCode = (fontCode as NSString).replacingOccurrences(of: "_", with: "-")
        }
        
        var fontType: Fonts = Fonts.gameIcon
        var fontArr: [String: String] = ["": ""]
        
        if fontPrefix == "gi" {
            fontType = Fonts.gameIcon
            fontArr = gameiconArr
        }
        
        if let _ = fontArr[fontCode] {
            attributedString.replaceCharacters(in: substringRange, with: String.getIcon(from: fontType, code: fontCode)!)
            let newRange = NSRange(location: substringRange.location, length: 1)
            attributedString.addAttribute(NSAttributedStringKey.font, value: UIFont.icon(from: fontType, ofSize: size), range: newRange)
        }
    }
    
    return attributedString
}

func getAttributedStringForRuntimeReplace(_ text: NSString, ofSize size: CGFloat) -> NSMutableAttributedString {
    let attributedString = NSMutableAttributedString(string: text as String)
    
    do {
        let input = text as String
        let regex = try NSRegularExpression(pattern: "icon:\\((\\w+):(\\w+)\\)", options: NSRegularExpression.Options.caseInsensitive)
        let matches = regex.matches(in: input, options: [], range: NSRange(location: 0, length: input.utf16.count))
        
        if let match = matches.first {
            var fontPrefix = ""
            var fontCode = ""
            let iconLibraryNameRange = match.range(at: 1)
            let iconNameRange = match.range(at: 2)
            
            if let swiftRange = iconLibraryNameRange.range(for: text as String) {
                fontPrefix = String(input[swiftRange])
            }
            
            
            if let swiftRange = iconNameRange.range(for: text as String) {
                fontCode = String(input[swiftRange])
            }
            
            if fontPrefix.utf16.count > 0 && fontCode.utf16.count > 0 {
                
                var fontType: Fonts = Fonts.gameIcon
                var fontArr: [String: String] = ["": ""]
                
                if fontPrefix == "gi" {
                    fontType = Fonts.gameIcon
                    fontArr = gameiconArr
                } else if fontPrefix == "ra" {
                    fontType = Fonts.rpgAwesome
                    fontArr = rpgAwesomeArr
                }
                
                if let _ = fontArr[fontCode] {
                    attributedString.replaceCharacters(in: match.range, with: String.getIcon(from: fontType, code: fontCode)!)
                    let newRange = NSRange(location: match.range.location, length: 1)
                    attributedString.addAttribute(NSAttributedStringKey.font, value: UIFont.icon(from: fontType, ofSize: size), range: newRange)
                }
                
            }
        }
        
    } catch {
        // regex was bad!
    }
    
    return attributedString
}

func GetIconIndexWithSelectedIcon(_ icon: String) -> String {
    let text = icon as NSString
    var iconIndex: String = ""
 
    for substring in ((text as String).split{$0 == " "}.map(String.init)) {
        var splitArr = ["", ""]
        splitArr = substring.split{$0 == ":"}.map(String.init)
        if splitArr.count == 1{
            continue
        }
        
        var fontCode: String = splitArr[1]
        
        if fontCode.lowercased().range(of: "_") != nil {
            fontCode = (fontCode as NSString!).replacingOccurrences(of: "_", with: "-")
        }
        iconIndex = fontCode
    }
    
    return iconIndex
}

func GetFontTypeWithSelectedIcon(_ icon: String) -> Fonts {
    let text = icon as NSString
    var fontType: Fonts = Fonts.gameIcon
    
    for substring in ((text as String).split{$0 == " "}.map(String.init)) {
        var splitArr = ["", ""]
        splitArr = substring.split{$0 == ":"}.map(String.init)
        
        if splitArr.count == 1{
            continue
        }
        
        let fontPrefix: String  = splitArr[0].lowercased()
        var fontCode: String = splitArr[1]
        
        if fontCode.lowercased().range(of: "_") != nil {
            fontCode = (fontCode as NSString).replacingOccurrences(of: "_", with: "-")
        }
        
        if fontPrefix == "gi" {
            fontType = Fonts.gameIcon
        } else if fontPrefix == "ra" {
            fontType = Fonts.rpgAwesome
        }
    }
    
    return fontType
}
