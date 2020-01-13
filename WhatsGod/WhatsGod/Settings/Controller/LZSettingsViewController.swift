//
//  LZSettingsViewController.swift
//  WhatsGod
//
//  Created by imac on 9/21/19.
//  Copyright © 2019 L. All rights reserved.
//

import UIKit

class LZSettingsViewController: LZBaseViewController,UITableViewDataSource,UITableViewDelegate {
    var progressView:OProgressView?
    lazy var tapView:UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 260))
        return view
    }()
    lazy var diskLabel:ContentLabel = {
        let label = ContentLabel.init()
        label.textColor = COLOR_4990ED
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 30)
        return label
    }()
    lazy var diskTitleLabel:UILabel = {
           let label = UILabel.init()
           label.textColor = COLOR_4990ED
           label.textAlignment = .center
           label.font = UIFont.systemFont(ofSize: 15)
           return label
       }()
    lazy var textLabel1:UILabel = {
        let label = UILabel.init()
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    lazy var textLabel2:ContentLabel = {
        let label = ContentLabel.init()
        label.textColor = COLOR_B8B8B8
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    lazy var textLabel3:ContentLabel = {
        let label = ContentLabel.init()
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    lazy var textLabel4:ContentLabel = {
        let label = ContentLabel.init()
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    lazy var textLabel5:ContentLabel = {
        let label = ContentLabel.init()
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    lazy var textLabel6:UILabel = {
        let label = UILabel.init()
        label.textColor = COLOR_B8B8B8
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    lazy var textLabel7:UILabel = {
        let label = UILabel.init()
        label.textColor = COLOR_B8B8B8
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    lazy var textLabel8:UILabel = {
        let label = UILabel.init()
        label.textColor = COLOR_B8B8B8
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    lazy var bottomView:UIView = {
        let view = UIView.init()
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func readyView() {
        
        self.dataSource.append(contentsOf: [["zhanghaoanquan",LanguageStrins(string: "Privacy protection")],
        ["beifens",LanguageStrins(string: "Share application")],
        ["yuyan",LanguageStrins(string: "Language settings")],
        ["beifen",LanguageStrins(string: "Document backup")],
        ["qinglihuanchun",LanguageStrins(string: "Clean up the cache")] ])
        
    }
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setAoutLayot()
    }
    @objc func swEvent(sw:UISwitch){
     
        let sb = UIStoryboard.init(name: "Main", bundle: nil)
        let vc:LZPassViewController = sb.instantiateViewController(withIdentifier: "LZPassViewController") as! LZPassViewController
        vc.onSw = sw.isOn
        vc.isblock = { (isbool) -> Void in
            sw.isOn = isbool
        }
        self.present(vc, animated: true, completion: nil)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseIdentifier = "LZSettingsCell"
        let cell:LZSettingsCell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier,for: indexPath) as! LZSettingsCell
        cell.rightImage.isHidden = false
        cell.sw.isHidden = true
        if indexPath.row == 0 {
            cell.rightImage.isHidden = true
            cell.sw.isHidden = false
            cell.sw.isOn = (UserDefaults.standard.object(forKey: VCPassword) != nil)
            cell.sw.addTarget(self, action: #selector(swEvent(sw:)), for: .valueChanged)
        }
        cell.rightLabel.text = ""
        if indexPath.row == 4 {
            cell.rightLabel.text = "\(fileSizeOfCache())MB"
        }
        let arr:Array = self.dataSource[indexPath.row] as! Array<String>
        cell.layoutUI(arr: arr,index:indexPath)

        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 1:
            self.shareApp()
            break
        case 2:
            let vc = LZLanguageViewController(nibName: "LZLanguageViewController", bundle: nil)
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 3:
            
            //弹出消息框
            let alertController = UIAlertController(title: LanguageStrins(string: "Do you want to export all files?"),
                                                    message: nil, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: LanguageStrins(string: "Cancel"), style: .cancel, handler: nil)
            let okAction = UIAlertAction(title: LanguageStrins(string: "OK"), style: .default,
                                         handler: {
                                            action in
               checkPermissions(resource:{isbool in
                    if isbool{
                        self.exportFile()
                    }
               })
            })
            alertController.addAction(cancelAction)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            break
        case 4:
            let alertController = UIAlertController(title: LanguageStrins(string: "Do you clear the application cache?"),
                                                    message: nil, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: LanguageStrins(string: "Cancel"), style: .cancel, handler: nil)
            let okAction = UIAlertAction(title: LanguageStrins(string: "OK"), style: .default,
                                         handler: {
                                            action in
               checkPermissions(resource:{isbool in
                    if isbool{
                        clearCache()
                        tableView.reloadDataSmoothly()
                    }
               })
            })
            alertController.addAction(cancelAction)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            break
        default: break
            
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
}

extension LZSettingsViewController{
    func shareApp(){
        weak var wekeSelf = self
        let urlString = URL.init(string: "https://apps.apple.com/us/app/appname/id1494285037?action=write-review")
        //弹出消息框
        let alertController = UIAlertController(title: LanguageStrins(string: "If it feels easy to use, share it with friends!"),
                                                message: nil, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: LanguageStrins(string: "Cancel"), style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: LanguageStrins(string: "OK"), style: .default,
                                     handler: {
                                        action in
            let items = [urlString] as [Any]
             let activityVC = UIActivityViewController(
                 activityItems: items,
                 applicationActivities: nil)
            activityVC.completionWithItemsHandler =  { activity, success, items, error in
                
                DispatchQueue.main.async {
                    if success {
                        wekeSelf!.chrysan.show(.plain, message:LanguageStrins(string: "Share success"), hideDelay: HIDE_DELAY)
                    } else{
                        wekeSelf!.chrysan.show(.plain,message:LanguageStrins(string: "Share failed"),hideDelay: HIDE_DELAY)
                    }
                }
             }
            wekeSelf!.present(activityVC, animated: true, completion: { () -> Void in})
        })
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    func exportFile(){
         
            weak var wekeSelf = self
          
          
             let queue = DispatchQueue(label: "queueName", attributes: .concurrent)
            
                queue.async {
                    
                    SSZipArchive.createZipFile(atPath: tempAllDataPath, withContentsOfDirectory: rootFolder, keepParentDirectory: false, withPassword: nil, andProgressHandler:{(t1:UInt?,t2:UInt?) -> Void in
                            DispatchQueue.main.async {
                                LZPercentProgressView.shared().startProgress(avaiNumber: CGFloat(t1!), totalNumber: CGFloat(t2!))
                            }
                        }
                        
                    )
                }

            DispatchGroup.init().notify(qos: .default, flags: .barrier, queue: queue) {
                DispatchQueue.main.async {
                    if (rootFileManager.fileExists(atPath: rootFolder)) {
                        let items = [URL.init(fileURLWithPath: rootFolder) as Any] as [Any]
                         let activityVC = UIActivityViewController(
                             activityItems: items,
                             applicationActivities: nil)
                        activityVC.completionWithItemsHandler =  { activity, success, items, error in
                            
                            DispatchQueue.main.async {
                                if success {
                                    wekeSelf!.chrysan.show(.plain, message:LanguageStrins(string: "Share success"), hideDelay: HIDE_DELAY)
                                } else{
                                    wekeSelf!.chrysan.show(.plain,message:LanguageStrins(string: "Share failed"),hideDelay: HIDE_DELAY)
                                }
                            }
                         }
                        wekeSelf!.present(activityVC, animated: true, completion: { () -> Void in})
                    }else{
                        print("压缩失败")
                        wekeSelf!.chrysan.show(.plain, message:LanguageStrins(string: "Compression failed"), hideDelay: HIDE_DELAY)
                    }
                    LZPercentProgressView.shared().stopProgress()
                }
            }
            
           
        }
    func  setAoutLayot(){
        
        self.tableView.tableHeaderView = self.tapView
        self.tableView.register(LZSettingsCell.classForCoder(), forCellReuseIdentifier: "LZSettingsCell")
         self.view.addSubview(self.tableView)
         self.tableView.snp.makeConstraints { (make) in
             make.left.top.bottom.right.equalTo(0)
         }
         let total = totalRAM() / (1024 * 1024 * 1024)
         let avai = (totalRAM() - availableRAM()) / (1024 * 1024 * 1024)
         self.progressView = OProgressView.init(frame: CGRect.init(x: SCREEN_WIDTH / 2 - 60, y: 20, width: 120, height: 120))
         self.tapView.addSubview(self.progressView!)

        self.progressView!.addSubview(self.diskLabel)
        self.progressView!.addSubview(self.diskTitleLabel)
        self.diskLabel.snp.makeConstraints { (make) in
           
            make.top.equalToSuperview().offset(35)
            make.height.equalTo(35)
            make.left.equalTo(10)
            make.right.equalTo(-10)
        }
        
        self.diskTitleLabel.snp.makeConstraints { (make) in
            make.height.equalTo(20)
            make.top.equalTo(self.diskLabel.snp_bottom).offset(0)
            make.left.equalTo(10)
            make.right.equalTo(-10)
        }
        self.diskLabel.text = "0%"
        self.diskTitleLabel.text = LanguageStrins(string: "Used")
         DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute:
         {
             
            self.progressView!.setProgress(CGFloat(Int(avai / total * 100)), animated: true)
             self.diskLabel.animate(fromValue: 0.0, toValue: avai / total * 100 ,str: "%", duration: 0.55)
            self.textLabel3.animate(fromValue: 0, toValue: Double(LZFileManager.fileSizeAtPath(path: albumsFolder) ), str: "MB", duration: 0.55)
            self.textLabel4.animate(fromValue: 0, toValue: Double(LZFileManager.fileSizeAtPath(path: rootFolder + "VideoFolder") ), str: "MB", duration: 0.55)
            self.textLabel5.animate(fromValue: 0, toValue: Double(LZFileManager.fileSizeAtPath(path: officeFolder)), str: "MB", duration: 0.55)
       
         })
        
        self.textLabel1.text = LanguageStrins(string: "Disk space")
        self.textLabel2.text = "\(Int(total - avai))GB / " + "\(Int(total))GB"
     
        self.textLabel6.text = LanguageStrins(string: "Album")
        self.textLabel7.text = LanguageStrins(string: "Video")
        self.textLabel8.text = LanguageStrins(string: "Other")
        self.tapView.addSubview(self.textLabel1)
        self.tapView.addSubview(self.textLabel2)
        self.tapView.addSubview(self.bottomView)
        self.bottomView.addSubview(self.textLabel3)
        self.bottomView.addSubview(self.textLabel4)
        self.bottomView.addSubview(self.textLabel5)
        self.bottomView.addSubview(self.textLabel6)
        self.bottomView.addSubview(self.textLabel7)
        self.bottomView.addSubview(self.textLabel8)
        self.textLabel1.snp.makeConstraints { (make) in
                  
            make.top.equalTo(self.progressView!.snp_bottom).offset(5)
            make.height.equalTo(20)
            make.left.equalTo(10)
            make.right.equalTo(-10)
        }
        self.textLabel2.snp.makeConstraints { (make) in
            make.top.equalTo(self.textLabel1.snp_bottom).offset(5)
            make.height.equalTo(15)
            make.left.equalTo(10)
            make.right.equalTo(-10)
        }
        self.bottomView.snp.makeConstraints { (make) in
            make.bottom.equalTo(0)
            make.top.equalTo(self.textLabel2.snp_bottom).offset(10)
            make.left.equalTo(0)
            make.right.equalTo(0)
        }
        
        self.textLabel4.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }

        self.textLabel3.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.textLabel4)
            make.left.equalTo(10)
            make.height.equalTo(25)
            make.right.equalTo(self.textLabel4.snp_left).offset(-10)
        }
        
        self.textLabel5.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.textLabel4)
            make.right.equalTo(-10)
            make.height.equalTo(25)
            make.left.equalTo(self.textLabel4.snp_right).offset(10)
        }
        
        self.textLabel7.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.textLabel4).offset(-5)
        }

        self.textLabel6.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.textLabel7)
            make.left.equalTo(10)
            make.height.equalTo(25)
            make.right.equalTo(self.textLabel7.snp_left).offset(-10)
             make.top.equalTo(self.textLabel3.snp_bottom).offset(-5)
        }

        self.textLabel8.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.textLabel7)
            make.right.equalTo(-10)
            make.height.equalTo(25)
            make.left.equalTo(self.textLabel7.snp_right).offset(10)
             make.top.equalTo(self.textLabel5.snp_bottom).offset(-5)
        }
    }
}
