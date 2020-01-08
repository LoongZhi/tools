//
//  LZFileManager.swift
//  WhatsGod
//
//  Created by imac on 10/11/19.
//  Copyright © 2019 L. All rights reserved.
//

import UIKit

public  var tempAlbumPath = LZFileManager.tempDestPath()! + LanguageStrins(string: "/AllPhotoFiles.zip")
public  var tempVideoPath = LZFileManager.tempDestPath()! + LanguageStrins(string: "/AllVideoFiles.zip")
public  var tempOfficePath = LZFileManager.tempDestPath()! + LanguageStrins(string: "/AllOfficeFiles.zip")
public  var tempAllDataPath = LZFileManager.tempDestPath()! + LanguageStrins(string: "/AllData.zip")

public let rootFolder = NSHomeDirectory() + "/Documents/"
public var rootFileManager = FileManager.default
public   let albumsFolder = rootFolder + "AlbumsFolder/"

public   let videoFolder = rootFolder + "VideoFolder/"

public   let officeFolder = rootFolder + "OfficeFolder/"
public let albumsCompressedPath = rootFolder + "albumsCompressedPath/" + "album.zip"
public let videosCompressedPath = rootFolder + "videosCompressedPath"
public let officesCompressedPath = rootFolder + "officesCompressedPath"


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
            return SubPath
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
        
        if SubPath == "" {
            return ""
        }
          if (!rootFileManager.fileExists(atPath: videoFolder + SubPath)){
              try! rootFileManager.createDirectory(at: NSURL.fileURL(withPath: videoFolder + SubPath), withIntermediateDirectories: true,

                                                          attributes: nil)
              print("Create sub folder success")
             return SubPath
          }
        return ""
    }
     //mark视频文件管理
    //写入文件
    public class func writeImageFile(filePath:String, data:Data) -> Bool{
        if filePath == "" {
            return false
        }
        if (!rootFileManager.fileExists(atPath: albumsFolder + filePath)){
            try? data.write(to: URL(fileURLWithPath: albumsFolder + filePath))
            return true
        }
        return false
    }
    //删除文件
    public class func deleteImageFile(filePath:String) -> Bool{
        if filePath == "" {
            return false
        }
        if (rootFileManager.fileExists(atPath:albumsFolder + filePath)) {
            try! rootFileManager.removeItem(atPath: albumsFolder + filePath)
            return true
        }
        return false
    }
    
    //读取文件
    public class func getImageFile(filePath:String) -> Data{
        
        if (rootFileManager.fileExists(atPath: albumsFolder + filePath)) {
            
            
            return rootFileManager.contents(atPath: albumsFolder + filePath)!
        }
        
        return Data.init()
    }
    //mark视频文件管理
      //写入视频文件
        public class func writeVideoFile(filePath:String, data:Data) -> Bool{
            
            if filePath == "" {
                return false
            }
            if (!rootFileManager.fileExists(atPath: videoFolder + filePath)){
                try? data.write(to: URL(fileURLWithPath: videoFolder + filePath))
                return true
            }
            return false
        }
        //删除视频文件
        public class func deleteViodeFile(filePath:String) -> Bool{
            if filePath == "" {
                return false
            }
            if (rootFileManager.fileExists(atPath:videoFolder + filePath)) {
                try! rootFileManager.removeItem(atPath: videoFolder + filePath)
                return true
            }
            return false
        }
        
        //读取视频文件
        public class func getViodeFile(filePath:String) -> Data{
            
            if filePath == "" {
                 return Data.init()
            }
            if (rootFileManager.fileExists(atPath: videoFolder + filePath)) {
                
                
                return rootFileManager.contents(atPath: videoFolder + filePath)!
            }

            return Data.init()
        }
    
     //mark办公文件管理
    public class func createOfficeFolder(){
             if (!rootFileManager.fileExists(atPath: officeFolder)){
                 try! rootFileManager.createDirectory(at: NSURL.fileURL(withPath: officeFolder), withIntermediateDirectories: true,

                                                             attributes: nil)
                 print("Create folder success")
             }
         }
       
       //创建办公子文件夹
       public class func createOfficeSubFolder(SubPath:String) -> String{
           
           if SubPath == "" {
               return ""
           }
             if (!rootFileManager.fileExists(atPath: officeFolder + SubPath)){
                 try! rootFileManager.createDirectory(at: NSURL.fileURL(withPath: officeFolder + SubPath), withIntermediateDirectories: true,

                                                             attributes: nil)
                 print("Create sub folder success")
                return SubPath
             }
           return ""
       }
    //写入办公文件
    public class func writeOfficeFile(filePath:String, data:Data) -> Bool{
        
        if filePath == "" {
            return false
        }
        if (!rootFileManager.fileExists(atPath: officeFolder + filePath)){
            try? data.write(to: URL(fileURLWithPath: officeFolder + filePath))
            return true
        }
        return false
    }
    //删除办公文件
    public class func deleteOfficeFile(filePath:String) -> Bool{
        if filePath == "" {
            return false
        }
        if (rootFileManager.fileExists(atPath:officeFolder + filePath)) {
            try! rootFileManager.removeItem(atPath: officeFolder + filePath)
            return true
        }
        return false
    }
    
    //读取办公文件
    public class func getOfficeFile(filePath:String) -> Data{
        
        if filePath == "" {
             return Data.init()
        }
        if (rootFileManager.fileExists(atPath: officeFolder + filePath)) {
            
            
            return rootFileManager.contents(atPath: officeFolder + filePath)!
        }

        return Data.init()
    }
    
    //获取知道文件缓存大小
    public class func  fileSizeAtPath(path:String) -> Int{
          
          if rootFileManager.fileExists(atPath: path) {
            var fileSize: Int = 0
            let childFilePath = rootFileManager.subpaths(atPath: path)
            for paths in childFilePath! {
                       let fileAbsoluePath = path + "/" + paths
                       fileSize += self.returnSingleFileSize(path: fileAbsoluePath)
                   }
            return fileSize
          }
          return 0
          
    }
    private static func returnSingleFileSize(path: String) -> Int {
        
        var fileSize: Int = 0
        do {
            let fileAttributes = try FileManager.default.attributesOfItem(atPath: path)
            let fileSizeNumber = fileAttributes[FileAttributeKey.size] as! NSNumber
            fileSize = Int(fileSizeNumber.int64Value)
        } catch _ as NSError {
            print("Filesize reading failed")
        }
        
        return fileSize/1024/1024
    }
    //临时文件路径
   public class  func tempDestPath() -> String? {
           var path = NSSearchPathForDirectoriesInDomains(.cachesDirectory,
                                                          .userDomainMask, true)[0]
           path += "/\(NSUUID().uuidString)"
           let url = NSURL(fileURLWithPath: path)
            
           do {
               try FileManager.default.createDirectory(at: url as URL,
                   withIntermediateDirectories: true, attributes: nil)
           } catch {
               return nil
           }
            
           if let path = url.path {
               print("path:\(path)")
               return path
           }
            
           return nil
       }
    
    
}
