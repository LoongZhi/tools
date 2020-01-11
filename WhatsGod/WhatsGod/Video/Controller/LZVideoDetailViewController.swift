//
//  LZVideoDetailViewController.swift
//  WhatsGod
//
//  Created by imac on 10/15/19.
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
class LZVideoDetailViewController: LZBaseViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,QLPreviewControllerDelegate,QLPreviewControllerDataSource,VLCMediaPlayerDelegate {
    var movieView: UIView!
    var  menuView:FWMenuView? = nil
    var  isHidden:Bool = true
     var indexPaths = IndexPath.init(row: 0, section: 0)
    let images = [UIImage(named: "right_menu_multichat_white"),
                  UIImage(named: "right_menu_addFri_white"),]
//    var indexs:Array = Array<Int>()
    var exCount = 0
    var paths = [String]()
    let mediaPlayer = VLCMediaPlayer.init(options: nil)
    public  var folderModel:LZVideoFolderModel? = nil
    private var imageDataArr = NSArray()
    private lazy var collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        layout.itemSize = CGSize.init(width: SCREEN_WIDTH, height: SCREEN_HEIGHT / 4)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        layout.headerReferenceSize = CGSize(width: SCREEN_WIDTH, height: 50)
        let collection = UICollectionView.init(frame: self.view.bounds, collectionViewLayout: layout)
        loadAD()
        collection.addSubview(bannerView)
        let emptyView = LYEmptyView.emptyActionView(withImageStr: "k03", titleStr: LanguageStrins(string: "No more videos"), detailStr: LanguageStrins(string: "Please add your own video ~"), btnTitleStr: LanguageStrins(string: "Add")) {
            self.addVideo()
        };
        emptyView!.actionBtnBackGroundColor = COLOR_4990ED
        emptyView!.actionBtnTitleColor = .white
        emptyView!.actionBtnCornerRadius = 5
        emptyView!.contentViewY = lzNavigationHeight + 50
        collection.ly_emptyView = emptyView
        collection.dataSource = self
        collection.delegate = self
        collection.backgroundColor = UIColor.white
        return collection
    }()
   
    private lazy var pickerController:DKImagePickerController = {
        let pc = DKImagePickerController.init()
        pc.assetType = .allVideos
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
    private lazy var videoPlayer:SJVideoPlayer = {
            let player = SJVideoPlayer.init()
            return player
        }()
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        // Do any additional setup after loading the view.
        readyView()
//        NotificationCenter.default.addObserver(
//                  self,
//                  selector: #selector(rotated),
//                  name: UIDevice.orientationDidChangeNotification,
//                  object: nil)
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
            make.bottom.equalTo(-lzBottomSafeHeight)
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
        
        
        self.menuView = FWMenuView.menu(itemTitles: [LanguageStrins(string: "Add"),LanguageStrins(string: "Edit")], itemImageNames:images as! [UIImage], itemBlock: { [weak self] (popupView, index, title) in

            switch (index) {
            case 0:
                self!.addVideo()
                break;
            case 1:
                let itme = UIBarButtonItem.init(title: LanguageStrins(string: "Completed"), style: .done, target: self, action: #selector(self!.leftItmeEvent))
                self!.navigationItem.leftBarButtonItem = itme
                self!.isHidden = false
                self!.setHidden(hidden: self!.isHidden)
                break;
            default:
                break;
            }
        }, property: vProperty)
        
        
        self.setHidden(hidden: self.isHidden)
        for item in self.dataSource {
            let model:LZVideoModel = item as! LZVideoModel
            try! realm.write {
                model.isSelect = false
            }
        }
    }
    
    func addVideo(){
        let paths = self.folderModel?.path
        self.pickerController.didSelectAssets = { (assets) in
        self.startAnimating(lodingSize,type: loadingType, color: COLOR_4990ED)
        let queue = DispatchQueue(label: "queueName", attributes: .concurrent)
        for (index,itme) in assets.enumerated() {
            let model:DKAsset = itme
            PHCachingImageManager.default().requestAVAsset(forVideo: model.originalAsset!, options: nil) {[weak self] (asset:AVAsset?, minx:AVAudioMix?, info:[AnyHashable : Any]?) in
                                                   
            queue.async {
                let url:String = model.originalAsset?.value(forKey: "filename") as! String
                let type = url.returnFileType(fileUrl: url)
                let path = "\(paths!)/Video\(String(format: "%d.%@",Date().timeIntervalSince1970,type))"
                let ImagePath = "\(paths!)/Thumb\(String(format: "%d.jpg",Date().timeIntervalSince1970))"
                if asset == nil{
                    self!.stopAnimating()
                    return
                }
                let urlAsset:AVURLAsset = asset as! AVURLAsset
                let strUrl = urlAsset.url
                print(strUrl)
                //                                let data:NSData = try! NSData(contentsOf: strUrl as URL)
                guard let jsonData = try? Data.init(contentsOf: strUrl, options: Data.ReadingOptions.alwaysMapped) else {
                    self!.stopAnimating()
                    return
                                              
                }
                if LZFileManager.writeVideoFile(filePath: path, data:Data(jsonData)){
                    let imgData:Data = getVideoFengMian(url: urlAsset.url).jpegData(compressionQuality: 1)!
                    if LZFileManager.writeVideoFile(filePath: ImagePath, data:imgData){
                        print("写入成功")
                    }else{
                        print("写入失败")
                                                    
                    }
                    let videoModel = LZVideoModel.init()
                    videoModel.isHidden = self!.isHidden
                    videoModel.path = path
                    videoModel.type = type
                    videoModel.name = url
                    videoModel.imagePath = ImagePath
                    videoModel.timerscale = Int(urlAsset.duration.seconds)
                    videoModel.timer = String.init().transToHourMinSecs(time:videoModel.timerscale)
                    DispatchQueue.main.async {
                        try! realm.write {
                            self!.folderModel?.images.append(videoModel)
                        }
                                                          
                    }
                }
                }
                DispatchGroup.init().notify(qos: .default, flags: .barrier, queue: queue) {
                    DispatchQueue.main.async {
                        if index == assets.count - 1{
                            self!.getDataSource()
                        }
                    }
                }
            }
                        
            }
            if assets.count == 0 {
                self.stopAnimating()
            }
        }
                        
        self.present(self.pickerController, animated: true, completion: nil)
    }
    private func getDataSource(){
        
       
     DispatchQueue.global().async {
             
            DispatchQueue.main.async {
                if self.dataSource.count != 0 {
                           self.dataSource.removeAll()
                       }
                if self.folderModel!.images.count != 0{
                    for image in self.folderModel!.images {
                        self.dataSource.append(image)
                    }
                }
                if self.dataSource.count == 0 {
                    self.allBtn.isSelected = false
                }
                self.collectionView.reloadDataSmoothly()
                self.stopAnimating()
            }
    }
       
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
               let model:LZVideoModel = value as! LZVideoModel
               
               try! realm.write {
                   model.isHidden = hidden
                   self.dataSource[index] = model
               }
               
           }
            
          
           self.collectionView.reloadDataSmoothly()
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
        
        if self.dataSource.count == 0 {
            self.chrysan.show(.plain, message:LanguageStrins(string: "Please import the file!"), hideDelay: HIDE_DELAY)
            return
        }
        btn.isSelected = !btn.isSelected
        if btn.isSelected {
            for itme in self.dataSource{
            
                try! realm.write {
                    let model:LZVideoModel =  itme as! LZVideoModel
                    model.isSelect = true
                }
            }
        }else{
            for itme in self.dataSource {
              
                try! realm.write {
                    let model:LZVideoModel =  itme as! LZVideoModel
                    model.isSelect = false
                }
            }
        }
        
        self.collectionView.reloadDataSmoothly()
    }
    @objc func touchBtn(btn:UIButton) -> Void {
        if self.dataSource.count != 0 {
            btn.isSelected = !btn.isSelected
           
            try! realm.write {
               let model:LZVideoModel =  self.dataSource[btn.tag] as! LZVideoModel
                model.isSelect = btn.isSelected
            }
            let indexPath = IndexPath.init(row: btn.tag, section: 0)
            self.collectionView.reloadItems(at: [indexPath])
            var isbool = true
            for obj in self.dataSource {
               let model:LZVideoModel =  obj as! LZVideoModel
                if model.isSelect == false {
                    isbool = false
                    break;
                }
            }
            self.allBtn.isSelected = isbool;
            
        }
    }
    @objc func playerBtn(btn:UIButton){
        let indexPath = IndexPath.init(row: btn.tag - 10000, section: 0)
        let cell = self.collectionView.cellForItem(at: indexPath) as! LZAlbumDetailsCell
        let model = self.dataSource[indexPath.row] as! LZVideoModel
        let vc = SCVideoMainViewController.init(url:videoFolder + model.path,videoName: model.name)
        self.present(vc!, animated: true, completion: nil)
    }
    @objc func delTouch(){
        
        
        let alert = FWAlertView.alert(title: LanguageStrins(string: "Tips"), detail: LanguageStrins(string: "Remove photos?"), confirmBlock: { (view, num, str) in
            
            var isbool = true
            
            for (index,itme) in self.dataSource.enumerated(){
                 let model:LZVideoModel = itme as! LZVideoModel
                if model.isSelect {
                    LZFileManager.deleteViodeFile(filePath: model.path)
                    LZFileManager.deleteViodeFile(filePath: model.imagePath)
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
        self.collectionView.reloadDataSmoothly()
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
        cell.loadDataVideoModel(model: self.dataSource[indexPath.row] as! LZVideoModel)
        cell.selectBtn.tag = indexPath.item
        cell.imageView.tag = 3000 + indexPath.item
        cell.selectBtn.addTarget(self, action:#selector(touchBtn(btn:)) , for: .touchUpInside)
        cell.playerBtn.tag = 10000 + indexPath.item
        cell.playerBtn.addTarget(self, action: #selector(playerBtn(btn:)), for: .touchUpInside)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let model = self.dataSource[indexPath.row] as! LZVideoModel
//        let videoUrl = URL.init(fileURLWithPath: videoFolder + model.path)
//        self.videoPlayer.urlAsset = SJVideoPlayerURLAsset.init(url: videoUrl)
//        self.videoPlayer.urlAsset?.title = "ereww"
//        self.videoPlayer.autoManageViewToFitOnScreenOrRotation = true
//        self.videoPlayer.isFitOnScreen = true
//        self.videoPlayer.resumePlaybackWhenAppDidEnterForeground = true
//        self.videoPlayer.rotationManager.rotate()
//        self.videoPlayer.assetDeallocExeBlock = {(videoPlayer) in
//
//        }
//        self.videoPlayer.play()
//        let cell = collectionView.cellForItem(at: indexPath) as! LZAlbumDetailsCell
//        let playModel = SJPlayModel.uiCollectionViewCellPlayModel(withPlayerSuperviewTag: cell.imageView.tag, at: indexPath, collectionView: collectionView)
//        let videoUrl = URL.init(fileURLWithPath: videoFolder + model.path)
//        self.videoPlayer.urlAsset = SJVideoPlayerURLAsset.init(url: videoUrl, specifyStartTime: TimeInterval(model.StartTime), playModel: playModel)
//        self.videoPlayer.urlAsset?.title = model.name
    
        self.indexPaths = indexPath

    }

    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        if self.isHidden == false {
            return self.paths.count
        }
          return self.dataSource.count
      }

      func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        
         if self.isHidden == false {
            let videoUrl = URL.init(fileURLWithPath: tempVideoPath)
            return videoUrl as QLPreviewItem
         }
          let model = self.dataSource[self.indexPaths.row] as! LZVideoModel
          let videoUrl = URL.init(fileURLWithPath: videoFolder + model.path)
          return videoUrl as QLPreviewItem
    
      }
}

extension LZVideoDetailViewController{
    
    func exportFile(){

        startAnimating(lodingSize,type: loadingType, color: COLOR_4990ED)
        self.paths.removeAll()
    
        for pathModel in self.folderModel!.images {
            let m:LZVideoModel = pathModel 
            if m.isSelect {
                paths.append(videoFolder + m.path)
            }
        }
        if self.paths.count == 0 {
             stopAnimating()
             self.chrysan.show(.plain, message:LanguageStrins(string: "Please select the compressed file"), hideDelay: HIDE_DELAY)
            return
        }
        if SSZipArchive.createZipFile(atPath:tempVideoPath, withFilesAtPaths: paths) {
            print("压缩成功")
            if (rootFileManager.fileExists(atPath: tempVideoPath)) {
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
  
//    @objc func rotated() {
//
//           let orientation = UIDevice.current.orientation
//
//        if (orientation.isLandscape) {
//               print("Switched to landscape")
//           }
//        else if(orientation.isPortrait) {
//               print("Switched to portrait")
//           }
//
//           //Always fill entire screen
//           self.movieView.frame = self.view.frame
//
//       }

       @objc func movieViewTapped(_ sender: UITapGestureRecognizer) {

        if mediaPlayer!.isPlaying {
            mediaPlayer!.pause()

            let remaining = mediaPlayer?.remainingTime
            let time = mediaPlayer!.time

               print("Paused at \(time?.stringValue ?? "nil") with \(remaining?.stringValue ?? "nil") time remaining")
           }
           else {
            mediaPlayer!.play()
               print("Playing")
           }
           
       }
}
