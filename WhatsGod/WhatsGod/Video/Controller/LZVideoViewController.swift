//
//  LZVideoViewController.swift
//  WhatsGod
//
//  Created by imac on 9/21/19.
//  Copyright © 2019 L. All rights reserved.
//

import UIKit
import FWPopupView
import AVFoundation
import AVKit

class LZVideoViewController: LZBaseViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
   
    

    var  menuView:FWMenuView? = nil
    var  isHidden:Bool = true
    let images = [UIImage(named: "right_menu_multichat_white"),
                  UIImage(named: "right_menu_addFri_white"),
                  UIImage(named: "right_menu_addFri_white"),]
    public var fileType:FileType?
    public var fileUrl:String?
    var indexPath: IndexPath?
    var targetIndexPath: IndexPath?
       
    private lazy var dragingItem: LZAlbumCollectionViewCell = {
        let cell = LZAlbumCollectionViewCell(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH / 4, height: 80))
           
         cell.loadData(model: self.dataSource[indexPath!.row] as! LZVideoFolderModel)
         cell.delBtn.tag = indexPath!.row
         cell.delBtn.addTarget(self, action: #selector(delBtn(btn:)), for: .touchUpInside)
        return cell
    }()
    private lazy var collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        layout.itemSize = CGSize(width: SCREEN_WIDTH / 4, height: 80)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        layout.headerReferenceSize = CGSize(width: SCREEN_WIDTH, height: 50)
        let collection = UICollectionView.init(frame: self.view.bounds, collectionViewLayout: layout)
        loadAD()
        collection.addSubview(bannerView)
        let emptyView = LYEmptyView.emptyActionView(withImageStr: "k01", titleStr: LanguageStrins(string: "Folder manager is empty"), detailStr: LanguageStrins(string: "Create a folder to manage your photos ~"), btnTitleStr: LanguageStrins(string: "New")) {
            self.newFolder()
        };
        emptyView!.actionBtnBackGroundColor = COLOR_4990ED
        emptyView!.actionBtnTitleColor = .white
        emptyView!.actionBtnCornerRadius = 5
        emptyView!.contentViewY = lzNavigationHeight + 50
        collection.ly_emptyView = emptyView
        collection.dataSource = self
        collection.delegate = self
        collection.backgroundColor = UIColor.white
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(self.longPressGesture(_:)))
        collection.addGestureRecognizer(longPress)
        return collection;
    }()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getDataSource()
    }
