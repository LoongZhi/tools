//
//  LZMacro.swift
//  WhatsGod
//
//  Created by imac on 9/21/19.
//  Copyright © 2019 L. All rights reserved.
//

import Foundation


//语言本地化
func LanguageStrins(string:String) ->String{
    return NSLocalizedString(string, comment: "")
}

//定义屏幕宽高
let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height

let isPhone = Bool(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone)

//判断是否是iPad
let isPad = Bool(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad)

//判断是否是iPhone X
let isPhoneX = Bool(SCREEN_WIDTH >= 375.0 && SCREEN_HEIGHT >= 812.0 && isPhone)

//导航条的高度
let lzNavigationHeight = CGFloat(isPhoneX ? 88 : 64)

//状态栏高度
let lzkStatusBarHeight = CGFloat(isPhoneX ? 44 : 20)

//tabbar高度
let lzkTabBarHeight = CGFloat(isPhoneX ? (49 + 34) : 49)

//顶部安全区域远离高度
let lzkTopSafeHeight = CGFloat(isPhoneX ? 44 : 0)

//底部安全区域远离高度
let lzBottomSafeHeight = CGFloat(isPhoneX ? 34 : 0)
