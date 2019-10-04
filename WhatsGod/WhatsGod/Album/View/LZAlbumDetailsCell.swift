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
        btn.setImage(Img(url: "xuanze"), for: .normal)
        btn.setImage(Img(url: "xuanze-2"), for: .selected)
        return btn
    }()
    
    lazy var imageView:UIImageView = {
        let image = UIImageView.init()
      
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        loadUI()
    }
    
    private func loadUI() {
        
      
        self.contentView .addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(0)
            
        }
        
        self.contentView.addSubview(selectBtn)
        selectBtn.snp.makeConstraints { (make) in
            make.right.top.equalTo(0)
            make.width.height.equalTo(20)
        }
    }
    public func loadData(model:LZAlbumImageModel){
        self.imageView.image = UIImage.init(data: model.image)
        self.selectBtn.isSelected = model.isSelect
        self.selectBtn.isHidden = model.isHidden
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
