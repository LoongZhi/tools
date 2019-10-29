//
//  ExtensionView.swift
//  WhatsGod
//
//  Created by imac on 10/3/19.
//  Copyright © 2019 L. All rights reserved.
//

import Foundation


extension UIView {
    
     
    //画线
    private func drawBorder(rect:CGRect,color:UIColor){
        let line = UIBezierPath(rect: rect)
        let lineShape = CAShapeLayer()
        lineShape.path = line.cgPath
        lineShape.lineWidth = rect.size.height
        lineShape.fillColor = color.cgColor
        self.layer.addSublayer(lineShape)
    }
    
    //设置右边框
    public func rightBorder(width:CGFloat,borderColor:UIColor){
        self.layoutIfNeeded()
        let rect = CGRect(x: 0, y: self.frame.size.width - width, width: width, height: self.frame.size.height)
        drawBorder(rect: rect, color: borderColor)
    }
    //设置左边框
    public func leftBorder(width:CGFloat,borderColor:UIColor){
        self.layoutIfNeeded()
        let rect = CGRect(x: 0, y: 0, width: width, height: self.frame.size.height)
        drawBorder(rect: rect, color: borderColor)
    }
    
    //设置上边框
    public func topBorder(width:CGFloat,borderColor:UIColor){
        self.layoutIfNeeded()
        let rect = CGRect(x: 0, y: 0, width: self.frame.size.width, height: width)
        drawBorder(rect: rect, color: borderColor)
    }
    
    
    //设置底边框
    public func buttomBorder(width:CGFloat,borderColor:UIColor){
        self.layoutIfNeeded()
        let rect = CGRect(x: 0, y: self.frame.size.height-width, width: self.frame.size.width, height: width)
        drawBorder(rect: rect, color: borderColor)
    }
    
    //设置部分圆角
     public   func setRoundCorners(corners:UIRectCorner,with radii:CGFloat){
            self.layoutIfNeeded()
            let bezierpath:UIBezierPath = UIBezierPath.init(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radii, height: radii))
            let shape:CAShapeLayer = CAShapeLayer.init()
            shape.path = bezierpath.cgPath
            
            self.layer.mask = shape
        }
 
    
}

