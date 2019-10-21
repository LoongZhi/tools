//
//  AppDelegate.swift
//  WhatsGod
//
//  Created by imac on 9/18/19.
//  Copyright © 2019 L. All rights reserved.
//

import UIKit
import RealmSwift
import IQKeyboardManagerSwift
import FWPopupView
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,UIDocumentInteractionControllerDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = UIColor.white
        self.window?.makeKeyAndVisible()

        let tabBarController = LZBaseTabBarController()
        self.window?.rootViewController = tabBarController;
        
        IQKeyboardManager.shared.enable = true
        // Override point for customization after application launch.
        configRealm()
        return true
    }

    /// 配置数据库
    public  func configRealm() {
        /// 如果要存储的数据模型属性发生变化,需要配置当前版本号比之前大
        let dbVersion : UInt64 = 2
        let docPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] as String
        let dbPath = docPath.appending("/defaultDB.realm")
        let config = Realm.Configuration(fileURL: URL.init(string: dbPath), inMemoryIdentifier: nil, syncConfiguration: nil, encryptionKey: nil, readOnly: false, schemaVersion: dbVersion, migrationBlock: { (migration, oldSchemaVersion) in

        }, deleteRealmIfMigrationNeeded: false, shouldCompactOnLaunch: nil, objectTypes: nil)
        Realm.Configuration.defaultConfiguration = config
        Realm.asyncOpen { (realm, error) in
            if let _ = realm {
                print("Realm 服务器配置成功!")
            }else if let error = error {
                print("Realm 数据库配置失败：\(error.localizedDescription)")
            }
        }
        
        //创建文件目录
        LZFileManager.createAlbumsFolder()
        LZFileManager.createVideoFolder()
        LZFileManager.createOfficeFolder()
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        let myBlock: FWPopupItemClickedBlock = { [weak self] (popupView, index, title) in
                       print("AlertView：点击了第\(index)个按钮")
            switch index {
            case 0:
                self!.selectTypeFile(url: url)
                break
            case 1:
                let dic = UIDocumentInteractionController.init(url: url)
                dic.delegate = self;
                dic.presentPreview(animated: true)
                break
            default:
                break
            }
        }
        let items = [FWPopupItem(title: LanguageStrins(string: "Receive"), itemType: .normal, isCancel: true, canAutoHide: true, itemClickedBlock: myBlock),
                                       FWPopupItem(title: LanguageStrins(string: "Preview"), itemType: .normal, isCancel: false, canAutoHide: true, itemClickedBlock: myBlock),
                                       FWPopupItem(title: LanguageStrins(string: "Cancel"), itemType: .normal, isCancel: false, canAutoHide: true, itemClickedBlock: myBlock)]
        let alertView = FWAlertView.alert(title: LanguageStrins(string: "Tips"), detail: LanguageStrins(string: "Please select the options below"), inputPlaceholder: nil, keyboardType: .default, isSecureTextEntry: false, customView: nil, items: items)
                                 alertView.show()
       
        return true
    }
    
    func selectTypeFile(url: URL){
        let type:String = url.absoluteString.returnFileType(fileUrl: url.absoluteString)
        switch type {
        case FileTypeName.JPG_TYPE.rawValue:
            
            break
            
        default: break
            
        }
    }
 
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self.window!.rootViewController!
    }
    func documentInteractionControllerViewForPreview(_ controller: UIDocumentInteractionController) -> UIView? {
        return self.window?.rootViewController?.view
    }

    func documentInteractionControllerRectForPreview(_ controller: UIDocumentInteractionController) -> CGRect {
        return (self.window?.rootViewController?.view.frame)!
    }

    //点击预览窗口的“Done”(完成)按钮时调用
    func documentInteractionControllerDidEndPreview(_ controller: UIDocumentInteractionController) {
        
    }
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

