//
//  LZPassViewController.swift
//  WhatsGod
//
//  Created by mj on 1/6/20.
//  Copyright © 2020 L. All rights reserved.
//

import UIKit

let count = 4
typealias isBlock = (_ isbool :Bool) ->()
typealias isBlockPass = (_ isbool :Bool) ->()
class LZPassViewController: UIViewController,UITextFieldDelegate,UIScrollViewDelegate {

    @IBOutlet weak var scrollContentView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var passView: UIView!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var tipLabel2: UILabel!
    @IBOutlet weak var canBtn: UIButton!
    var isblock: isBlock!
     var isblockPass: isBlockPass!
    var onSw: Bool?
    let isPass:Bool =  (UserDefaults.standard.object(forKey: VCPassword) != nil)
    var viewArr:NSMutableArray = {
        return NSMutableArray.init()
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setViews()
        
    }
    func setViews(){
        
        let w = Int(self.passTextField.frame.size.width) / count;
        for i in 0...count - 1 {
            let view:UIView = UIView.init(frame: CGRect.init(x: 10 + (w * i), y: Int(17.5), width: 15, height: 4));
            view.backgroundColor = .black;
            passView.addSubview(view)
            self.viewArr.add(view)
        }
        
        self.passTextField.becomeFirstResponder()
        self.passTextField.textContentType = .none
        self.passTextField.keyboardToolbar.isHidden = true
      
        self.passTextField.textColor = UIColor.white
        self.passTextField.tintColor = .white
        self.passTextField.delegate = self;
        self.passTextField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        
        self.scrollView.isPagingEnabled = true
        self.scrollView.delegate = self
        
        
        self.tipLabel2.text = ""
        self.canBtn.setTitle(LanguageStrins(string: "Done"), for: .normal)
        if self.isPass {
            self.canBtn.isHidden = true
            self.titleLabel.text = LanguageStrins(string: "Enter lock password")
            self.tipLabel.text = LanguageStrins(string: "Please enter your lock password")
        }else{
            self.canBtn.isHidden = false
            self.titleLabel.text = LanguageStrins(string: "Set lock password")
            self.tipLabel.text = LanguageStrins(string: "Please enter the lock password")
        }
    }
    
    @IBAction func canBtn(_ sender: Any) {
        self.passTextField.resignFirstResponder()
        UserDefaults.standard.set(self.passTextField.text, forKey: VCPassword)
        if isblock != nil {
            isblock(true)
        }
        UIView.animate(withDuration: 2, animations: {
            self.view.alpha = 0;
        }) { (isbool) in
            
        }
        self.dismiss(animated: true, completion: nil)
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
         
        let  text = textField.text! + string
        if !self.isPass {
            self.tipLabel2.text = "Password:" + text
        }
        if string == "\n" {
            return false
        }
        if string.count == 0 {
            return true
        }
       
        if text.count == 4 {
            if self.isPass {
                let number:String = UserDefaults.standard.object(forKey: VCPassword) as! String
                if text == number {
                    if isblockPass != nil {
                        isblockPass(true)
                    }
                    if isblock != nil {
                        isblock(self.onSw!)
                        if !self.onSw!{
                            UserDefaults.standard.set(nil, forKey: VCPassword)
                        }
                    }
                     self.passTextField.resignFirstResponder()
                    UIView.animate(withDuration: 2, animations: {
                        self.view.alpha = 0;
                    }) { (isbool) in
                        
                    }
                    self.dismiss(animated: true, completion: nil)
                }else{
                    self.tipLabel2.text = LanguageStrins(string: "Passwords do not match, please re-enter")
                }
            }
            
        }
        if textField.text!.count >= count {
    
            return false
        }
        
        return true
    }
    @objc func textFieldDidChange(textField:UITextField){
       
        for item in self.viewArr {
            let view:UIView = item as! UIView
            view.frame.size = CGSize.init(width: 15, height: 4)
            view.frame.origin = CGPoint.init(x: view.ly_x, y:18)
            view.layer.cornerRadius = 0
            view.layer.masksToBounds = false
        }
        if textField.text?.count == 0 {
            
            return
        }
        
        for i in 0...textField.text!.count - 1 {
            let view:UIView = self.viewArr[i] as! UIView
            view.frame.size = CGSize.init(width: 15, height: 15)
            view.frame.origin = CGPoint.init(x: view.ly_x, y:7.5)
            view.frame.origin.y = 10
            view.layer.cornerRadius = 7.5
            view.layer.masksToBounds = true
        }
    }
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return false;
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
