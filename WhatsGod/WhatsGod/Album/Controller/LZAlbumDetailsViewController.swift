//
//  LZAlbumDetailsViewController.swift
//  WhatsGod
//
//  Created by imac on 9/28/19.
//  Copyright © 2019 L. All rights reserved.
//

import UIKit
import FWPopupView
import DKImagePickerController
import AVFoundation
import AVKit
import AssetsLibrary
import Photos
import JXPhotoBrowser
import QuickLook
class LZAlbumDetailsViewController: LZBaseViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,QLPreviewControllerDelegate,QLPreviewControllerDataSource  {

    var  menuView:FWMenuView? = nil
    var  isHidden:Bool = true
    let images = [UIImage(named: "right_menu_multichat_white"),
                  UIImage(named: "right_menu_addFri_white"),]
//    var indexs:Array = Array<Int>()
    var exCount = 0
    var paths = [String]()
    public var folderModel:LZAlbumModel? = nil
    private var imageDataArr = NSArray()
    private lazy var collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        layout.itemSize = CGSize.init(width: SCREEN_WIDTH / 4, height: SCREEN_WIDTH / 4)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        let collection = UICollectionView.init(frame: self.view.bounds, collectionViewLayout: layout)
        collection.dataSource = self
        collection.delegate = self
        collection.backgroundColor = UIColor.white
        return collection;
    }()
    private lazy var pickerController:DKImagePickerController = {
        let pc = DKImagePickerController.init()
        pc.assetType = .allPhotos
        return pc
        
    }()
    private lazy var bottomView:UIView = {
        let view = UIView.init()
        view.backgroundColor = UIColor.white
//        view.layer.borderWidth = 0.5
//        view.layer.borderColor = UIColor.gray.cgColor
        
        return view;
    }()
    private lazy var allBtn:UIButton = {
        let btn = UIButton.init()
        btn.setImage(Img(url: "xuanze"), for: .normal)
        btn.setImage(Img(url: "xuanze-2"), for: .selected)
        btn.addTarget(self, action: #selector(allEvent(btn:)), for: .touchUpInside)
        return btn
    }()
    private lazy var delBtn:UIButton = {
        let btn = UIButton.init()
        btn.setTitle(LanguageStrins(string: "delete"), for: .normal)
        btn.backgroundColor = UIColor.red
        btn.addTarget(self, action: #selector(delTouch), for: .touchUpInside)
        return btn
    }()
    private lazy var exploitBtn:UIButton = {
           let btn = UIButton.init()
           btn.setTitle(LanguageStrins(string: "Exploit"), for: .normal)
           btn.backgroundColor = UIColor.red
           btn.addTarget(self, action: #selector(exploitTouch), for: .touchUpInside)
           return btn
    }()
    private lazy var allLabel:UILabel = {
        let label = UILabel.init()
        label.text = LanguageStrins(string: "all")
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
  
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        // Do any additional setup after loading the view.
        readyView()
    }
    
    @objc override func readyView(){
        
        self.view.addSubview(self.collectionView)
        self.view.addSubview(self.bottomView)
        
          self.bottomView.snp.makeConstraints { (make) in
              make.right.left.equalTo(0)
              make.height.equalTo(49)
              make.bottom.equalTo(-lzBottomSafeHeight)
          }
         
          self.bottomView.topBorder(width: 0.3, borderColor: UIColor.gray)
          
          self.bottomView.addSubview(self.allBtn)
          self.allBtn.snp.makeConstraints { (make) in
              make.left.equalTo(15)
              make.top.equalTo(12)
              make.width.height.equalTo(20)
             
          }
          
          self.bottomView.addSubview(self.allLabel)
          self.allLabel.snp.makeConstraints { (make) in
              make.left.equalTo(self.allBtn.snp.right).offset(10)
              make.top.equalTo(8)
              make.width.equalTo(80)
              make.height.equalTo(25)
          }
        self.bottomView.addSubview(self.delBtn)
        self.delBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-15)
            make.top.equalTo(7)
            make.width.equalTo(80)
            make.height.equalTo(35)
        }
        self.delBtn.setRoundCorners(corners: .allCorners, with: 5)
        
        self.bottomView.addSubview(self.exploitBtn)
        self.exploitBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-110)
            make.top.equalTo(7)
            make.width.equalTo(80)
            make.height.equalTo(35)
        }
        self.exploitBtn.setRoundCorners(corners: .allCorners, with: 5)
        
        let itme = UIBarButtonItem.init(image: Img(url: "mqz_nav_add"), style: .done, target: self, action:  #selector(rightItmeEvent));
        self.navigationItem.rightBarButtonItem = itme;
        
        
        self.collectionView.register(LZAlbumDetailsCell.classForCoder(), forCellWithReuseIdentifier: "LZAlbumDetailsCell")
        

        self.collectionView.snp.makeConstraints { (make) in
            make.top.right.left.equalTo(0)
            make.bottom.equalTo(self.bottomView.snp.top).offset(0)
        }
        
        self.getDataSource()
        
        let vProperty = FWMenuViewProperty()
        vProperty.popupCustomAlignment = .topRight
        vProperty.popupAnimationType = .scale
        vProperty.maskViewColor = UIColor(white: 0, alpha: 0.2)
        vProperty.touchWildToHide = "1"
        vProperty.popupViewEdgeInsets = UIEdgeInsets(top:lzNavigationHeight, left: 0, bottom: 0, right: 8)
        vProperty.topBottomMargin = 0
        vProperty.animationDuration = 0.3
        vProperty.popupArrowStyle = .round
        vProperty.popupArrowVertexScaleX = 1
        vProperty.backgroundColor = kPV_RGBA(r: 64, g: 63, b: 66, a: 1)
        vProperty.splitColor = kPV_RGBA(r: 64, g: 63, b: 66, a: 1)
        vProperty.separatorColor = kPV_RGBA(r: 91, g: 91, b: 93, a: 1)
        vProperty.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.backgroundColor: UIColor.clear, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15.0)]
        vProperty.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        
        
        self.menuView = FWMenuView.menu(itemTitles: [LanguageStrins(string: "Add"),LanguageStrins(string: "Edit")], itemImageNames:images as! [UIImage], itemBlock: { (popupView, index, title) in
            print("Menu：点击了第\(index)个按钮")
            
            switch (index) {
            case 0:
                self.pickerController.didSelectAssets = { (assets) in
                    self.startAnimating(lodingSize,type: loadingType, color: COLOR_4990ED)
                    for (index,itme) in assets.enumerated() {
                        let model:DKAsset = itme
                        PHCachingImageManager.default().requestImage(for: model.originalAsset!, targetSize: PHImageManagerMaximumSize, contentMode: .default, options: nil) { (result: UIImage?, dictionry: Dictionary?) in
                            let url:String = model.originalAsset?.value(forKey: "filename") as! String
                            let type = url.returnFileType(fileUrl: url)
                            let path = self.folderModel!.path + "/image" + String(format: "%d.%@",Date().timeIntervalSince1970,type)
                            
                            let img = UIImage.init(data: try! Data.init(contentsOf: dictionry!["PHImageFileURLKey"] as! URL))
                            if LZFileManager.writeImageFile(filePath: path, data:(img!.jpegData(compressionQuality: 1))!){
                                let imageModel = LZAlbumImageModel.init()
                                imageModel.isHidden = self.isHidden
                                imageModel.path = path
                                imageModel.type = type
                                try! realm.write {
                                    self.folderModel?.images.append(imageModel)
                                }
                            }
                            
                            if index == assets.count - 1{
                                 self.getDataSource()
                            }
                    }
                        if assets.count == 0 {
                            self.stopAnimating()
                        }
                    
                   
                   
                    }
                    
                }
                self.present(self.pickerController, animated: true, completion: nil)
                break;
            case 1:
                let itme = UIBarButtonItem.init(title: LanguageStrins(string: "Completed"), style: .done, target: self, action: #selector(self.leftItmeEvent))
                self.navigationItem.leftBarButtonItem = itme
                self.isHidden = false
                self.setHidden(hidden: self.isHidden)
                break;
            default:
                break;
            }
        }, property: vProperty)
        
        
        self.setHidden(hidden: self.isHidden)
        for item in self.dataSource {
            let model:LZAlbumImageModel = item as! LZAlbumImageModel
            try! realm.write {
                model.isSelect = false
            }
        }
    }
    
    private func getDataSource(){
        
        if self.dataSource.count != 0 {
            self.dataSource.removeAll()
        }
     
        if folderModel!.images.count != 0{
            
            for image in folderModel!.images {
                self.dataSource.append(image)
            }
        }
      
        self.collectionView .reloadData()
        self.stopAnimating()
    }
    override func rightItmeEvent() {
        
        if self.isRightPhoto() {
            self.menuView?.show()
        }else{
            let alert = FWAlertView.alert(title: LanguageStrins(string: "Tips"), detail: LanguageStrins(string: "Whether you delete the folder"), confirmBlock: { (view, number, str) in
             
                let url = URL(string: UIApplication.openSettingsURLString)
                if let url = url, UIApplication.shared.canOpenURL(url) {
                    if #available(iOS 10, *) {
                        UIApplication.shared.open(url, options: [:],
                                                  completionHandler: {
                                                    (success) in
                        })
                    } else {
                       UIApplication.shared.openURL(url)
                    }
                }
            }) { (view, number, str) in
                
            }
            alert.show()
        }
         
    }
    override func leftItmeEvent() {
            self.allBtn.isSelected = true
            self.allEvent(btn: self.allBtn)
           self.isHidden = true
           self.setHidden(hidden: self.isHidden)
           self.navigationItem.leftBarButtonItem = nil
           
       }
    private func setHidden(hidden:Bool){
         
           self.bottomView.isHidden = hidden
           if self.dataSource.count == 0 {
               return
           }
           for (index,value) in self.dataSource.enumerated() {
               let model:LZAlbumImageModel = value as! LZAlbumImageModel
               
               try! realm.write {
                   model.isHidden = hidden
                   self.dataSource[index] = model
               }
               
           }
            
          
           self.collectionView.reloadData()
       }
    // 相机权限
       func isRightCamera() -> Bool {

                   let authStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)

           return authStatus != .restricted && authStatus != .denied

       }
       // 相册权限
       func isRightPhoto() -> Bool {

           let authStatus = ALAssetsLibrary.authorizationStatus()

           return authStatus != .restricted && authStatus != .denied

       }

    @objc func allEvent(btn:UIButton) -> Void {
        btn.isSelected = !btn.isSelected
        
    
        if btn.isSelected {
            for itme in self.dataSource{
            
                try! realm.write {
                    let model:LZAlbumImageModel =  itme as! LZAlbumImageModel
                    model.isSelect = true
                }
            }
        }else{
            for itme in self.dataSource {
              
                try! realm.write {
                    let model:LZAlbumImageModel =  itme as! LZAlbumImageModel
                    model.isSelect = false
                }
            }
        }
        
        self.collectionView.reloadData()
    }
    @objc func touchBtn(btn:UIButton) -> Void {
        if self.dataSource.count != 0 {
            btn.isSelected = !btn.isSelected
            try! realm.write {
               let model:LZAlbumImageModel =  self.dataSource[btn.tag] as! LZAlbumImageModel
                model.isSelect = btn.isSelected
            }
            let indexPath = IndexPath.init(row: btn.tag, section: 0)
            self.collectionView.reloadItems(at: [indexPath])
            
            
        }
    }
    
    @objc func delTouch(){
        
        
        let alert = FWAlertView.alert(title: LanguageStrins(string: "Tips"), detail: LanguageStrins(string: "Remove photos?"), confirmBlock: { (view, num, str) in
            
            var isbool = true
            
            for (index,itme) in self.dataSource.enumerated(){
                 let model:LZAlbumImageModel = itme as! LZAlbumImageModel
                if model.isSelect {
                    LZFileManager.deleteImageFile(filePath: model.path)
                    try! realm.write {
                        let indexNum1:Int? =  self.folderModel?.images.index(of: model)
                        self.folderModel?.images.remove(at: indexNum1!)
                        
                    }
                    isbool = false
                }
            }
            self.getDataSource()
            if isbool{
                self.chrysan.show(.plain, message:LanguageStrins(string: "Please select the photograph to be deleted"), hideDelay: HIDE_DELAY)
            }else{
                 self.chrysan.show(.plain, message:LanguageStrins(string: "Delete success."), hideDelay: HIDE_DELAY)
            }

        }) { (view, num, str) in
            
        }
        
        alert.show()
        self.collectionView.reloadData()
    }
    @objc func exploitTouch(){
      
       
        let alert = FWAlertView.alert(title: LanguageStrins(string: "Tips"), detail: LanguageStrins(string: "Export the photos to the album"), confirmBlock: { (view, num, str) in
            
            self.exportFile()

        }) { (view, num, str) in
                   
        }
        alert.show()
       
    }
   
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    //cellForItemAt indexPath
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let reuseIdentifier = "LZAlbumDetailsCell"
        let cell:LZAlbumDetailsCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! LZAlbumDetailsCell
        cell.loadData(model: self.dataSource[indexPath.row] as! LZAlbumImageModel)
        cell.selectBtn.tag = indexPath.item
        cell.selectBtn.addTarget(self, action:#selector(touchBtn(btn:)) , for: .touchUpInside)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        let localData = JXLocalDataSource(numberOfItems: { () -> Int in
                   return self.dataSource.count
               }, localImage: { (index) -> UIImage? in
                   let data:LZAlbumImageModel = self.dataSource[index] as! LZAlbumImageModel
                let image = UIImage.init(data: LZFileManager.getImageFile(filePath: data.path))
                   return image
        })
        
        JXPhotoBrowser(dataSource: localData).show(pageIndex: indexPath.item)
    }



}
extension LZAlbumDetailsViewController{
    
    func exportFile(){

        startAnimating(lodingSize,type: loadingType, color: COLOR_4990ED)
        self.paths.removeAll()
    
        for pathModel in self.folderModel!.images {
            let m:LZAlbumImageModel = pathModel 
            if m.isSelect {
                paths.append(albumsFolder + m.path)
            }
        }
        if self.paths.count == 0 {
             stopAnimating()
             self.chrysan.show(.plain, message:LanguageStrins(string: "Please select the compressed file"), hideDelay: HIDE_DELAY)
            return
        }
        if SSZipArchive.createZipFile(atPath:tempAlbumPath, withFilesAtPaths: paths) {
            print("压缩成功")
            if (rootFileManager.fileExists(atPath: tempAlbumPath)) {
                let vc = QLPreviewController.init()
                vc.delegate = self
                vc.dataSource = self
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }else{
            print("压缩失败")
             self.chrysan.show(.plain, message:LanguageStrins(string: "Compression failed"), hideDelay: HIDE_DELAY)
        }
    
        stopAnimating()
    }
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return 1
    }
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        
        let videoUrl = URL.init(fileURLWithPath: tempAlbumPath)
        return videoUrl as QLPreviewItem
    
    }
}
