//
//  LZBaseNavController.swift
//  WhatsGod
//
//  Created by imac on 9/21/19.
//  Copyright © 2019 L. All rights reserved.
//

import UIKit
let navFont:CGFloat = 18.0

class LZBaseNavController: UINavigationController,UINavigationControllerDelegate {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let textAttrs = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: navFont)]
        self.navigationBar.titleTextAttributes = textAttrs
        
//        navigationBar.setBackgroundImage(LZBaseNavController.resizableImage(imageName: "header_bg_message", edgeInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)), for: .default)
        navigationBar.isTranslucent = false
       
        self.extendedLayoutIncludesOpaqueBars = true
        self.edgesForExtendedLayout = []
        // Do any additional setup after loading the view.
        
        
    }
    

    class func resizableImage(imageName: String, edgeInsets: UIEdgeInsets) -> UIImage? {
        
        let image = UIImage(named: imageName)
        if image == nil {
            return nil
        }
        let imageW = image!.size.width
        let imageH = image!.size.height
        
        return image?.resizableImage(withCapInsets: UIEdgeInsets(top: imageH * edgeInsets.top, left: imageW * edgeInsets.left, bottom: imageH * edgeInsets.bottom, right: imageW * edgeInsets.right), resizingMode: .stretch)
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation,
        from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        
            let animator = CKWaveCollectionViewAnimator()
            animator.animationDuration = 0.7
            
        if operation != UINavigationController.Operation.push {
                
                animator.reversed = true
            }
            
            return animator
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

//    override var shouldAutorotate: Bool{
//        return self.topViewController!.shouldAutorotate
//    }
//    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
//        return self.topViewController!.supportedInterfaceOrientations
//    }
//    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation{
//        return self.topViewController!.preferredInterfaceOrientationForPresentation
//    }
    
}
