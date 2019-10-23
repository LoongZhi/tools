//
//  LZSettingsViewController.swift
//  WhatsGod
//
//  Created by imac on 9/21/19.
//  Copyright © 2019 L. All rights reserved.
//

import UIKit
import Charts
import Foundation

class LZSettingsViewController: LZBaseViewController,UITableViewDataSource,UITableViewDelegate {

    lazy var tapView:UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 200))
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func readyView() {
        
//        self.view.addSubview(self.tableView)
//        self.tableView.snp.makeConstraints { (make) in
//            make.left.top.bottom.right.equalTo(0)
//        }
        let arr:Array<Double> = [Double((totalRAM() - availableRAM()) / (1024 * 1024 * 1024)),Double(availableRAM() / (1024 * 1024 * 1024))]
//        let ys1 = arr.map { x in return sin(Double(x) / 2.0 / 3.141 * 1.5) * 100.0 }
               
               let yse1 = arr.enumerated().map { x, y in return PieChartDataEntry(value: y, label: String(x) + " GB") }
               
               let data = PieChartData()
               let ds1 = PieChartDataSet(entries: yse1, label: "Hello")
               
               ds1.colors = ChartColorTemplates.vordiplom()
               
               data.addDataSet(ds1)
               
               let paragraphStyle: NSMutableParagraphStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
               paragraphStyle.lineBreakMode = .byTruncatingTail
               paragraphStyle.alignment = .center
               let centerText: NSMutableAttributedString = NSMutableAttributedString(string: String(totalRAM() / (1024 * 1024 * 1024)) + " GB")
               
              
        
        let view = PieChartView.init(frame: self.tapView.frame)
        view.backgroundColor = .orange
        self.view.addSubview(view)
        
        view.centerAttributedText = centerText
                      
                      view.data = data
                      
                      view.chartDescription?.text = "Piechart Demo"
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell.init()
    }
    
}
