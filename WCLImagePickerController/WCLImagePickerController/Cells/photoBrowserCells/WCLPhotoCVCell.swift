//
//  WCLPhotoCVCell.swift
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
// @class WCLPhotoCVCell
// @abstract 图片浏览器的CollectionViewCell
// @discussion 图片浏览器的CollectionViewCell

import UIKit

class WCLPhotoCVCell: UICollectionViewCell,
                      WCLCellIdentfier {
    
    @IBOutlet weak var photoSrcollView: UIScrollView!
    @IBOutlet weak var photoImageView: UIImageView!
    
    //MARK: UIScrollViewDelegate
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return photoImageView
    }
}
