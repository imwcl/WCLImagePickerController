//
//  WCLPickerCVCell.swift
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
// @class WCLPickerCVCell
// @abstract 图片选择器的CollectionViewCell
// @discussion 图片选择器的CollectionViewCell

import UIKit

class WCLPickerCVCell: UICollectionViewCell,
                       WCLCellIdentfier {

    @IBOutlet weak var selectNumBt: UIButton!
    @IBOutlet weak var photoImageView: UIImageView!
    var selectBlock:(()->Void)?
    
    //MARK: - Override
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectNumBt.setBackgroundImage(WCLImagePickerOptions.pickerDefault, for: .normal)
        
        let size = WCLImagePickerOptions.pickerDefault?.size ?? CGSize.zero
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
        selectNumBt.setBackgroundImage(selectImage, for: .selected)
    }
    
    //MARK: - Public Methods
    @discardableResult
    func animation() -> WCLPickerCVCell {
        let animation = CAKeyframeAnimation.init(keyPath: "transform.scale")
        animation.duration = 0.35
        animation.calculationMode = kCAAnimationCubic
        animation.values = [1.0 ,1.4, 0.9, 1.15, 0.95, 1.02, 1.0]
        self.selectNumBt.layer.add(animation, forKey: "scaleAnimation")
        return self
    }
    
    //MARK: - Target Methods
    @IBAction func selectAction(_ sender: UIButton) {
        if selectBlock != nil {
            selectBlock!()
        }
    }
}
