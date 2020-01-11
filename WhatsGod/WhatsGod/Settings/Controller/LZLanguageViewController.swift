//
//  LZLanguageViewController.swift
//  WhatsGod
//
//  Created by imac on 10/29/19.
//  Copyright © 2019 L. All rights reserved.
//

import UIKit

class LZLanguageViewController: LZBaseViewController,UITableViewDataSource,UITableViewDelegate {
        

    let languageArr:Array = [LanguageStrins(string: "English"),LanguageStrins(string: "Chinese"),LanguageStrins(string: "Japanese"),LanguageStrins(string: "French"),LanguageStrins(string: "Korean"),LanguageStrins(string: "Russian"),LanguageStrins(string: "Arabic")]
    let languageNumber:Array = ["en","zh-Hans","ja","fr","ko","ru-BY","ar"]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.register(UINib.init(nibName: "LZLanguageCell", bundle: nil), forCellReuseIdentifier: "LZLanguageCell")
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.reloadDataSmoothly()
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.languageArr.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseIdentifier = "LZLanguageCell"
        let cell:LZLanguageCell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier,for: indexPath) as! LZLanguageCell
        cell.nameLabel.text = languageArr[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        UserDefaults.standard.set(self.languageNumber[indexPath.row], forKey: languageMark)
         let tabBarController = LZBaseTabBarController()
        UIApplication.shared.keyWindow?.rootViewController = tabBarController;
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50
    }
}