//    let menuView
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        readyView()
        
        if self.dataSource.count != 0{
            let model:LZVideoFolderModel = self.dataSource.first as! LZVideoFolderModel
            if !model.isHidden{
                let itme = UIBarButtonItem.init(title: LanguageStrins(string: "Completed"), style: .done, target: self, action: #selector(self.leftItmeEvent))
                self.navigationItem.leftBarButtonItem = itme
                self.isHidden = false
            }
        }
        
        if (self.fileType != nil) {
            let itme = UIBarButtonItem.init(title: LanguageStrins(string: "Return"), style: .done, target: self, action: #selector(self.navBack))
             self.navigationItem.leftBarButtonItem = itme
            if self.dataSource.count != 0{
                self.chrysan.show(.plain, message:LanguageStrins(string: "Please select the folder."), hideDelay: HIDE_DELAY)
            }else{
                 self.chrysan.show(.plain, message:LanguageStrins(string: "Please create a folder first."), hideDelay: HIDE_DELAY)
            }
        }
    }
    @objc override func readyView(){
        
        let itme = UIBarButtonItem.init(image: Img(url: "mqz_nav_add"), style: .done, target: self, action:  #selector(rightItmeEvent));
        self.navigationItem.rightBarButtonItem = itme;
        
       
        self.collectionView.register(LZAlbumCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "LZAlbumCollectionViewCell")
        self.view.addSubview(self.collectionView)
        
        
        
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
        
       
        self.menuView = FWMenuView.menu(itemTitles: [LanguageStrins(string: "New"),LanguageStrins(string: "Export"),LanguageStrins(string: "Edit")], itemImageNames:(images as! [UIImage]), itemBlock: {[weak self] (popupView, index, title) in
            print("Menu：点击了第\(index)个按钮")
            
            switch (index) {
            case 0:
                self!.newFolder()
                break;
            case 1:
                self!.exportFile()
                break;
            case 2:
                let itme = UIBarButtonItem.init(title: LanguageStrins(string: "Completed"), style: .done, target: self, action: #selector(self!.leftItmeEvent))
                self!.navigationItem.leftBarButtonItem = itme
                self!.isHidden = false
                self!.setHidden(hidden: self!.isHidden)
                break;
            default:
                break;
            }
        }, property: vProperty)
    }
    func newFolder(){
       
        let alertController = UIAlertController(title: LanguageStrins(string: "New Folders"),message:LanguageStrins(string: "Please enter the filename"),preferredStyle: .alert)

                   // 輸入框
               alertController.addTextField {
                       (textField: UITextField!) -> Void in
                       textField.placeholder = LanguageStrins(string: "Please enter the filename")
               }
        let cancelAction = UIAlertAction(title: LanguageStrins(string: "Cancel"),style: .cancel,handler: nil)
                  alertController.addAction(cancelAction)

              
                  let okAction = UIAlertAction(title: LanguageStrins(string: "OK"),style: UIAlertAction.Style.default) { [weak self]
                      (action: UIAlertAction!) -> Void in
                    let acc:UITextField =
                        (alertController.textFields?.first)!
                          as UITextField
                        if acc.text!.isStringNull() {
                                
                            self!.chrysan.show(.plain, message:LanguageStrins(string: "Please enter the filename"), hideDelay: HIDE_DELAY)
                                                                                                   
                            return
                                                
                        }
                                            
                        let albumModel = LZVideoFolderModel()
                        albumModel.finderName = acc.text!
                        albumModel.createDate = Date().timeIntervalSince1970
                        albumModel.index = realm.objects(LZVideoFolderModel.self).count
                        albumModel.path = LZFileManager.createVideoSubFolder(SubPath: acc.text! + String(format: "%.0f", albumModel.createDate))
                       
                        try! realm.write {
                          realm.add(albumModel)
                            self!.getDataSource()
                        }
                    }
                  alertController.addAction(okAction)
               self.present(alertController,animated: true,completion: nil)
    }
    private func getDataSource(){
        
        if self.dataSource.count != 0 {
            self.dataSource.removeAll()
        }
        let models = realm.objects(LZVideoFolderModel.self).sorted(byKeyPath: "index")
        for albumModel in models {
            self.dataSource.append(albumModel)
        }
        self.collectionView.reloadDataSmoothly()
    }
    override func rightItmeEvent(){
        
        
        self.menuView?.show()

    }
    
    override func leftItmeEvent() {
        self.isHidden = true
        self.setHidden(hidden: self.isHidden)
        self.navigationItem.leftBarButtonItem = nil
    }
   
    private func setHidden(hidden:Bool){
        
        if self.dataSource.count == 0 {
            return
        }
        for (index,value) in self.dataSource.enumerated() {
            let model:LZVideoFolderModel = value as! LZVideoFolderModel
            
            try! realm.write {
                model.isHidden = hidden
                self.dataSource[index] = model
                
            }
            
        }
        self.collectionView.reloadDataSmoothly()
    }
    
    @objc func delBtn(btn:UIButton){
        
        let alert = FWAlertView.alert(title: LanguageStrins(string: "Tips"), detail: LanguageStrins(string: "Whether you delete the folder"), confirmBlock: { (view, number, str) in
            if self.dataSource.count != 0{
                try! realm.write {
                    let model:LZVideoFolderModel = self.dataSource[btn.tag] as! LZVideoFolderModel
                    if LZFileManager.deleteViodeFile(filePath: model.path){
                        realm.delete(model)
                        self.getDataSource()
                        self.collectionView.reloadDataSmoothly()
                        self.chrysan.show(.plain, message:LanguageStrins(string: "Delete success."), hideDelay: HIDE_DELAY)
                    }else{
                         self.chrysan.show(.plain, message:LanguageStrins(string: "Delete failure."), hideDelay: HIDE_DELAY)
                    }
                    
                   
                }
               
            }
        }) { (view, number, str) in
            
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
        
        let reuseIdentifier = "LZAlbumCollectionViewCell"
        let cell:LZAlbumCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! LZAlbumCollectionViewCell
        
        cell.loadData(model: self.dataSource[indexPath.row] as! LZVideoFolderModel)
        cell.delBtn.tag = indexPath.row
        cell.delBtn.addTarget(self, action: #selector(delBtn(btn:)), for: .touchUpInside)
        self.perform(#selector(runloopAnimCell(cell:)), with: cell, afterDelay: 0.0, inModes: [.common])
        
        return cell
    }
    @objc func runloopAnimCell(cell:LZAlbumCollectionViewCell){
        if !self.isHidden {
            
           
            cell.layer.add(cell.anim, forKey: "SpringboardShake")
        }else {
            cell.layer.removeAllAnimations()
            
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
        let model = self.dataSource[indexPath.row] as! LZVideoFolderModel
        if self.isHidden == false {
            self.indexPath = indexPath
            var pass = LanguageStrins(string: "Modify the password")
            if model.password.isStringNull() {
                pass = LanguageStrins(string: "Add a password")
            }
            let sheerView = FWSheetView.sheet(title: LanguageStrins(string: "Tips"), itemTitles: [pass,LanguageStrins(string: "Modify the folder name")], itemBlock: { (FWPopupViews, Ints, Strings) in
                self.changeData(type: Ints)
            }, cancelItemTitle: LanguageStrins(string: "Cancel"), cancenlBlock: {
                
            }, property: nil)
            sheerView.show()
            return
        }
        if (self.fileType != nil) {
            
            self.startAnimating(lodingSize,type: loadingType, color: COLOR_4990ED)
            let type = fileUrl!.returnFileType(fileUrl: fileUrl!)
            let path = model.path + "/Video" + String(format: "%d.%@",(fileUrl?.components(separatedBy: "/").last)!,type)
            let ImagePath = model.path + "/Thumb" + String(format: "%d.jpg",Date().timeIntervalSince1970)

            guard let jsonData = try? Data.init(contentsOf: URL.init(string: fileUrl!)!, options: Data.ReadingOptions.alwaysMapped) else {
                self.stopAnimating()
                 return
            }
            if LZFileManager.writeVideoFile(filePath: path, data:jsonData){
             
                
                 let imgData:Data = getVideoFengMian(url: URL.init(fileURLWithPath: fileUrl!)).jpegData(compressionQuality: 1)!
                 if LZFileManager.writeVideoFile(filePath: ImagePath, data:imgData){
                     print("写入成功")
                 }else{
                     print("写入失败")
                 }
                let urlAsset:AVURLAsset = AVURLAsset.init(url: URL.init(fileURLWithPath: fileUrl!), options: nil);
                
                 let videoModel = LZVideoModel.init()
                     videoModel.isHidden = self.isHidden
                     videoModel.path = path
                     videoModel.type = type
                    videoModel.name = (fileUrl?.components(separatedBy: "/").last)!
                         videoModel.imagePath = ImagePath
                    videoModel.timerscale = Int(urlAsset.duration.seconds)
                                                                   
                    videoModel.timer = String.init().transToHourMinSecs(time:videoModel.timerscale)
                     try! realm.write {

                     model.images.append(videoModel)
                     self.chrysan.show(.plain, message:LanguageStrins(string: "Save success"), hideDelay: HIDE_DELAY)
                 }
             
             }
              DispatchQueue.main.asyncAfter(deadline: .now()+HIDE_DELAY, execute:
                          {
                                self.stopAnimating()
                                self.getDataSource()
                               self.dismiss(animated: true, completion: nil)
                          })
            return
        }
       
        if !model.password.isStringNull() {
                  
                   let alertController = UIAlertController(title: LanguageStrins(string:"Tips"),message:LanguageStrins(string: "Please enter the private folder password."),preferredStyle: .alert)
                   alertController.addTextField {
                           (textField: UITextField!) -> Void in
                           textField.placeholder = LanguageStrins(string: "Please enter the password")
                            textField.keyboardType = .numberPad
                            textField.isSecureTextEntry = true
                   }
                   let cancelAction = UIAlertAction(title: LanguageStrins(string: "Cancel"),style: .cancel,handler: nil)
                   alertController.addAction(cancelAction)
                   let okAction = UIAlertAction(title: LanguageStrins(string: "OK"),style: UIAlertAction.Style.default) {
                     [weak self](action: UIAlertAction!) -> Void in
                           let acc:UITextField =
                               (alertController.textFields?.first)!
                                 as UITextField
                           if acc.text == model.password {
                               let vc = LZVideoDetailViewController()
                               vc.folderModel = model
                               self?.navigationController?.pushViewController(vc, animated: true)
                           }else{
                               self!.chrysan.show(.plain, message:LanguageStrins(string: "Please enter the correct password"), hideDelay: HIDE_DELAY)
                               return
                           }
                   }
                   alertController.addAction(okAction)
                   self.present(alertController,animated: true,completion: nil)
               }else{
                  let vc = LZVideoDetailViewController()
                   vc.folderModel = model
                   self.navigationController?.pushViewController(vc, animated: true)
               }
    }

   
    
    //MARK: - 长按动作
       @objc func longPressGesture(_ tap: UILongPressGestureRecognizer) {
              
              if self.isHidden {

                  return
              }
              let point = tap.location(in: collectionView)
              
              switch tap.state {
                  case UIGestureRecognizerState.began:
                      dragBegan(point: point)
                  case UIGestureRecognizerState.changed:
                      drageChanged(point: point)
                  case UIGestureRecognizerState.ended:
                      drageEnded(point: point)
                  case UIGestureRecognizerState.cancelled:
                      drageEnded(point: point)
                  default: break
                  
              }
              
          }
       //MARK: - 长按开始
       private func dragBegan(point: CGPoint) {
           
           
           
           indexPath = collectionView.indexPathForItem(at: point)
           if indexPath == nil || (indexPath?.section)! > 0
           {return}
           
           let item = collectionView.cellForItem(at: indexPath!) as? LZAlbumCollectionViewCell
         
           dragingItem.frame = (item?.frame)!
         
           dragingItem.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
       }
       //MARK: - 长按过程
       private func drageChanged(point: CGPoint) {
           if indexPath == nil || (indexPath?.section)! > 0
           {return}
           dragingItem.center = point
           targetIndexPath = collectionView.indexPathForItem(at: point)
           if targetIndexPath == nil || (targetIndexPath?.section)! > 0 || indexPath == targetIndexPath {return}
          
           let obj1 = self.dataSource[indexPath!.row] as! LZVideoFolderModel
           let obj2 = self.dataSource[targetIndexPath!.row] as! LZVideoFolderModel
           //交换位置
           collectionView.moveItem(at: indexPath!, to: targetIndexPath!)
           try! realm.write {
               obj1.index = targetIndexPath!.row
               obj2.index = indexPath!.row
           }


           indexPath = targetIndexPath
            self.getDataSource()
       }
       
       //MARK: - 长按结束
       private func drageEnded(point: CGPoint) {
           
           if indexPath == nil || (indexPath?.section)! > 0
           {return}
           let endCell = collectionView.cellForItem(at: indexPath!)
           
           UIView.animate(withDuration: 0.25, animations: {
           
               self.dragingItem.transform = CGAffineTransform.identity
               self.dragingItem.center = (endCell?.center)!
               
           }, completion: {
           
               (finish) -> () in
               
               self.indexPath = nil
               
           })
           
       }
}
extension LZVideoViewController{
    
       private func changeData(type:Int){
               let videoFolder:LZVideoFolderModel = self.dataSource[self.indexPath!.row] as! LZVideoFolderModel
              
              switch type {
              case 0:
                  var message = LanguageStrins(string: "Please enter a six - digit password")
                  var title = LanguageStrins(string: "Set the password")
                  if !videoFolder.password.isStringNull() {
                      message = LanguageStrins(string: "Please enter a new password to be modified")
                      title = LanguageStrins(string: "Change password")
                      let alertController = UIAlertController(title: LanguageStrins(string:"Tips"),message:LanguageStrins(string:"Please enter the private folder password."),preferredStyle: .alert)
                      alertController.addTextField {
                              (textField: UITextField!) -> Void in
                              textField.placeholder = LanguageStrins(string: "Confirm the password")
                               textField.keyboardType = .numberPad
                               textField.isSecureTextEntry = true
                      }
                      let cancelAction = UIAlertAction(title: LanguageStrins(string: "Cancel"),style: .cancel,handler: nil)
                      alertController.addAction(cancelAction)
                      let okAction = UIAlertAction(title: LanguageStrins(string: "OK"),style: UIAlertAction.Style.default) {
                        [weak self](action: UIAlertAction!) -> Void in
                      let acc:UITextField =
                          (alertController.textFields?.first)!
                            as UITextField
                      if acc.text == videoFolder.password {
                              self!.changeAndAddPass(title: title, message: message)
                          }else{
                              self!.chrysan.show(.plain, message:LanguageStrins(string: "Please enter the correct password"), hideDelay: HIDE_DELAY)
                              return
                          }
                      }
                      alertController.addAction(okAction)
                      self.present(alertController,animated: true,completion: nil)
                  }else{
                      self.changeAndAddPass(title: title, message: message)
                  }
                  
                  break
              case 1:
                  let alertController = UIAlertController(title: LanguageStrins(string: "Modify the folder name"),message:LanguageStrins(string: "Please enter the filename"),preferredStyle: .alert)

                            
                         alertController.addTextField {
                                 (textField: UITextField!) -> Void in
                                 textField.placeholder = LanguageStrins(string: "Please enter the filename")
                         }
                  let cancelAction = UIAlertAction(title: LanguageStrins(string: "Cancel"),style: .cancel,handler: nil)
                            alertController.addAction(cancelAction)

                        
                            let okAction = UIAlertAction(title: LanguageStrins(string: "OK"),style: UIAlertAction.Style.default) {
                                (action: UIAlertAction!) -> Void in
                              let acc:UITextField =
                                  (alertController.textFields?.first)!
                                    as UITextField
                                  if acc.text!.isStringNull() {
                                          
                                      self.chrysan.show(.plain, message:LanguageStrins(string: "Please enter the filename"), hideDelay: HIDE_DELAY)
                                                                                                             
                                      return
                                                          
                                  }
                                                      
                              let albumModel:LZAlbumModel = self.dataSource[self.indexPath!.row] as! LZAlbumModel
                                  try! realm.write {
                                      albumModel.finderName = acc.text!
                                    self.getDataSource()
                                  }
                              }
                            alertController.addAction(okAction)
                            self.present(alertController,animated: true,completion: nil)
                  break
              default:
                  break
              }
       
          }
       private func changeAndAddPass(title:String,message:String){
           
           let videoFolder:LZVideoFolderModel = self.dataSource[self.indexPath!.row] as! LZVideoFolderModel
           let alertController = UIAlertController(title: title,message:message,preferredStyle: .alert)

                     
                  alertController.addTextField {
                          (textField: UITextField!) -> Void in
                          textField.placeholder = LanguageStrins(string: "Please enter the password")
                          textField.keyboardType = .numberPad
                          textField.isSecureTextEntry = true
                  }
                  alertController.addTextField {
                          (textField: UITextField!) -> Void in
                          textField.placeholder = LanguageStrins(string: "Confirm the password")
                          textField.keyboardType = .numberPad
                          textField.isSecureTextEntry = true
                  }
           let cancelAction = UIAlertAction(title: LanguageStrins(string: "Cancel"),style: .cancel,handler: nil)
                     alertController.addAction(cancelAction)

                 
                     let okAction = UIAlertAction(title: LanguageStrins(string: "OK"),style: UIAlertAction.Style.default) {
                         (action: UIAlertAction!) -> Void in
                       let acc:UITextField =
                           (alertController.textFields?.first)!
                             as UITextField
                       let acc2:UITextField =
                       (alertController.textFields?.last)!
                         as UITextField
                       if acc.text!.isStringNull() || acc.text!.count < 6 || (acc.text != acc2.text){
                                   
                               self.chrysan.show(.plain, message:LanguageStrins(string: "Please enter your password"), hideDelay: HIDE_DELAY)
                                                                                                      
                               return
                       }
                                               
                           try! realm.write {
                               videoFolder.password = acc.text!
                             self.getDataSource()
                           }
                           if videoFolder.password.isStringNull(){
                               self.chrysan.show(.plain, message:LanguageStrins(string: "Add a password successful"), hideDelay: HIDE_DELAY)
                           }else{
                                self.chrysan.show(.plain, message:LanguageStrins(string: "The password was modified successfully"), hideDelay: HIDE_DELAY)
                           }
                       }
                     alertController.addAction(okAction)
                     self.present(alertController,animated: true,completion: nil)
       }
       
       func exportFile(){
        
        weak var weakSelf = self
      
        if weakSelf!.dataSource.count == 0 {
                 weakSelf!.stopAnimating()
                 weakSelf!.chrysan.show(.plain, message:LanguageStrins(string: "The folder is empty"), hideDelay: HIDE_DELAY)
                return
            }
        let queue = DispatchQueue(label: "queueName", attributes: .concurrent)

        queue.async {
            SSZipArchive.createZipFile(atPath: tempVideoPath, withContentsOfDirectory: videoFolder, keepParentDirectory: false, withPassword: nil, andProgressHandler:{(t1:UInt?,t2:UInt?) -> Void in
                    DispatchQueue.main.async {
                        LZPercentProgressView.shared().startProgress(avaiNumber: CGFloat(t1!), totalNumber: CGFloat(t2!))
                    }
                }
                
            )
        }
        DispatchGroup.init().notify(qos: .default, flags: .barrier, queue: queue) {
            DispatchQueue.main.async {
                if (rootFileManager.fileExists(atPath: tempVideoPath)) {
                        let items = [URL.init(fileURLWithPath: tempVideoPath) as Any] as [Any]
                         let activityVC = UIActivityViewController(
                             activityItems: items,
                             applicationActivities: nil)
                        activityVC.completionWithItemsHandler =  { activity, success, items, error in
                            
                            DispatchQueue.main.async {
                                if success {
                                    weakSelf!.chrysan.show(.plain, message:LanguageStrins(string: "Share success"), hideDelay: HIDE_DELAY)
                                } else{
                                    weakSelf!.chrysan.show(.plain,message:LanguageStrins(string: "Share failed"),hideDelay: HIDE_DELAY)
                                }
                            }
                         }
                        weakSelf!.present(activityVC, animated: true, completion: { () -> Void in})
                }else{
                    print("压缩失败")
                    weakSelf!.chrysan.show(.plain, message:LanguageStrins(string: "Compression failed"), hideDelay: HIDE_DELAY)
                }
                LZPercentProgressView.shared().stopProgress()
            }
            
        }
               
       
    }
}
