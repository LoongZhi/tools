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
        view.backgroundColor = .orange
        return view
    }()
    lazy var diskLabel:UILabel = {
        let label = UILabel.init()
        label.textColor = COLOE_4990ED
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        label.backgroundColor = .red
        return label
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
         self.progressView = OProgressView.init(frame: CGRect.init(x: SCREEN_WIDTH / 2 - 60, y: 0, width: 120, height: 160))
         self.tapView.addSubview(self.progressView!)

        
         DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute:
         {
             self.progressView!.setProgress(Int(avai / total * 100), animated: true)
         })
        
        self.tapView.addSubview(self.diskLabel)
        self.diskLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.progressView!.snp_top).offset(-100)
            make.centerY.centerX.equalTo(self.tapView)
            make.height.equalTo(20)
        }
        
        self.diskLabel.text = "\(Int(availableRAM() / (1024 * 1024 * 1024)))" + "%"
    }
}
