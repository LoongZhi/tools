//
//  LZOfficeDetailCell.swift
//  WhatsGod
//
//  Created by imac on 10/23/19.
//  Copyright © 2019 L. All rights reserved.
//

import UIKit

class LZOfficeDetailCell: UICollectionViewCell {
     lazy var selectBtn:UIButton = {
           let btn = UIButton.init()
            btn.backgroundColor = .clear
            btn.layer.borderColor  = COLOR_4990ED.cgColor
           return btn
       }()
        lazy var bottomView:UIView = {
              let view = UIView.init()
              view.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.6)
             return view
          }()
          lazy var iconImage:UIImageView = {
              let image = UIImageView.init()
              image.layer.masksToBounds = true
              image.backgroundColor = .orange
              return image
          }()
          lazy var nameLabel:UILabel = {
              let label = UILabel.init()
              label.font = UIFont.systemFont(ofSize: 13)
              label.textColor = .white
              label.textAlignment = .right
              return label
          }()
       lazy var imageView:UIImageView = {
           let image = UIImageView.init()
           image.layer.masksToBounds = true
           image.contentMode = .scaleAspectFill
           return image
       }()
       
       override init(frame: CGRect) {
           super.init(frame: frame)
           
           loadUI()
       }
       
       private func loadUI() {
           
          
           self.contentView .addSubview(self.imageView)
            self.contentView .addSubview(self.bottomView)
            self.bottomView .addSubview(self.iconImage)
            self.bottomView .addSubview(self.nameLabel)
           self.imageView.snp.makeConstraints { (make) in
              
            make.centerY.centerX.equalTo(self.contentView)
            make.width.height.equalTo(60)
//            make.bottom.equalTo(self.nameLabel).offset(-10)
               
           }
           self.bottomView.snp.makeConstraints { (make) in
               make.left.bottom.right.equalToSuperview()
               make.height.equalTo(25)
           }
           self.iconImage.snp.makeConstraints { (make) in
               make.width.equalTo(30)
               make.height.equalTo(20)
               make.left.equalTo(10)
               make.centerY.equalToSuperview()
           }
           self.nameLabel.snp.makeConstraints { (make) in
               make.width.equalTo(130)
               make.height.equalTo(20)
               make.right.equalTo(-10)
               make.centerY.equalToSuperview()
           }
           self.contentView.addSubview(self.selectBtn)
           self.selectBtn.snp.makeConstraints { (make) in
               make.right.top.equalTo(0)
               make.width.height.equalTo(20)
           }
       }
       public func loadData(model:LZOfficeModel){
           
        if maxComparison(type1:model.type,type2:"pdf") {
            self.imageView.image = Img(url: "Icon-wenjianleixing")
        }else if maxComparison(type1:model.type,type2:"xls") {
            self.imageView.image = Img(url: "xls")
        }else if maxComparison(type1:model.type,type2:"docx") || maxComparison(type1:model.type,type2:"docx") {
            self.imageView.image = Img(url: "docx")
        }else if maxComparison(type1:model.type,type2:"zip") {
            self.imageView.image = Img(url: "yasuobao")
        }
        self.nameLabel.text = model.type
        self.selectBtn.isSelected = (model as! LZOfficeModel).isSelect
        self.selectBtn.isHidden = (model as! LZOfficeModel).isHidden
        if self.selectBtn.isSelected {
            self.bottomView.backgroundColor = COLOR_4990ED
            self.selectBtn.layer.borderWidth = 3
        }else{
            self.bottomView.backgroundColor = .black
            self.selectBtn.layer.borderWidth = 0
        }
       }
       required init?(coder aDecoder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
}
