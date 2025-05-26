//
//  Image+GH.swift
//  GHKit
//
//  Created by Pushpsen Airekar on 23/05/25.
//

import Foundation
import SwiftUI

// MARK: - Styled backgrounds
public extension Image {
    static let onboardingBackground = Image("onboarding-background", bundle: .module)
    static let logo = Image("logo", bundle: .module)
}


public extension Image {
    static func fromName(_ name: String, bundle: Bundle? = nil) -> Image {
        Image(name, bundle: bundle ?? .module)
    }
}

/// Image source for local or remote image
public enum GHImageSource: Equatable , Sendable {
    case localImage(name: String)
    case remote(url: String)
}

public enum GHImageName: Equatable , Sendable {
    case system(name: String)
    case local(name: String)
}

/// Presentation object for any image icon in the app views
public struct GHImagePresentationObject: Equatable, Sendable {
    public let imageName: GHImageName
    public let imageForgroundColor: Color?
    public let imageBackgroundColor: Color?
    public let imageSize: CGSize?
    
    public init(
        imageName: GHImageName,
        imageForgroundColor: Color? = nil,
        imageBackgroundColor: Color? = nil,
        imageSize: CGSize? = CGSize(width: 24, height: 24)
    ) {
        self.imageName = imageName
        self.imageForgroundColor = imageForgroundColor
        self.imageBackgroundColor = imageBackgroundColor
        self.imageSize = imageSize
    }
}
