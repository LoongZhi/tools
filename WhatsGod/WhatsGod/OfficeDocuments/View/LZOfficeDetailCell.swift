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
           btn.setImage(Img(url: "xuanze"), for: .normal)
           btn.setImage(Img(url: "xuanze-2"), for: .selected)
           return btn
       }()
       lazy var nameLabel:UILabel = {
           let label = UILabel.init()
            label.font = UIFont.systemFont(ofSize: 15)
            label.textAlignment = .center
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
           
            self.contentView.addSubview(self.nameLabel)
           self.contentView .addSubview(self.imageView)
           self.imageView.snp.makeConstraints { (make) in
              
            make.centerY.centerX.equalTo(self.contentView)
            make.width.height.equalTo(60)
//            make.bottom.equalTo(self.nameLabel).offset(-10)
               
           }
           
            self.nameLabel.snp.makeConstraints { (make) in
                 make.bottom.right.left.equalTo(0)
                 make.height.equalTo(20)
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
        }
        self.nameLabel.text = "name"
        self.selectBtn.isSelected = (model as! LZOfficeModel).isSelect
        self.selectBtn.isHidden = (model as! LZOfficeModel).isHidden
            
       }
       required init?(coder aDecoder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
}
