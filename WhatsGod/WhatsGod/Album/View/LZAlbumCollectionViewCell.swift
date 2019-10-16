//
//  LZAlbumCollectionViewCell.swift
//  WhatsGod
//
//  Created by imac on 9/27/19.
//  Copyright © 2019 L. All rights reserved.
//

import UIKit

class LZAlbumCollectionViewCell: UICollectionViewCell {
    lazy var img:UIImageView = {
        let imgView = UIImageView.init()
        imgView.image = Img(url: "Folder_64px")
        imgView.isUserInteractionEnabled = false;
        return imgView
    }()
    lazy var title:UILabel = {
        let label = UILabel.init()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    lazy var delBtn:UIButton = {
        let btn = UIButton.init()
        
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.setImage(Img(url: "danseshixintubiao-"), for: .normal)
        
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        loadUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   private func loadUI() {
        self.contentView.addSubview(self.img)
        self.contentView.addSubview(self.delBtn)
        self.contentView.addSubview(self.title)
    
        img.snp.makeConstraints { (make) in
            make.top.equalTo(self.contentView).offset(5)
            make.centerY.centerX.equalTo(self.contentView)
            make.width.equalTo(60)
            make.bottom.equalTo(self.title).offset(-10)
            
        }
 
    
    
    self.title.snp.makeConstraints { (make) in
        make.bottom.right.left.equalTo(0)
        make.height.equalTo(20)
    }
        self.delBtn.snp.makeConstraints { (make) in
            make.width.equalTo(25)
            make.height.equalTo(25)
            make.top.equalTo(5)
            make.right.equalTo(-10)
        }
    }
    
    
    public func loadData(model:AnyObject){
        
        
        if model.isKind(of: LZAlbumModel.self) == true {
            self.delBtn.isHidden = (model as! LZAlbumModel).isHidden
            self.title.text = (model as! LZAlbumModel).finderName
        }else{
            self.delBtn.isHidden = (model as! LZVideoFolderModel).isHidden
            self.title.text = (model as! LZVideoFolderModel).finderName
        }

       
      
    }
    
}
