//
//  WCLPickerManager.swift
//  WCLImagePickrController-swift
//
// **************************************************
// *                                  _____         *
// *         __  _  __     ___        \   /         *
// *         \ \/ \/ /    / __\       /  /          *
// *          \  _  /    | (__       /  /           *
// *           \/ \/      \___/     /  /__          *
// *                               /_____/          *
// *                                                *
// **************************************************
//  Github  :https://github.com/631106979
//  HomePage:https://imwcl.com
//  CSDN    :http://blog.csdn.net/wang631106979
//
//  Created by 王崇磊 on 16/9/14.
//  Copyright © 2016年 王崇磊. All rights reserved.
//
// @class WCLPickerManager
// @abstract WCLPicker的管理类
// @discussion 通过这个类来获取照片和相册
//

import UIKit
import Photos

public class WCLPickerManager: NSObject {
    
    //全部相册的数组
    private(set) var photoAlbums    = [[String: PHFetchResult<PHAsset>]]()
    private(set) var selectPhotoArr = [PHAsset]()

    //是否同步请求图片
    public var isSynchronous: Bool = false {
        didSet{
            self.photoOption.isSynchronous = isSynchronous
        }
    }
    
    //pickerCell照片的size
    class public var pickerPhotoSize: CGSize {
        assert(WCLImagePickerOptions.photoLineNum > 2, "列数最小为2")
        let sreenBounds = UIScreen.main.bounds
        let screenWidth = sreenBounds.width > sreenBounds.height ? sreenBounds.height : sreenBounds.width
        let width = (screenWidth - CGFloat(WCLImagePickerOptions.photoInterval) * (CGFloat(WCLImagePickerOptions.photoLineNum) - 1)) / CGFloat(WCLImagePickerOptions.photoLineNum)
        return CGSize(width: width, height: width)
    }
    
    private var photoManage = PHCachingImageManager()
    private let photoOption = PHImageRequestOptions()
    private let photoCreationDate = "creationDate"

    //MARK: Override
    override init() {
        super.init()
        //图片请求设置成快速获取
        self.photoOption.resizeMode   = .fast
        self.photoOption.deliveryMode = .opportunistic
        getPhotoAlbum()
    }
    
    //MARK: Public Methods
    /**
     获取相册的title
     
     - parameter index: 相册的index
     
     - returns: 相册的title
     */
    public func getAblumTitle(_ ablumIndex: Int) -> String {
        if let ablum = self.photoAlbums[wcl_safe: ablumIndex] {
            if let result = ablum.keys.first {
                return "\(result)（\(getAblumCount(ablumIndex))）"
            }
        }
        return ""
    }
    
    //MARK: photo数据的操作
    /**
     通过下标返回相册中照片的个数
     
     - parameter index: 选择的index
     
     - returns: 相册中照片的个数
     */
    public func getAblumCount(_ ablumIndex: Int) -> Int {
        if let ablum = self.photoAlbums[wcl_safe: ablumIndex] {
            if let result = ablum.values.first {
                return result.count
            }
        }
        return 0
    }
    
    /**
     通过下标返回相册的PHFetchResult
     
     - parameter index: 选择相册的index
     
     - returns: 相册的PHFetchResult
     */
    public func getAblumResult(_ ablumIndex: Int) -> PHFetchResult<PHAsset>? {
        if let ablum = self.photoAlbums[wcl_safe: ablumIndex] {
            if let result = ablum.values.first {
                return result
            }
        }
        return nil
    }
    
    /**
     根据index获取PHAsset
     
     - parameter ablumIndex: 相册的index
     - parameter photoIndex: 相册里图片的index
     
     - returns: PHAsset
     */
    public func getPHAsset(_ ablumIndex: Int, photoIndex: Int) -> PHAsset? {
        let ablumResult = getAblumResult(ablumIndex)
        if ablumResult != nil {
            if ablumResult?.count != 0 {
                let photoAsset:PHAsset? = ablumResult![photoIndex]
                return photoAsset
            }
        }
        return nil
    }
    
    /**
     PHAsset是否已经在SelectPhotoArr里
     
     - parameter alasset: PHAsset对象
     
     - returns: 返回值
     */
    public func isContains(formSelect alasset: PHAsset) -> Bool {
        return selectPhotoArr.contains(alasset)
    }
    
    /**
     PHAsset在SelectPhotoArr的index
     
     - parameter alasset: PHAsset对象
     
     - returns: PHAsset在选择的数组的index
     */
    public func index(ofSelect alasset: PHAsset) -> Int? {
        return selectPhotoArr.index(of: alasset)
    }
    
    /**
     删除SelectPhotoArr里的PHAsset
     
     - parameter alasset: PHAsset对象
     */
    func remove(formSelect alasset: PHAsset) {
        if let index = index(ofSelect: alasset) {
            selectPhotoArr.wcl_removeSafe(at: index)
        }
    }
    
