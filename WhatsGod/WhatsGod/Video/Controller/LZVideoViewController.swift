//
//  LZVideoViewController.swift
//  WhatsGod
//
//  Created by imac on 9/21/19.
//  Copyright © 2019 L. All rights reserved.
//

import UIKit
import FWPopupView
class LZVideoViewController: LZBaseViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
   
    

    var  menuView:FWMenuView? = nil
    var  isHidden:Bool = true
    let images = [UIImage(named: "right_menu_multichat_white"),
                  UIImage(named: "right_menu_addFri_white"),]
 
    private lazy var collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        layout.itemSize = CGSize.init(width: SCREEN_WIDTH / 4, height: 80)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        let collection = UICollectionView.init(frame: self.view.bounds, collectionViewLayout: layout)
        collection.dataSource = self
        collection.delegate = self
        collection.backgroundColor = UIColor.white
        return collection;
    }()
    
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
    }
    @objc override func readyView(){
        
        let itme = UIBarButtonItem.init(image: Img(url: "mqz_nav_add"), style: .done, target: self, action:  #selector(rightItmeEvent));
        self.navigationItem.rightBarButtonItem = itme;
        
       
        self.collectionView.register(LZAlbumCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "LZAlbumCollectionViewCell")
        self.view.addSubview(self.collectionView)
        
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
        
       
        self.menuView = FWMenuView.menu(itemTitles: [LanguageStrins(string: "New"),LanguageStrins(string: "Edit")], itemImageNames:images as! [UIImage], itemBlock: { (popupView, index, title) in
            print("Menu：点击了第\(index)个按钮")
            
            switch (index) {
            case 0:
       
                       let alertController = UIAlertController(title: LanguageStrins(string: "New Folders"),message:LanguageStrins(string: "Please enter the filename"),preferredStyle: .alert)

                           // 輸入框
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
                                                    
                                let albumModel = LZVideoFolderModel()
                                albumModel.finderName = acc.text!
                                albumModel.createDate = Date().timeIntervalSince1970
                                albumModel.path = LZFileManager.createVideoSubFolder(SubPath: acc.text! + String(format: "%.0f", albumModel.createDate))
                               
                                try! realm.write {
                                  realm.add(albumModel)
                                  self.getDataSource()
                                }
                            }
                          alertController.addAction(okAction)
                          self.present(alertController,animated: true,completion: nil)
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
    }
    
    private func getDataSource(){
        
        if self.dataSource.count != 0 {
            self.dataSource.removeAll()
        }
        let models = realm.objects(LZVideoFolderModel.self)
        for albumModel in models {
            self.dataSource.append(albumModel)
        }
        self.collectionView .reloadData()
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
            let model:LZAlbumModel = value as! LZAlbumModel
            
            try! realm.write {
                model.isHidden = hidden
                self.dataSource[index] = model
                
            }
            
        }
        
        self.collectionView.reloadData()
    }
    
    @objc func delBtn(btn:UIButton){
        
        let alert = FWAlertView.alert(title: LanguageStrins(string: "Tips"), detail: LanguageStrins(string: "Whether you delete the folder"), confirmBlock: { (view, number, str) in
            if self.dataSource.count != 0{
                try! realm.write {
                    let model:LZAlbumModel = self.dataSource[btn.tag] as! LZAlbumModel
                    if LZFileManager.deleteImageFile(filePath: model.path){
                        realm.delete(model)
                        self.getDataSource()
                        self.collectionView.reloadData()
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
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = self.dataSource[indexPath.row] as! LZVideoFolderModel
        
        let vc = LZVideoDetailViewController()
        vc.folderModel = model
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
