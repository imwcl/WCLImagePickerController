//
//  WCLImagePickerNotify.swift
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
// @class WCLImagePickerNotify
// @abstract WCLImagePicker的通知类
// @discussion WCLImagePicker的通知类
//

import Foundation

internal struct WCLImagePickerNotify {
    // 刷新imagePicker
    static let reloadImagePicker = Notification.Name("WCLReloadImagePickerNotify")
    
    // 刷新imagePicker的selectView
    static let reloadSelect = Notification.Name("WCLReloadSelectPickerNotify")
    // 删除imagePicker的selectView的cell
    static let deleteSelectCell = Notification.Name("WCLDeleteSelectPickerCellNotofy")
    // 插入imagePicker的selectView的cell
    static let insertSelectCell = Notification.Name("WCLInsertSelectPickerCellNotofy")

    // 刷新imagePicker的selectView的TotalNum
    static let reloadSelectTotalNum = Notification.Name("WCLReloadSelectTotalNumNotofy")
    
    // imagePicker的error通知
    static let imagePickerError = Notification.Name("WCLImagePickerErrorNotify")
    
    // selectPicker的zoom通知
    static let selectPickerZoom = Notification.Name("WCLSelectPickerZoom")
}




