//
//  WCLPickerCellContext.swift
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
// @class WCLPickerCellContext
// @abstract 图片选择器cell的Context
// @discussion 图片选择器cell的Context
//

import UIKit
import Photos

class WCLPickerCellContext: NSObject {
    
    private var pickerManager: WCLPickerManager
    
    //MARK: Initial Methods
    init(pickerManager: WCLPickerManager) {
        self.pickerManager = pickerManager
        super.init()
    }
    
    //MARK: Public Methods
    func register(collectionView: UICollectionView) {
        collectionView.register(UINib.init(nibName: WCLCameraCVCell.identfier , bundle: WCLImagePickerBundle.bundle), forCellWithReuseIdentifier: WCLCameraCVCell.identfier)
        collectionView.register(UINib.init(nibName: WCLPickerCVCell.identfier, bundle: WCLImagePickerBundle.bundle), forCellWithReuseIdentifier: WCLPickerCVCell.identfier)
    }
    
    func getPikcerCellNumber(ablumIndex: Int) -> Int {
        var count = pickerManager.getAblumCount(ablumIndex)
        if WCLImagePickerOptions.needPickerCamera {
            count = count + 1
        }
        return count
    }
    
    func getPickerCell(_ collectionView: UICollectionView, ablumIndex: Int, photoIndex: Int) -> UICollectionViewCell {
        if WCLImagePickerOptions.needPickerCamera && photoIndex == 0 {
            return getCameraCell(collectionView, ablumIndex: ablumIndex, cellForItemAtIndexPath: IndexPath(item: photoIndex, section: 0))
        }else {
            return getPhotoCell(collectionView, ablumIndex: ablumIndex, cellForItemAtIndexPath: IndexPath(item: photoIndex, section: 0))
        }
    }
    
    //MARK: Private Methods
    /**
     返回WCLCameraCVCell，拍照的cell
     */
    private func getCameraCell(_ collectionView: UICollectionView, ablumIndex: Int, cellForItemAtIndexPath indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WCLCameraCVCell.identfier, for: indexPath)
        return cell
    }
    
    /**
     返回WCLPickerCVCell，照片的cell
     */
    private func getPhotoCell(_ collectionView: UICollectionView, ablumIndex: Int, cellForItemAtIndexPath indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WCLPickerCVCell.identfier, for: indexPath) as! WCLPickerCVCell
        //加载图片
        var photoIndexPath = indexPath.row
        if WCLImagePickerOptions.needPickerCamera == true {
            photoIndexPath = photoIndexPath - 1
        }
        weak var weakCell = cell
        if let photoAsset = pickerManager.getPHAsset(ablumIndex, photoIndex: photoIndexPath) {
            pickerManager.getPhotoDefalutSize(ablumIndex, photoIndex: photoIndexPath, resultHandler: { (image, infoDic) in
                weakCell?.photoImageView.image = image
            })
            //改变状态
            if let photoIndex = pickerManager.index(ofSelect: photoAsset) {
                weakCell?.selectNumBt.isSelected = true
                cell.selectNumBt.setTitle("\(photoIndex+1)", for: .selected)
            }else {
                weakCell?.selectNumBt.isSelected = false
                cell.selectNumBt.setTitle("", for: .normal)
            }
            setPickerSelectBlock(cell: cell, photoAsset: photoAsset, ablumIndex: ablumIndex, photoIndex: photoIndexPath)
        }
        return cell
    }
    
    private func setPickerSelectBlock(cell: WCLPickerCVCell, photoAsset: PHAsset, ablumIndex: Int, photoIndex: Int) {
        weak var weakCell = cell
        //判断selectCV是需要加入还是删除
        cell.selectBlock = { [weak self] () in
            let selectCount = self?.pickerManager.selectPhotoArr.count ?? 0
            if self?.pickerManager.isContains(formSelect: photoAsset) ?? false {
                let photoIndex  = self?.pickerManager.index(ofSelect: photoAsset) ?? 0
                let index       = photoIndex
                self?.pickerManager.remove(formSelect: photoAsset)
                NotificationCenter.default.post(name: WCLImagePickerNotify.deleteSelectCell, object: IndexPath.init(item: index, section: 0))
                NotificationCenter.default.post(name: WCLImagePickerNotify.reloadImagePicker, object: nil)
            }else {
                if selectCount >= WCLImagePickerOptions.maxPhotoSelectNum {
                    guard self != nil else {
                        return
                    }
                    NotificationCenter.default.post(name: WCLImagePickerNotify.imagePickerError, object: WCLError.noMoreThanImages)
                    return
                }else {
                    //添加selectCV的cell
                    self?.pickerManager.append(toSelect: photoAsset)
                    let selectCount = self?.pickerManager.selectPhotoArr.count ?? 0
                    weakCell?.selectNumBt.isSelected = true
                    weakCell?.selectNumBt.setTitle("\(selectCount)", for: .selected)
                    weakCell?.animation()
                    NotificationCenter.default.post(name: WCLImagePickerNotify.insertSelectCell, object: IndexPath.init(item: selectCount - 1, section: 0))
                }
            }
            NotificationCenter.default.post(name: WCLImagePickerNotify.reloadSelectTotalNum, object: nil)
        }
    }
}
