//
//  SwiftIconFont+String.swift
//  SwiftIconFont
//
//  Created by Sedat Gökbek ÇİFTÇİ on 13.10.2017.
//  Copyright © 2017 Sedat Gökbek ÇİFTÇİ. All rights reserved.
//

import Foundation

public extension String {
    public static func getIcon(from font: Fonts, code: String) -> String? {
        switch font {
        case .gameIcon:
            return fontGameIcon(code)
        case .rpgAwesome:
            return fontRpgAwesome(code)
        }
    }
    
    public static func fontGameIcon(_ code: String) -> String? {
        if let icon = gameiconArr[code] {
            return icon
        }
        return nil
    }

    public static func fontRpgAwesome(_ code: String) -> String? {
        if let icon = rpgAwesomeArr[code] {
            return icon
        }
        return nil
    }
}
