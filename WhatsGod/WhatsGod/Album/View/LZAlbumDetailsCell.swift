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
        let btn = UIButton.init(frame: self.contentView.bounds)
        btn.backgroundColor = .clear
        btn.layer.borderColor  = COLOR_F8F8FF.cgColor
        return btn
    }()
    var albumIcon = Img(url: "tupantubiao")
    var videoIcon = Img(url: "shexiang")
    lazy var bottomView:UIView = {
        let view = UIView.init(frame: CGRect(x: 0, y: self.contentView.bounds.size.height - 25, width: self.contentView.bounds.size.width, height: 25))
        view.backgroundColor = .clear
       return view
    }()
    lazy var iconImage:UIImageView = {
        let image = UIImageView.init(frame: CGRect(x: 5, y: self.bottomView.frame.size.height / 2 - 7.5, width: 15, height: 15))
        return image
    }()
    lazy var nameLabel:UILabel = {
        let label = UILabel.init(frame: CGRect(x: self.bottomView.frame.width - 140, y: self.bottomView.frame.size.height / 2 - 10, width: 130, height: 20))
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .white
        label.textAlignment = .right
        return label
    }()
    lazy var imageView:UIImageView = {
        let image = UIImageView.init()
        image.backgroundColor = COLOR_B8B8B8
        image.contentMode = .scaleAspectFill
        image.kf.indicatorType = .activity
        return image
    }()
     lazy var videoPlayer:SJVideoPlayer = {
           let player = SJVideoPlayer.init()
           return player
       }()
    lazy var playerBtn:UIButton = {
           let btn = UIButton.init(frame: CGRect(x: self.contentView.bounds.size.width / 2 - 30, y: self.contentView.bounds.size.height / 2 - 30, width: 60, height: 60))
            btn.setBackgroundImage(Img(url: "db_play_big"), for: .normal)
           btn.backgroundColor = UIColor.clear
           return btn
       }()
    lazy var contentLabel:UILabel = {
        let label = UILabel.init()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 2
        label.textColor = .white
        label.isHidden = true
        return label
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
        self.contentView.addSubview(self.playerBtn)
        self.contentView.addSubview(self.contentLabel)
        
        self.selectBtn.layer.borderColor = COLOR_4990ED.cgColor;
        
        self.imageView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
        self.contentLabel.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(10)
          
        }
//        self.bottomView.snp.makeConstraints { (make) in
//            make.left.bottom.right.equalToSuperview()
//            make.height.equalTo(25)
//        }
//        self.layoutIfNeeded()
//        let blurEffect = UIBlurEffect(style: .light)
//        let blurView = UIVisualEffectView(effect: blurEffect)
//        blurView.frame.size = CGSize(width: self.bottomView.frame.width, height: self.bottomView.frame.height)
//        blurView.contentView.addSubview(self.iconImage)
//        blurView.contentView.addSubview(self.nameLabel)
//        self.bottomView.addSubview(blurView)
//        self.iconImage.snp.makeConstraints { (make) in
//            make.width.equalTo(15)
//            make.height.equalTo(15)
//            make.left.equalTo(5)
//            make.centerY.equalToSuperview()
//        }
//        self.nameLabel.snp.makeConstraints { (make) in
//            make.width.equalTo(130)
//            make.height.equalTo(20)
//            make.right.equalTo(-10)
//            make.centerY.equalToSuperview()
//        }
        
        self.contentView.addSubview(self.selectBtn)
//        self.selectBtn.snp.makeConstraints { (make) in
//            make.right.top.left.bottom.equalToSuperview()
//
//        }
        
    }
   
    public func loadData(model:LZAlbumImageModel){
        self.playerBtn.isHidden = true;
            let url:URL = URL.init(string:"file://\(albumsFolder)\(model.thumbnailPath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)")!
            DispatchQueue.global().async {
                
                DispatchQueue.main.async {
                    
                    self.imageView.image = downsample(imageAt: url, to: CGSize(width: SCREEN_WIDTH / 4, height: SCREEN_WIDTH / 4), scale: 3)
                }
            }
            self.selectBtn.isSelected = model.isSelect
            self.selectBtn.isHidden = model.isHidden
            self.nameLabel.text = model.type
            self.iconImage.image = self.albumIcon

        if self.selectBtn.isSelected {
            self.bottomView.backgroundColor = COLOR_4990ED
            self.selectBtn.layer.borderWidth = 3
          
        }else{
            self.bottomView.backgroundColor = .black
            self.selectBtn.layer.borderWidth = 0
       
        }
    }
    public func loadDataVideoModel(model:LZVideoModel){
        
        let url:URL = URL(string: "file://\(videoFolder)\(model.imagePath.addingPercentEncoding(withAllowedCharacters:.urlQueryAllowed)!)")!
        DispatchQueue.global().async {
       
            DispatchQueue.main.async {
                
                self.imageView.image = downsample(imageAt: url, to: CGSize(width: SCREEN_WIDTH / 4, height: SCREEN_WIDTH / 4), scale: 3)
              
            }
        }
        self.bottomView.isHidden = true
        self.contentLabel.isHidden = false
        self.contentLabel.text = model.name
        self.selectBtn.isSelected = model.isSelect
        self.selectBtn.isHidden = model.isHidden
        
        self.nameLabel.text = model.timer
                 
        self.iconImage.image = self.videoIcon
        
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


