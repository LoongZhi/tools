//
//  LZFileManager.swift
//  WhatsGod
//
//  Created by imac on 10/11/19.
//  Copyright © 2019 L. All rights reserved.
//

import UIKit
public let rootFolder = NSHomeDirectory() + "/Documents/"
public var rootFileManager = FileManager.default
public   let albumsFolder = rootFolder + "AlbumsFolder/"

public   let videoFolder = rootFolder + "VideoFolder/"
class LZFileManager: NSObject {
   
   
    //创建相册目录
    public class func createAlbumsFolder(){
        if (!rootFileManager.fileExists(atPath: albumsFolder)){
            try! rootFileManager.createDirectory(at: NSURL.fileURL(withPath: albumsFolder), withIntermediateDirectories: true,

                                                        attributes: nil)
            print("Create folder success")
        }
    }
    
    //创建相册子文件夹
    public class func createAlbumsSubFolder(SubPath:String) -> String{
        
        if (!rootFileManager.fileExists(atPath: albumsFolder + SubPath)){
                   try! rootFileManager.createDirectory(at: NSURL.fileURL(withPath: albumsFolder + SubPath), withIntermediateDirectories: true,

                                                               attributes: nil)
                   print("Create Sub folder success")
            return albumsFolder + SubPath
        }
        return ""
    }
  
 
    
    //创建视频目录
    public class func createVideoFolder(){
          if (!rootFileManager.fileExists(atPath: videoFolder)){
              try! rootFileManager.createDirectory(at: NSURL.fileURL(withPath: videoFolder), withIntermediateDirectories: true,

                                                          attributes: nil)
              print("Create folder success")
          }
      }
    
    //创建视频子文件夹
    public class func createVideoSubFolder(SubPath:String) -> String{
          if (!rootFileManager.fileExists(atPath: videoFolder + SubPath)){
              try! rootFileManager.createDirectory(at: NSURL.fileURL(withPath: videoFolder + SubPath), withIntermediateDirectories: true,

                                                          attributes: nil)
              print("Create sub folder success")
             return albumsFolder + SubPath
          }
        return ""
    }
    
    //写入文件
    public class func writeFile(filePath:String, data:Data) -> Bool{
        if (!rootFileManager.fileExists(atPath: filePath)){
            try? data.write(to: URL(fileURLWithPath: filePath))
            return true
        }
        return false
    }
    //删除文件
    public class func deleteFile(filePath:String) -> Bool{
        if (rootFileManager.fileExists(atPath: filePath)) {
            try! rootFileManager.removeItem(atPath: filePath)
            return true
        }
        return false
    }
    
    //读取文件
    public class func getFile(filePath:String) -> Data{
        
        if (rootFileManager.fileExists(atPath: filePath)) {
            
            
            return rootFileManager.contents(atPath: filePath)!
        }
        
        return Data.init()
    }
}
