//
//  LZPercentProgressView.swift
//  WhatsGod
//
//  Created by imac on 11/8/19.
//  Copyright © 2019 L. All rights reserved.
//

import UIKit

class LZPercentProgressView: UIView {

    
    var progressView:OProgressView = {
        let progress:OProgressView = OProgressView.init(frame: CGRect.init(x: SCREEN_WIDTH / 2 - 60, y: SCREEN_HEIGHT / 2 - 60, width: 120, height: 120))
        return progress
    }()
    public var progressValue = 0
    public var totalNumber = 0
    public var avaiNumber = 0
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.aoutLayotView()
        UIApplication.shared.keyWindow?.addSubview(self)
    }
     private static let sharedManager: LZPercentProgressView = {
             let shared = LZPercentProgressView(frame: UIApplication.shared.keyWindow!.bounds)
            return shared
        }()
    class func shared() -> LZPercentProgressView {
        return sharedManager
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    lazy var diskLabel:UILabel = {
        let label = UILabel.init()
        label.textColor = COLOR_4990ED
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 30)
        return label
    }()
    lazy var diskTitleLabel:UILabel = {
           let label = UILabel.init()
           label.textColor = COLOR_4990ED
           label.textAlignment = .center
           label.font = UIFont.systemFont(ofSize: 15)
           return label
       }()
    
    func aoutLayotView(){
        
        self.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
        self.diskLabel.text = "0%"
        self.diskTitleLabel.text = "\(self.avaiNumber) / \(self.totalNumber)"
        
        self.progressView.addSubview(self.diskLabel)
        self.progressView.addSubview(self.diskTitleLabel)
        self.addSubview(self.progressView)
        self.diskLabel.snp.makeConstraints { (make) in
           
            make.top.equalToSuperview().offset(35)
            make.height.equalTo(35)
            make.left.equalTo(10)
            make.right.equalTo(-10)
        }
        
        self.diskTitleLabel.snp.makeConstraints { (make) in
            make.height.equalTo(20)
            make.top.equalTo(self.diskLabel.snp_bottom).offset(0)
            make.left.equalTo(10)
            make.right.equalTo(-10)
        }
    }
    
   public func startProgress(avaiNumber:CGFloat,totalNumber:CGFloat){
    
        self.isHidden = false
        DispatchQueue.main.async {
            self.progressView.setProgress(CGFloat(avaiNumber / totalNumber * 100), animated: true)
            self.diskLabel.text = "\(String(format: "%.0f",avaiNumber / totalNumber * 100)) %"
            self.diskTitleLabel.text = String(format: "%.0f / %.0f",avaiNumber,totalNumber)
        }
        
    }
    
   public func stopProgress(){
        self.removeView()
    }
   private func removeView(){
        self.isHidden = true
    }
}
