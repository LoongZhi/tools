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

        return image
    }()
    lazy var nameLabel:UILabel = {
        let label = UILabel.init()
        return label
    }()
    lazy var rightImage:UIImageView = {
           let image = UIImageView.init()
           image.image = Img(url: "xiayige")
           return image
      }()
    lazy var sw:UISwitch = {
        let view = UISwitch.init()
        view.onTintColor = COLOR_4990ED
        return view
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
        self.contentView.addSubview(self.sw)
        self.iconImage.snp.makeConstraints { (make) in
         
            make.centerY.equalToSuperview()
            make.left.equalTo(15)
           make.width.height.equalTo(25)
        }
        
        self.nameLabel.snp.makeConstraints { (make) in
             make.centerY.equalTo(self.iconImage)
             make.left.equalTo(self.iconImage.snp.right).offset(20)
             make.right.equalTo(self.rightImage.snp.left).offset(-10)
        }

        self.rightImage.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalTo(-10)
            make.width.equalTo(15)
            make.height.equalTo(20)
        }
        
        self.sw.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalTo(-10)
        }
        
    }

    func layoutUI(arr:Array<String>,index:IndexPath) {
        
       
        self.iconImage.image = Img(url: arr.first ?? "")
        self.nameLabel.text = arr.last ?? ""
        
    }
    

}