    /**
     添加PHAsset到SelectPhotoArr
     
     - parameter alasset: 要添加的PHAsset
     */
    public func append(toSelect alasset: PHAsset) {
        selectPhotoArr.append(alasset)
    }
    
    //MARK: 通过请求获取photo的数据
    /**
     根据index获取photo
     
     - parameter ablumIndex:    相册的index
     - parameter photoIndex:    相册里图片的index
     - parameter photoSize:     图片的size
     - parameter resultHandler: 返回照片的回调
     */
    public func getPhoto(_ ablumIndex: Int, photoIndex: Int, photoSize: CGSize, resultHandler: ((UIImage?, [AnyHashable: Any]?) -> Void)?) {
        let photoAsset:PHAsset? = getPHAsset(ablumIndex, photoIndex: photoIndex)
        if photoAsset != nil {
            let scale = UIScreen.main.scale
            let photoScaleSize = CGSize(width: photoSize.width*scale, height: photoSize.height*scale)
            self.photoManage.requestImage(for: photoAsset!, targetSize: photoScaleSize, contentMode: .aspectFill, options: self.photoOption, resultHandler: { (image, infoDic) in
                if image != nil {
                    resultHandler?(image, infoDic)
                }else {
                    let image_buffer = WCLImagePickerBundle.imageFromBundle("image-buffer")
                    resultHandler?(image_buffer, infoDic)
                }
            })
        }
    }
    
    /**
     根据PHAsset获取photo
     
     - parameter ablumIndex:    相册的index
     - parameter alasset:       相册里图片的PHAsset
     - parameter photoSize:     图片的size
     - parameter resultHandler: 返回照片的回调
     */
    public func getPhoto(_ photoSize: CGSize, alasset: PHAsset?, resultHandler: ((UIImage?, [AnyHashable: Any]?) -> Void)?) {
        if alasset != nil {
            let scale = UIScreen.main.scale
            let photoScaleSize = CGSize(width: photoSize.width*scale, height: photoSize.height*scale)
            self.photoManage.requestImage(for: alasset!, targetSize: photoScaleSize, contentMode: .aspectFill, options: self.photoOption, resultHandler: { (image, infoDic) in
                if image != nil {
                    resultHandler?(image, infoDic)
                }else {
                    let image_buffer = WCLImagePickerBundle.imageFromBundle("image-buffer")
                    resultHandler?(image_buffer, infoDic)
                }
            })
        }
    }
    
    /**
     根据PHAsset获取photo的元数据
     
     - parameter alasset:       相册里图片的PHAsset
     - parameter resultHandler: 返回照片元数据的回调
     */
    public func getPhotoData(alasset: PHAsset?, resultHandler: ((Data?, UIImageOrientation) -> Void)?) {
        if alasset != nil {
            self.photoManage.requestImageData(for: alasset!, options: nil, resultHandler: { (data, str, orientation, hashable) in
                resultHandler?(data, orientation)
            })
        }
    }
    
    /**
     获取默认大小的图片
     */
    public func getPhotoDefalutSize(_ ablumIndex: Int, photoIndex: Int, resultHandler: ((UIImage?, [AnyHashable: Any]?) -> Void)?) {
        getPhoto(ablumIndex, photoIndex: photoIndex, photoSize: WCLPickerManager.pickerPhotoSize, resultHandler: resultHandler)
    }
    
    //MARK: Private Methods
    /**
     开始获取获取相册列表
     */
    private func getPhotoAlbum() {
        //创建一个PHFetchOptions对象检索照片
        let options = PHFetchOptions()
        //通过创建时间来检索
        options.sortDescriptors = [NSSortDescriptor.init(key: photoCreationDate, ascending: false)]
        //通过数据类型来检索，这里为只检索照片
        options.predicate = NSPredicate.init(format: "mediaType in %@", [PHAssetMediaType.image.rawValue])
        //通过检索条件检索出符合检索条件的所有数据，也就是所有的照片
        let allResult = PHAsset.fetchAssets(with: options)
        //获取用户创建的相册
        let userResult = PHAssetCollection.fetchTopLevelUserCollections(with: nil)
        //获取智能相册
        let smartResult = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .albumRegular, options: nil)
        //将获取的相册加入到相册的数组中
        photoAlbums.append([WCLImagePickerBundle.localizedString(key: "全部照片"): allResult])
        
        userResult.enumerateObjects(options: .concurrent) { (collection, index, stop) in
            let assetcollection = collection as! PHAssetCollection
            //通过检索条件从assetcollection中检索出结果
            let assetResult = PHAsset.fetchAssets(in: assetcollection, options: options)
            if assetResult.count != 0 {
                self.photoAlbums.append([assetcollection.localizedTitle!:assetResult])
            }
        }
        
        smartResult.enumerateObjects(options: .concurrent) { (collection, index, stop) in
            //通过检索条件从assetcollection中检索出结果
            let assetResult = PHAsset.fetchAssets(in: collection, options: options)
            if assetResult.count != 0 {
                self.photoAlbums.append([collection.localizedTitle!:assetResult])
            }
        }
    }
}
