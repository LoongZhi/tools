//
//  ExtensionCollection.swift
//  WhatsGod
//
//  Created by mj on 1/4/20.
//  Copyright © 2020 L. All rights reserved.
//

import UIKit
extension UICollectionView {
  func reloadDataSmoothly() {

    UIView.performWithoutAnimation {
        reloadData()
    }
  }
}
