//
//  LZAlbumDetailsCell.swift
//  WhatsGod
//
//  Created by imac on 9/28/19.
//  Copyright © 2019 L. All rights reserved.
//

import UIKit

class LZAlbumDetailsCell: UICollectionViewCell {
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
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        loadUI()
    }
    
    private func loadUI() {
        
        self.contentView.layer.borderWidth = 0.5
        self.contentView.layer.borderColor = UIColor.white.cgColor
        self.contentView.layer.masksToBounds = true
        self.contentView .addSubview(self.imageView)
        self.contentView .addSubview(self.bottomView)
        self.bottomView .addSubview(self.iconImage)
        self.bottomView .addSubview(self.nameLabel)
        self.imageView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(0)
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
            make.right.top.left.bottom.equalToSuperview()
          
        }
    }
    public func loadData(model:AnyObject){
        
         if model.isKind(of: LZAlbumImageModel.self) == true {
            
            self.imageView.image = UIImage.init(data: LZFileManager.getImageFile(filePath: (model as! LZAlbumImageModel).path))
            self.imageView.contentMode = .scaleAspectFill
            self.selectBtn.isSelected = (model as! LZAlbumImageModel).isSelect
            self.selectBtn.isHidden = (model as! LZAlbumImageModel).isHidden
            
         }else if model.isKind(of: LZVideoModel.self) == true{
            
            self.imageView.image = UIImage.init(data: LZFileManager.getViodeFile(filePath: (model as! LZVideoModel).imagePath))
            self.imageView.contentMode = .scaleAspectFill
            self.selectBtn.isSelected = (model as! LZVideoModel).isSelect
            self.selectBtn.isHidden = (model as! LZVideoModel).isHidden
            self.nameLabel.text = (model as! LZVideoModel).timer
            
         }else if model.isKind(of: LZOfficeModel.self) == true{
            self.imageView.image = UIImage.init(data: LZFileManager.getOfficeFile(filePath: (model as! LZOfficeModel).imagePath))
            self.imageView.contentMode = .scaleAspectFill
            self.selectBtn.isSelected = (model as! LZOfficeModel).isSelect
            self.selectBtn.isHidden = (model as! LZOfficeModel).isHidden
        }
        
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
