//
//  LZBaseViewController.swift
//  WhatsGod
//
//  Created by imac on 9/18/19.
//  Copyright © 2019 L. All rights reserved.
//

import UIKit
import LYEmptyView

class LZBaseViewController: UIViewController {

    public var dataSource = [Any]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        create()
    }
    
    func create() -> Void {
        self.view.backgroundColor = UIColor.white
        NotificationCenter.default.addObserver(self, selector: #selector(transormView(not:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for  view in self.view.subviews {
            view.resignFirstResponder()
        }
    }
    
   @objc func transormView(not:Notification) {
    
        let keyboardBeginBouns:NSValue = not.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue
        let beginRect = keyboardBeginBouns.cgRectValue
        let keyBoardEndBounds:NSValue = not.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        let endRect = keyBoardEndBounds.cgRectValue
    
        let deltaY = endRect.origin.y-beginRect.origin.y
    
        print(deltaY)
    
        UIView.animate(withDuration: 0.25) {
            self.view.frame = CGRect.init(x: self.view.frame.origin.x, y: self.view.frame.origin.y+deltaY, width: self.view.frame.size.width, height: self.view.frame.size.height)
            
        }
    }
    @objc func rightItmeEvent(){
        
    }
    @objc  func leftItmeEvent(){
        
    }
    
    override var hidesBottomBarWhenPushed: Bool {
            get {
                return navigationController?.topViewController != self
            }
            set {
                super.hidesBottomBarWhenPushed = newValue
            }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
