//
//  LZAlbumViewController.swift
//  WhatsGod
//
//  Created by imac on 9/21/19.
//  Copyright © 2019 L. All rights reserved.
//

import UIKit
import FWPopupView
class LZAlbumViewController: LZBaseViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
   
    


    let realm = LZRealmTool.lz_realm
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
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        readyView()
        
    }
    private func readyView(){
        
        let itme = UIBarButtonItem.init(title: LanguageStrins(string: "New"), style: .done, target: self, action: #selector(rightItmeEvent));
        self.navigationItem.rightBarButtonItem = itme;
        
        let models = realm.objects(LZAlbumModel.self)
        for albumModel in models {
            self.dataSource.append(albumModel)
        }
//        self.collectionView.register(UINib.init(nibName: "IMCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        self.collectionView.register(LZAlbumCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "LZAlbumCollectionViewCell")
        self.view.addSubview(self.collectionView)
    }
    
    @objc private  func rightItmeEvent(){
        
        let item = FWPopupItem.init(title: LanguageStrins(string: "OK"), itemType: FWItemType.highlight, isCancel: false, canAutoHide: true) { (view, number, str) in
            
            if (str != nil){
                let albumModel = LZAlbumModel()
                albumModel.finderName = str ?? ""
                albumModel.createDate = Date().timeIntervalSince1970
                
                try! self.realm.write {
                    self.realm.add(albumModel)
                }
            }
        };
        let alertView = FWAlertView.alert(title: LanguageStrins(string: "New Folders"), detail: LanguageStrins(string: "New folders are stored in photographs"), inputPlaceholder: LanguageStrins(string: "Please enter the filename"), keyboardType: UIKeyboardType.default, isSecureTextEntry: true, items: [item]);
        alertView.show()
        
        
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
        
        cell.loadData(model: self.dataSource[indexPath.row] as! LZAlbumModel)
        return cell
    }

}

