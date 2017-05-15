//
//  WCLSelectView.swift
//  WarChat
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
// @class WCLSelectView
// @abstract WCLPhotoBrowserController页面的右上角的选择view
// @discussion WCLPhotoBrowserController页面的右上角的选择view
//

import UIKit

internal class WCLSelectView: UIView {
    
    @IBOutlet weak var selectLabel: UILabel!
    @IBOutlet weak var selectBt: UIButton!
    
    var selecrIndex: Int = 0 {
        willSet {
            if newValue == 0 {
                selectBt.isSelected  = false
                selectLabel.isHidden = true
            }else {
                selectBt.isSelected  = true
                selectLabel.isHidden = false
                selectLabel.text     = "\(newValue)"
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let size = CGSize.init(width: 22, height: 22)
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
        selectBt.setImage(selectImage, for: .selected)
        
        selectBt.setImage(WCLImagePickerBundle.imageFromBundle("image_pickerDefault"), for: .normal)
    }
    
    //MARK: init Methods
    class func initFormNib() -> WCLSelectView {
        let view = UINib.init(nibName: "WCLSelectView", bundle: WCLImagePickerBundle.bundle).instantiate(withOwner: nil, options: nil).first as! WCLSelectView
        view.selectBt.isSelected  = false
        view.selectLabel.isHidden = true
        return view
    }

}
