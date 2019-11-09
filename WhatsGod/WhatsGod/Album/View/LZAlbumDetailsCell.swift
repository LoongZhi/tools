//
//  LZAlbumDetailsCell.swift
//  WhatsGod
//
//  Created by imac on 9/28/19.
//  Copyright © 2019 L. All rights reserved.
//

import UIKit
import Kingfisher
class LZAlbumDetailsCell: UICollectionViewCell {
    lazy var selectBtn:UIButton = {
        let btn = UIButton.init()
        btn.backgroundColor = .clear
        btn.layer.borderColor  = COLOR_F8F8FF.cgColor
        return btn
    }()
    var albumIcon = Img(url: "tupantubiao")
    var videoIcon = Img(url: "shexiang")
    lazy var bottomView:UIView = {
        let view = UIView.init()
        view.backgroundColor = .clear
       return view
    }()
    lazy var iconImage:UIImageView = {
        let image = UIImageView.init()
        image.layer.masksToBounds = true
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
        image.backgroundColor = COLOR_B8B8B8
        image.contentMode = .scaleAspectFill
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
        self.contentView.addSubview(self.imageView)
        self.contentView.addSubview(self.bottomView)
        self.bottomView.addSubview(self.iconImage)
        self.bottomView.addSubview(self.nameLabel)
        self.imageView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
        
        self.bottomView.snp.makeConstraints { (make) in
            make.left.bottom.right.equalToSuperview()
            make.height.equalTo(25)
        }
        self.layoutIfNeeded()
        let blurEffect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame.size = CGSize(width: self.bottomView.frame.width, height: self.bottomView.frame.height)
        blurView.contentView.addSubview(self.iconImage)
        blurView.contentView.addSubview(self.nameLabel)
        self.bottomView.addSubview(blurView)
        self.iconImage.snp.makeConstraints { (make) in
            make.width.equalTo(15)
            make.height.equalTo(15)
            make.left.equalTo(5)
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
        self.transform = CGAffineTransform(scaleX: 1.4, y: 1.4)
        UIView.animate(withDuration: 0.5) {
            self.transform = CGAffineTransform.identity
        }
        self.imageView.kf.indicatorType = .activity
        
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        
    }
   
    public func loadData(model:AnyObject){
        
         if model.isKind(of: LZAlbumImageModel.self) == true {

            let url:URL = URL.init(string: "file://" + albumsFolder + (model as! LZAlbumImageModel).path.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!
            self.imageView.kf.setImage(with: url, placeholder: nil, options: [.scaleFactor(80),
                                                                              .transition(.fade(0.01)),
            .cacheOriginalImage], progressBlock: nil) { (image, error, type, url) in

            }
        
            self.selectBtn.isSelected = (model as! LZAlbumImageModel).isSelect
            self.selectBtn.isHidden = (model as! LZAlbumImageModel).isHidden
            self.nameLabel.text = (model as! LZAlbumImageModel).type
            self.iconImage.image = self.albumIcon
         }else if model.isKind(of: LZVideoModel.self) == true{
            
              let url:URL = URL.init(string: "file://" + videoFolder + (model as! LZVideoModel).imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!
            self.imageView.kf.setImage(with: url, placeholder: nil, options: [.scaleFactor(UIScreen.main.scale),
                                  .transition(.fade(1)),
                                  .cacheOriginalImage], progressBlock: nil) { (image, error, type, url) in
            }
            self.selectBtn.isSelected = (model as! LZVideoModel).isSelect
            self.selectBtn.isHidden = (model as! LZVideoModel).isHidden
            self.nameLabel.text = (model as! LZVideoModel).timer
            self.iconImage.image = self.videoIcon
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


