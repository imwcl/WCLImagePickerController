//
//  WCLCameraCVCell.swift
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
// @class WCLCameraCVCell
// @abstract 图片选择器的摄像的CollectionViewCell
// @discussion 图片选择器的摄像的CollectionViewCell

import UIKit

class WCLCameraCVCell: UICollectionViewCell,
                       WCLCellIdentfier {

    @IBOutlet weak var imageCameraView: UIImageView!    
    
    //MARK: Override
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageCameraView.image = WCLImagePickerOptions.cameraImage
    }
}
