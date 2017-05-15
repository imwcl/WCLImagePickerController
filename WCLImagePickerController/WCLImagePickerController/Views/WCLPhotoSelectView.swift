//
//  WCLPhotoSelectView.swift
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
//  HomePage:http://imwcl.com
//  CSDN    :http://blog.csdn.net/wang631106979
//
//  Created by 王崇磊 on 16/9/14.
//  Copyright © 2016年 王崇磊. All rights reserved.
//
// @class WCLPhotoSelectView
// @abstract 相册中选择的照片的view
// @discussion 相册中选择的照片的view
//

import UIKit
import Photos

internal class WCLPhotoSelectView: UIView,
                          UICollectionViewDelegate,
                          UICollectionViewDataSource {
    
    private var pickerManager: WCLPickerManager?
    @IBOutlet weak var imageSelectImage: UIImageView!
    @IBOutlet weak var imageSelectNum: UILabel!
    @IBOutlet weak var selectCollectionView: UICollectionView!
    
    var pushBlock: ((_: UIViewController) -> Void)?
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    //MARK: Public Methods
    
    
    //MARK: Override
    override func awakeFromNib() {
        super.awakeFromNib()
        if let color = WCLImagePickerOptions.selectViewBackColor {
            backgroundColor = color
        }else {
            backgroundColor = WCLImagePickerOptions.tintColor
        }
        selectCollectionView.register(UINib.init(nibName: WCLSelecteCVCell.identfier, bundle: WCLImagePickerBundle.bundle), forCellWithReuseIdentifier: WCLSelecteCVCell.identfier)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadSelectTotalNum), name: WCLImagePickerNotify.reloadSelectTotalNum, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(deleteSelectTotalNum(_ :)), name: WCLImagePickerNotify.deleteSelectCell, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(insertSelectTotalNum(_ :)), name: WCLImagePickerNotify.insertSelectCell, object: nil)
        
        let size = CGSize.init(width: 26, height: 26)
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        let context = UIGraphicsGetCurrentContext()
        if let color = WCLImagePickerOptions.pickerSelectColor {
            color.setFill()
        }else {
            WCLImagePickerOptions.tintColor.setFill()
        }
        context?.addArc(center: CGPoint.init(x: size.width / 2, y: size.height / 2), radius: size.width / 2, startAngle: 0, endAngle: CGFloat(Double.pi * 2), clockwise: true)
        context?.fillPath()
        let selectImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        imageSelectImage.image = selectImage
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()
    }
    
    //MARK: Initial Methods
    class func `init`(frame: CGRect, pickerManager: WCLPickerManager) -> WCLPhotoSelectView {
        let view = UINib.init(nibName: "WCLPhotoSelectView", bundle: WCLImagePickerBundle.bundle).instantiate(withOwner: nil, options: nil).first as! WCLPhotoSelectView
        view.frame         = frame
        view.pickerManager = pickerManager
        return view
    }
    
    //MARK: Privater Methods

    
    //MARK: UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        if let count = pickerManager?.selectPhotoArr.count {
            if count != indexPath.row {
                let browserVC = WCLPhotoBrowserController.init(pickerManager!, currentIndex: indexPath.row, selectAssetArr: pickerManager!.selectPhotoArr)
                pushBlock?(browserVC)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 36, height: 36)
    }
    
    //MARK: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pickerManager!.selectPhotoArr.count+1

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WCLSelecteCVCell.identfier, for: indexPath) as! WCLSelecteCVCell
        if let pickerManager = pickerManager {
            if indexPath.row == pickerManager.selectPhotoArr.count {
                cell.selectImageView.image = WCLImagePickerOptions.selectPlaceholder
            }else {
                weak var weakCell = cell
                let assetArr: [PHAsset] = pickerManager.selectPhotoArr
                pickerManager.getPhoto(CGSize(width: 36, height: 36), alasset: assetArr[indexPath.row], resultHandler: { (image, infoDic) in
                    weakCell?.selectImageView.image = image
                })
            }
        }else {
            cell.selectImageView.image = WCLImagePickerOptions.selectPlaceholder
        }
        return cell
    }
    
    //MARK: Notification Methods
    @objc private func reloadSelectTotalNum() {
        if let pickerManager = pickerManager {
            imageSelectNum.text = String.init(format: "%d", pickerManager.selectPhotoArr.count)
        }
    }
    
    @objc private func deleteSelectTotalNum(_ not: Notification) {
        if let index = not.object as? IndexPath {
            selectCollectionView.performBatchUpdates({ [weak self] in
                self?.selectCollectionView.deleteItems(at: [index])
            }, completion: nil)
        }
    }

    @objc private func insertSelectTotalNum(_ not: Notification) {
        if let index = not.object as? IndexPath {
            selectCollectionView.performBatchUpdates({ [weak self] in
                self?.selectCollectionView.insertItems(at: [index])
                }, completion: nil)
        }
    }
}


