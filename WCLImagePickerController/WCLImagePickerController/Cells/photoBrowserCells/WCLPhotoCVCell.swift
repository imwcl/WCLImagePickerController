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
                      WCLCellIdentfier,
                      UIScrollViewDelegate  {
    
    @IBOutlet weak var photoSrcollView: UIScrollView!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var imageWidth: NSLayoutConstraint!
    @IBOutlet weak var imageHeight: NSLayoutConstraint!
    @IBOutlet weak var imageTop: NSLayoutConstraint!
    @IBOutlet weak var imageRight: NSLayoutConstraint!
    @IBOutlet weak var imageBottom: NSLayoutConstraint!
    @IBOutlet weak var imageLeft: NSLayoutConstraint!
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func awakeFromNib() {
        NotificationCenter.default.addObserver(self, selector: #selector(zoomChage), name: WCLImagePickerNotify.selectPickerZoom, object: nil)
    }
    
    @objc private func zoomChage() {
        photoSrcollView.zoomScale = 1.0
    }
    
    //MARK: UIScrollViewDelegate
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return photoImageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        var c = (scrollView.frame.height - photoImageView.frame.height) / 2
        if c <= 0 {c = 0}
        imageTop.constant = c
        imageBottom.constant = c
    }
}
