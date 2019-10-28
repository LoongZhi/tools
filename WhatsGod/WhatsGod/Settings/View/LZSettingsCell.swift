//
//  LZSettingsCell.swift
//  WhatsGod
//
//  Created by imac on 10/5/19.
//  Copyright © 2019 L. All rights reserved.
//

import UIKit

class LZSettingsCell: UITableViewCell {

    lazy var iconImage:UIImageView = {
        let image = UIImageView.init()
        image.backgroundColor = .orange
        return image
    }()
    lazy var nameLabel:UILabel = {
        let label = UILabel.init()
        return label
    }()
    lazy var rightImage:UIImageView = {
           let image = UIImageView.init()
           image.backgroundColor = .orange
           return image
      }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        loadUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func loadUI(){
        
               self.contentView.addSubview(self.iconImage)
               self.contentView.addSubview(self.nameLabel)
               self.contentView.addSubview(self.rightImage)
               
               self.iconImage.snp.makeConstraints { (make) in
                
                   make.centerY.equalToSuperview()
                   make.left.equalTo(15)
                  make.width.height.equalTo(30)
               }
               
               self.nameLabel.snp.makeConstraints { (make) in
                    make.centerY.equalTo(self.iconImage)
                    make.left.equalTo(self.iconImage.snp.right).offset(10)
                    make.right.equalTo(self.rightImage.snp.left).offset(-10)
               }

               self.rightImage.snp.makeConstraints { (make) in
                   make.centerY.equalToSuperview()
                   make.right.equalTo(-10)
                   make.width.equalTo(10)
                   make.height.equalTo(15)
               }
    }

    func layoutUI(arr:Array<String>) {
        
        self.iconImage.image = Img(url: arr.first ?? "")
        self.nameLabel.text = arr.last ?? ""
        
    }
    

}
