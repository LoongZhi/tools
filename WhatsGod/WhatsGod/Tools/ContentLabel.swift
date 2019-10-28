//
//  ContentLabel.swift
//  WhatsGod
//
//  Created by imac on 10/28/19.
//  Copyright © 2019 L. All rights reserved.
//

import UIKit

class ContentLabel: UILabel {

    /// 动画时间
    private let duration: TimeInterval = 0.5
    
    /// 开始数字
    private var fromValue: Double = 0
    
    /// 结束数字
    private var toValue: Double = 0
    
    ///最加字符
    private var strValue:String = ""
    
    /// 计时器
    private var timer: CADisplayLink?
    
    private var progress: TimeInterval = 0
    
    private var lastUpdateTime: TimeInterval = 0
    private var totalTime: TimeInterval = 0
    
    private var currentValue: Double {
        if progress >= totalTime { return toValue }
        return fromValue + Double(progress / totalTime) * (toValue - fromValue)
    }
    
    /// 开始计时
    private func start() {
        timer = CADisplayLink(target: self, selector: #selector(updateValue(timer:)))
        timer?.add(to: .main, forMode: RunLoop.Mode.default)
        timer?.add(to: .main, forMode: RunLoop.Mode.tracking)
    }
    
    /// 停止计时
    private func stop() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc fileprivate func updateValue(timer: Timer) {
        let now = Date.timeIntervalSinceReferenceDate
        progress += now - lastUpdateTime
        lastUpdateTime = now
        
        if progress >= totalTime {
            stop()
            progress = totalTime
        }
        
        setTextValue(value: currentValue,str: strValue)
    }
    
    private func setTextValue(value: Double,str:String) {
        text = String(format: "%.1f%@", value,str)
    }
}

extension ContentLabel {
   
    func animate(fromValue from: Double = 0, toValue to: Double,str:String, duration t: TimeInterval? = nil) {
        self.fromValue = from
        self.toValue = to
        self.strValue = str
        stop()
        
        if (t == 0.0) {
            setTextValue(value: to,str:str )
            return
        }
        
        progress = 0.0
        totalTime = t ?? self.duration
        lastUpdateTime = Date.timeIntervalSinceReferenceDate
        
        start()
    }
}
