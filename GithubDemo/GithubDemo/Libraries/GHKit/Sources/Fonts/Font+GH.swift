//
//  Font+GH.swift
//  GHKit
//
//  Created by Pushpsen Airekar on 23/05/25.
//

import Foundation
import SwiftUI

public extension SwiftUI.Font {
    
    static func headerFont(weight: Font.Weight = .bold) -> Font {
        .system(size: 36, weight: weight)
    }
    
    static func primaryFont(weight: Font.Weight = .bold) -> Font {
        .system(size: 18, weight: weight)
    }
    
    static func secondaryFont(weight: Font.Weight = .regular) -> Font {
        .system(size: 16, weight: weight)
    }
    
    static func tertiaryFont(weight: Font.Weight = .regular) -> Font {
        .system(size: 14, weight: weight)
    }
}
