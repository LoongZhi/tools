//
//  LZBaseTabBarController.swift
//  WhatsGod
//
//  Created by imac on 9/21/19.
//  Copyright © 2019 L. All rights reserved.
//

import UIKit

class LZBaseTabBarController: BubbleTabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        createView()
    }
    
    func createView() -> Void {
        
        let AlbumVC = LZAlbumViewController()
        AlbumVC.tabBarItem = UITabBarItem(title: LanguageStrins(string: "Album"), image: #imageLiteral(resourceName: "picture"), tag: 0)
        let albumNav = LZBaseNavController.init(rootViewController: AlbumVC)
        
        let VideoVC = LZVideoViewController()
        VideoVC.tabBarItem = UITabBarItem(title: LanguageStrins(string: "Video"), image: #imageLiteral(resourceName: "Video"), tag: 0)
        let videoNav = LZBaseNavController.init(rootViewController: VideoVC)
        
        let OfficeVC = LZOfficeViewController()
        OfficeVC.tabBarItem = UITabBarItem(title: LanguageStrins(string: "Book"), image: #imageLiteral(resourceName: "documents"), tag: 0)
        let noteBookNav = LZBaseNavController.init(rootViewController: OfficeVC)
        
        let settingsVC = LZSettingsViewController()
        settingsVC.tabBarItem = UITabBarItem(title: LanguageStrins(string: "Settings"), image: #imageLiteral(resourceName: "read_more"), tag: 0)
        let settingsNav = LZBaseNavController.init(rootViewController: settingsVC)
        
        
      
        self.viewControllers = [albumNav, videoNav, noteBookNav, settingsNav]
        self.tabBar.tintColor = #colorLiteral(red: 0.1579992771, green: 0.1818160117, blue: 0.5072338581, alpha: 1)
      
       
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
