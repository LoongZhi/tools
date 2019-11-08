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
        
        self.dataSource.append(contentsOf: [["zhanghaoanquan",LanguageStrins(string: "Account number settings")],
        ["beifens",LanguageStrins(string: "Share application")],
        ["yuyan",LanguageStrins(string: "Language settings")],
        ["beifen",LanguageStrins(string: "Document backup")],
        ["qinglihuanchun",LanguageStrins(string: "Clean up the cache")],
        ["guanyuwomen",LanguageStrins(string: "About us")]])
        
    }
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setAoutLayot()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseIdentifier = "LZSettingsCell"
        let cell:LZSettingsCell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier,for: indexPath) as! LZSettingsCell
        
        let arr:Array = self.dataSource[indexPath.row] as! Array<String>
        cell.layoutUI(arr: arr)

        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = LZAccountViewController(nibName: "LZAccountViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
}

extension LZSettingsViewController{
    
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
             
             self.progressView!.setProgress(Int(avai / total * 100), animated: true)
             self.diskLabel.animate(fromValue: 0.0, toValue: avai / total * 100 ,str: "%", duration: 0.55)
            self.textLabel3.animate(fromValue: 0, toValue: Double(LZFileManager.fileSizeAtPath(path: albumsFolder) ), str: "MB", duration: 0.55)
            self.textLabel4.animate(fromValue: 0, toValue: Double(LZFileManager.fileSizeAtPath(path: rootFolder + "VideoFolder") ), str: "MB", duration: 0.55)
            self.textLabel5.animate(fromValue: 0, toValue: Double(LZFileManager.fileSizeAtPath(path: officeFolder)), str: "MB", duration: 0.55)
       
         })
        
        self.textLabel1.text = LanguageStrins(string: "Disk space.")
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
