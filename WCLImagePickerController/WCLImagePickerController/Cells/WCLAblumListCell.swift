//
//  WCLAblumListCell.swift
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
// @class WCLAblumListCell
// @abstract 相册列表的TableViewCell
// @discussion 相册列表的TableViewCell

import UIKit

class WCLAblumListCell: UITableViewCell,
                        WCLCellIdentfier {

    @IBOutlet weak var ablumNameLabel: UILabel!
    @IBOutlet weak var ablumImageView: UIImageView!
    @IBOutlet weak var selectImageView: UIImageView!
    //MARK: Public Methods
    
    
    //MARK: Override
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        ablumImageView.image  = WCLImagePickerOptions.imageBuffer
        selectImageView.highlightedImage = WCLImagePickerOptions.ablumSelectBackGround
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
