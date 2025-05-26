//
//  View+Helper.swift
//  Github-Demo
//
//  Created by Pushpsen Airekar on 25/05/25.
//

import SwiftUI

public extension View {
    
    func roundedBorder(
        cornerRadius: CGFloat,
        color: Color,
        lineWidth: CGFloat = 1
    ) -> some View {
        self
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(color, lineWidth: lineWidth)
            )
    }
}
