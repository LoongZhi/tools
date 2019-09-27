//
//  LZAlbumCollectionViewCell.swift
//  WhatsGod
//
//  Created by imac on 9/27/19.
//  Copyright © 2019 L. All rights reserved.
//

import UIKit

class LZAlbumCollectionViewCell: UICollectionViewCell {
    lazy var imgBtn:UIButton = {
        let btn = UIButton.init()
        btn.setImage(UIImage.init(named: "Folder_64px"), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.setTitleColor(UIColor.black, for: .normal)
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
        self.contentView .addSubview(imgBtn)
        
        imgBtn.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(0)
        }
    }
    
    public func loadData(model:LZAlbumModel){
        
        self.imgBtn.setTitle(model.finderName, for: .normal)
        
        let imageSize = self.imgBtn.imageView?.frame.size
        let titleSize = self.imgBtn.titleLabel?.frame.size
        
        self.imgBtn.titleEdgeInsets = UIEdgeInsets.init(top: 8, left: -imageSize!.width, bottom: -imageSize!.height - 15, right: 0)
        self.imgBtn.imageEdgeInsets = UIEdgeInsets.init(top: -titleSize!.height + 40, left: 0, bottom: 0, right: -titleSize!.width)
    }
    
}
