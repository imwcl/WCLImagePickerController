//
//  WCLError.swift
//  WclImagePickerController
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
// @class WCLError
// @abstract 错误提示
// @discussion 错误提示
//

import UIKit

public enum WCLError {
    /// 没有相册访问权限
    case noAlbumPermissions
    /// 没有摄像头访问权限
    case noCameraPermissions
    /// 超过选择最大数
    case noMoreThanImages
    public var lcalizable: String? {
        if self == .noAlbumPermissions {
            return WCLImagePickerBundle.localizedString(key: "没有相册访问权限")
        }
        if self == .noCameraPermissions {
            return WCLImagePickerBundle.localizedString(key: "没有摄像头访问权限")
        }
        if self == .noMoreThanImages {
            return String(format: WCLImagePickerBundle.localizedString(key: "最多选择%d张照片") , WCLImagePickerOptions.maxPhotoSelectNum)
        }
        return nil
    }
}
