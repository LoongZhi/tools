//
//  ExtensionTableView.swift
//  WhatsGod
//
//  Created by mj on 1/4/20.
//  Copyright © 2020 L. All rights reserved.
//

import UIKit
extension UITableView {
  func reloadDataSmoothly() {
    UIView.setAnimationsEnabled(false)
    CATransaction.begin()

    CATransaction.setCompletionBlock { () -> Void in
      UIView.setAnimationsEnabled(true)
    }

    reloadData()
    beginUpdates()
    endUpdates()

    CATransaction.commit()
  }
}
