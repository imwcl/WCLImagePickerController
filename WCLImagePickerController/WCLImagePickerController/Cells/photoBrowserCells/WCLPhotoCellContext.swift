//
//  WCLPhotoCellContext.swift
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
// @class WCLPhotoCellContext
// @abstract PhotoBrowserCell的context
// @discussion PhotoBrowserCell的context
//

import UIKit
import Photos

class WCLPhotoCellContext: NSObject {
    
    private var pickerManager: WCLPickerManager

    init(pickerManager: WCLPickerManager) {
        self.pickerManager = pickerManager
        super.init()
    }
    
    //MARK: Public Methods
    func register(collectionView: UICollectionView) {
        collectionView.register(UINib.init(nibName: WCLPhotoCVCell.identfier , bundle: WCLImagePickerBundle.bundle), forCellWithReuseIdentifier: WCLPhotoCVCell.identfier)
    }
    
    func getCell(asset: PHAsset, collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WCLPhotoCVCell.identfier, for: indexPath) as! WCLPhotoCVCell
        let size = CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        pickerManager.getPhoto(size, alasset: asset) { (image, info) in
            if let image = image {
                let size = image.size
                let scale = CGFloat(size.width/size.height)
                let deviceScale = cell.photoSrcollView.bounds.width/cell.photoSrcollView.bounds.height
                if scale >= deviceScale {
                    cell.imageWidth.constant  = cell.photoSrcollView.bounds.width
                    cell.imageHeight.constant = cell.imageWidth.constant/scale
                    let interval = cell.photoSrcollView.bounds.height - cell.imageHeight.constant
                    cell.imageBottom.constant = interval/2
                    cell.imageTop.constant    = interval/2
                    cell.imageRight.constant  = 0
                    cell.imageLeft.constant   = 0
                }else {
                    cell.imageHeight.constant = cell.photoSrcollView.bounds.height
                    cell.imageWidth.constant  = cell.imageHeight.constant*scale
                    let interval = cell.photoSrcollView.bounds.width - cell.imageWidth.constant
                    cell.imageRight.constant  = interval/2
                    cell.imageLeft.constant   = interval/2
                    cell.imageTop.constant    = 0
                    cell.imageBottom.constant = 0
                }
            }
            cell.photoImageView.image = image
        }
        return cell
    }
}
