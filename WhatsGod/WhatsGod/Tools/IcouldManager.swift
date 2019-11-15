//
//  IcouldManager.swift
//  WhatsGod
//
//  Created by imac on 11/15/19.
//  Copyright © 2019 L. All rights reserved.
//

import Foundation
class ICouldManager {
    public static func iCouldEnable() -> Bool {
           let url = FileManager.default.url(forUbiquityContainerIdentifier: nil)
           return (url != nil)
       }
       
       public static func downloadFile(WithDocumentUrl url: URL, completion: ((Data) -> Void)? = nil) {
           let document = LZDocument.init(fileURL: url)
           document.open { (success) in
               if success {
                   document.close(completionHandler: nil)
               }
               if let callback = completion {
                   callback(document.data)
               }
           }
       }
}
