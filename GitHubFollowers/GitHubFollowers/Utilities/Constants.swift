//
//  Constants.swift
//  GitHubFollowers
//
//  Created by Jose Alberto Ruíz-Carrillo González on 05/03/2020.
//  Copyright © 2020 JARCG. All rights reserved.
//

import UIKit

//MARK: - Icons -
enum SFSymbols {
    static let location     = "mappin.and.ellipse"
    static let repos        = "folder"
    static let gists        = "text.alignleft"
    static let followers    = "heart"
    static let following    = "person.2"
}

//MARK: - Images -
enum Images {
    static let ghLogo               = UIImage(named: "gh-logo")
    static let avatarPlaceholder    = UIImage(named: "avatar-placeholder")
    static let emptyStateLogo       = UIImage(named: "empty-state-logo")
}

//MARK: - Screen Sizes -
enum ScreenSize {
    static let width        = UIScreen.main.bounds.size.width
    static let heigth       = UIScreen.main.bounds.size.height
    static let maxLength    = max(ScreenSize.width, ScreenSize.heigth)
    static let minLength    = min(ScreenSize.width, ScreenSize.heigth)
}

enum DeviceTypes {
    static let idiom                    = UIDevice.current.userInterfaceIdiom
    static let nativeScale              = UIScreen.main.nativeScale
    static let scale                    = UIScreen.main.scale

    static let isiPhoneSE               = idiom == .phone && ScreenSize.maxLength == 568.0
    static let isiPhone8Standard        = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale == scale
    static let isiPhone8Zoomed          = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale > scale
    static let isiPhone8PlusStandard    = idiom == .phone && ScreenSize.maxLength == 736.0
    static let isiPhone8PlusZoomed      = idiom == .phone && ScreenSize.maxLength == 736.0 && nativeScale < scale
    static let isiPhoneX                = idiom == .phone && ScreenSize.maxLength == 812.0
    static let isiPhoneXsMaxAndXr       = idiom == .phone && ScreenSize.maxLength == 896.0
    static let isiPad                   = idiom == .pad && ScreenSize.maxLength >= 1024.0

    static func isiPhoneXAspectRatio() -> Bool {
        return isiPhoneX || isiPhoneXsMaxAndXr
    }
}
