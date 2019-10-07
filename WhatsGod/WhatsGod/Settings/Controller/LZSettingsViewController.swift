//
//  LZSettingsViewController.swift
//  WhatsGod
//
//  Created by imac on 9/21/19.
//  Copyright © 2019 L. All rights reserved.
//

import UIKit

class LZSettingsViewController: LZBaseViewController,UITableViewDataSource,UITableViewDelegate {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func readyView() {
        
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.left.top.bottom.right.equalTo(0)
        }
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell.init()
    }
    
}
