//
//  LZCustomLanguage.swift
//  WhatsGod
//
//  Created by mj on 1/7/20.
//  Copyright © 2020 L. All rights reserved.
//

import UIKit

class LZCustomLanguage: NSObject {
    //单例
    static let share = LZCustomLanguage()
    // 国家语言代码
    var lan = ""
    
    func showText(key: String) -> String {
        // 查找对应国家语言代码的路径
        guard let path = Bundle.main.path(forResource: lan, ofType: "lproj") else { return "" }
        // 通过路径在CustomLacation语言文件中查找对应key的字符串
        guard let bundle = Bundle(path: path)?.localizedString(forKey: key, value: nil, table: "Localizable") else { return "" }
        return bundle
    }
}
