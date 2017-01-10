//
//  WCLPickerExtension.swift
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
// @class WCLPickerExtension
// @abstract WCLPicker的扩展
// @discussion WCLPicker的扩展
//

import UIKit

internal extension UIViewController {
    
    /**
     添加nav右侧按钮
     */
    @discardableResult
    func addWCLPhotoNavRightButton(_ btName:String) -> UIButton {
        let rightBt = UIButton()
        rightBt.contentHorizontalAlignment = .right
        rightBt.setTitle(btName, for: UIControlState())
        rightBt.setTitleColor(UIColor.white, for: UIControlState())
        rightBt.titleLabel?.font = UIFont.WCLRegularFontOfSize(15)
        rightBt.addTarget(self, action: #selector(photoRightAction(_:)), for: .touchUpInside)
        rightBt.frame.size = CGSize(width: 16*CGFloat(btName.characters.count), height: 20)
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: rightBt)
        return rightBt
    }
    
    /**
     添加nav左侧按钮
     */
    @discardableResult
    func addWCLPhotoNavLeftButton(_ btName:String) -> UIButton {
        let leftBt = UIButton()
        leftBt.contentHorizontalAlignment = .left
        leftBt.setTitle(btName, for: UIControlState())
        leftBt.setTitleColor(UIColor.white, for: UIControlState())
        leftBt.titleLabel?.font = UIFont.WCLRegularFontOfSize(15)
        leftBt.frame.size = CGSize(width: 16*CGFloat(btName.characters.count), height: 20)
        leftBt.addTarget(self, action: #selector(photoLeftAction(_:)), for: .touchUpInside)
        leftBt.sizeToFit()
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: leftBt)
        return leftBt
    }
    
    /**
     添加nav的titleView
     */
    @discardableResult
    func setWCLPhotoNavTitle(_ title:String) -> UILabel {
        let titleLable = UILabel()
        titleLable.text = title
        titleLable.textColor = UIColor.white
        titleLable.font = UIFont.WCLMediumFontOfSize(17)
        titleLable.sizeToFit()
        navigationItem.titleView = titleLable
        return titleLable
    }
    
    func photoLeftAction(_ sender: UIButton) {
        
    }
    
    func photoRightAction(_ sender: UIButton) {
        
    }
}

//MARK: 字体
extension UIFont {
    /**
     更具系统不同返回light字体
     */
    class func WCLLightFontOfSize(_ fontSize:CGFloat) -> UIFont {
        return UIFont.init(name: WCLImagePickerOptions.fontLightName, size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
    }
    /**
     更具系统不同返回Regular字体
     */
    class func WCLRegularFontOfSize(_ fontSize:CGFloat) -> UIFont {
        return UIFont.init(name: WCLImagePickerOptions.fontRegularName, size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
    }
    /**
     更具系统不同返回Medium字体
     */
    class func WCLMediumFontOfSize(_ fontSize:CGFloat) -> UIFont {
        return UIFont.init(name: WCLImagePickerOptions.fontMediumName, size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
    }
}

//MARK: 数组的扩展
extension Array {
    subscript (wcl_safe index: Int) -> Element? {
        return (0..<count).contains(index) ? self[index] : nil
    }
    
    @discardableResult
    mutating func wcl_removeSafe(at index: Int) -> Bool {
        if (0..<count).contains(index) {
            self.remove(at: index)
            return true
        }
        return false
    }
}

protocol WCLCellIdentfier {}

extension WCLCellIdentfier {
    static var identfier:String {
        return "\(self)"
    }
}
