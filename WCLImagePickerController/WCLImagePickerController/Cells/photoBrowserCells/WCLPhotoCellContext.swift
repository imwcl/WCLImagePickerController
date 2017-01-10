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
            cell.photoImageView.image = image
        }
        return cell
    }
}
