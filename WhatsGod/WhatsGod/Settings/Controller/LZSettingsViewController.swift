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
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 300))
        view.backgroundColor = .yellow
        return view
    }()
    lazy var diskLabel:UILabel = {
        let label = UILabel.init()
        label.textColor = COLOE_4990ED
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 35)
        return label
    }()
    lazy var diskTitleLabel:UILabel = {
           let label = UILabel.init()
           label.textColor = COLOE_4990ED
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
    lazy var textLabel2:UILabel = {
        let label = UILabel.init()
        label.textColor = .gray
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    lazy var textLabel3:UILabel = {
        let label = UILabel.init()
        label.textColor = .gray
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    lazy var textLabel4:UILabel = {
        let label = UILabel.init()
        label.textColor = .gray
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    lazy var textLabel5:UILabel = {
        let label = UILabel.init()
        label.textColor = .gray
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    lazy var bottomView:UIView = {
        let view = UIView.init()
        view.backgroundColor = .orange
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func readyView() {
        
        self.setAoutLayot()
    }
   

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell.init()
    }
    
    func  setAoutLayot(){
        
        self.tableView.tableHeaderView = self.tapView
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
      
        var number = 0
         DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute:
         {
             
             self.progressView!.setProgress(Int(avai / total * 100), animated: true)
             self.diskTitleLabel.text = LanguageStrins(string: "Used")

            UIView.animate(withDuration: 1.55) {
                number = Int(availableRAM() / (1024 * 1024 * 1024))
                self.diskLabel.text = "\(number)" + "%"
            }
         })
        
        self.textLabel1.text = LanguageStrins(string: "Disk space.")
        self.textLabel2.text = "\(Int(total - avai)) GB/" + "\(Int(total)) GB"
        self.textLabel3.text = "\(LZFileManager.fileSizeAtPath(path: videoFolder))MB"
        self.textLabel4.text = "\(LZFileManager.fileSizeAtPath(path: albumsFolder))MB"
        self.textLabel5.text = "\(LZFileManager.fileSizeAtPath(path: officeFolder))MB"
        
        self.tapView.addSubview(self.textLabel1)
        self.tapView.addSubview(self.textLabel2)
        self.tapView.addSubview(self.bottomView)
        self.bottomView.addSubview(self.textLabel3)
        self.bottomView.addSubview(self.textLabel4)
        self.bottomView.addSubview(self.textLabel5)
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
    }
}
