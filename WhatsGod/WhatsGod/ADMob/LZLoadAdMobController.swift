//
//  LZLoadAdMobController.swift
//  WhatsGod
//
//  Created by mj on 1/9/20.
//  Copyright © 2020 L. All rights reserved.
//

import UIKit
import GoogleMobileAds
class LZLoadAdMobController: UIViewController,GADBannerViewDelegate {
   
    var interstitial: GADInterstitial!
     let itme = UIBarButtonItem.init(title: LanguageStrins(string: "跳过"), style: .done, target: self, action: #selector(rightItme))
    @IBOutlet weak var bannerView: GADBannerView!
    override func viewDidLoad() {
        super.viewDidLoad()
    
//         bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
//         bannerView.rootViewController = self
//         bannerView.delegate = self
//         bannerView.load(GADRequest())
        
        
        self.navigationItem.rightBarButtonItem = itme
       
  
//        interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/4411468910")
//        let request = GADRequest()
//        interstitial.load(request)
        
    }
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        var time = 3
        let codeTimer = DispatchSource.makeTimerSource(flags: .init(rawValue: 0), queue: DispatchQueue.global())
        codeTimer.schedule(deadline: .now(), repeating: .milliseconds(1000))  //此处方法与Swift 3.0 不同
        codeTimer.setEventHandler {
            
            time = time - 1
            
            
            if time < 0 {
                codeTimer.cancel()
                DispatchQueue.main.async {
                    self.itme.title = LanguageStrins(string: "跳过")
                }
                return
            }
            
            DispatchQueue.main.async {
               self.itme.title = "(\(time))" +  LanguageStrins(string: "跳过")
               self.removeAD()
            }
            
        }
        
        codeTimer.activate()
    }
    func removeAD(){
        let tabBarController = LZBaseTabBarController()
        UIApplication.shared.keyWindow!.rootViewController = tabBarController;
    }
    @objc func rightItme(){
        self.removeAD()
    }

}
