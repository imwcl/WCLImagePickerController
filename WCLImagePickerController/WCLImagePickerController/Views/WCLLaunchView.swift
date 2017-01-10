//
//  WCLLaunchView.swift
//  WCLLaunchView
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
// @class WCLLaunchView
// @abstract 缓慢展开的启动图
// @discussion 缓慢展开的启动图
//

import UIKit

internal class WCLLaunchView: UIView, CAAnimationDelegate {
    
    fileprivate var topLayer: CALayer = CALayer()
    fileprivate var bottomLayer: CALayer = CALayer()
    fileprivate var launchImage: UIImage?
    //MARK: Public Methods
    /**
     展开的动画
     */
    func starAnimation() {
        //创建一个CABasicAnimation作用于CALayer的anchorPoint
        let topAnimation = CABasicAnimation.init(keyPath: "anchorPoint")
        //设置移动路径
        topAnimation.toValue = NSValue.init(cgPoint: CGPoint(x: 1, y: 1))
        //动画时间
        topAnimation.duration = 0.6
        //设置代理，方便完成动画后移除当前view
        topAnimation.delegate = self
        //设置动画速度为匀速
        topAnimation.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionLinear)
        //设置动画结束后不移除点，保持移动后的位置
        topAnimation.isRemovedOnCompletion = false
        topAnimation.fillMode = kCAFillModeForwards
        topLayer.add(topAnimation, forKey: "topAnimation")
        
        //创建一个CABasicAnimation作用于CALayer的anchorPoint
        let bottomAnimation = CABasicAnimation.init(keyPath: "anchorPoint")
        //设置移动路径
        bottomAnimation.toValue = NSValue.init(cgPoint: CGPoint(x: 0, y: 0))
        //动画时间
        bottomAnimation.duration = 0.6
        //设置动画速度为匀速
        bottomAnimation.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionLinear)
        //设置动画结束后不移除点，保持移动后的位置
        bottomAnimation.isRemovedOnCompletion = false
        bottomAnimation.fillMode = kCAFillModeForwards
        bottomLayer.add(bottomAnimation, forKey: "topAnimation")
    }
    
    //MARK: Initial Methods
    init(frame: CGRect, launchImage: UIImage?) {
        super.init(frame: frame)
        self.launchImage = launchImage
        configTopShapeLayer()
        configBottomShapeLayer()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        if WCLImagePickerOptions.launchImage == nil {
            launchImage = getDefaultLaunchImage()
        }else {
            launchImage = WCLImagePickerOptions.launchImage
        }
        configTopShapeLayer()
        configBottomShapeLayer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Private Methods
    /**
     绘制上半部分的layer
     */
    private func configTopShapeLayer() {
        //绘制贝斯尔曲线
        let topBezier:UIBezierPath = UIBezierPath()
        topBezier.move(to: CGPoint(x: -1, y: -1))
        topBezier.addLine(to: CGPoint(x: bounds.width+1, y: -1))
        topBezier.addCurve(to: CGPoint(x: bounds.width/2.0+1, y: bounds.height/2.0+1), controlPoint1: CGPoint(x: bounds.width+1, y: 0+1), controlPoint2: CGPoint(x: 343.5+1, y: 242.5+1))
        topBezier.addCurve(to: CGPoint(x: -1, y: bounds.height+2), controlPoint1: CGPoint(x: 31.5+2, y: 424.5+2), controlPoint2: CGPoint(x: 0+2, y: bounds.height+2))
        topBezier.addLine(to: CGPoint(x: -1, y: -1))
        topBezier.close()
        //创建一个CAShapeLayer，将绘制的贝斯尔曲线的path给CAShapeLayer
        let topShape = CAShapeLayer()
        topShape.path = topBezier.cgPath
        //给topLayer设置contents为启动图
        topLayer.contents = launchImage?.cgImage
        topLayer.frame = bounds
        layer.addSublayer(topLayer)
        //将绘制后的CAShapeLayer做为topLayer的mask
        topLayer.mask = topShape
    }
    
    /**
     绘制下半部分的layer
     */
    private func configBottomShapeLayer() {
        let width  = bounds.width
        let height = bounds.height
        //绘制贝斯尔曲线
        let bottomBezier:UIBezierPath = UIBezierPath()
        bottomBezier.move(to: CGPoint(x: width, y: 0))
        bottomBezier.addCurve(to: CGPoint(x: width/2.0, y: height/2.0), controlPoint1: CGPoint(x: width, y: 0), controlPoint2: CGPoint(x: width * 0.915, y: height * 0.364))
        bottomBezier.addCurve(to: CGPoint(x: 0, y: bounds.height), controlPoint1: CGPoint(x: width * 0.084 , y: height * 0.636), controlPoint2: CGPoint(x: 0, y: bounds.height))
        bottomBezier.addLine(to: CGPoint(x: bounds.width, y: bounds.height))
        bottomBezier.addLine(to: CGPoint(x: bounds.width, y: 0))
        bottomBezier.close()
        //创建一个CAShapeLayer，将绘制的贝斯尔曲线的path给CAShapeLayer
        let bottomShape = CAShapeLayer()
        bottomShape.path = bottomBezier.cgPath
        //给bottomLayer设置contents为启动图
        bottomLayer.contents = launchImage?.cgImage
        bottomLayer.frame = bounds
        layer.addSublayer(bottomLayer)
        //将绘制后的CAShapeLayer做为bottomLayer的mask
        bottomLayer.mask = bottomShape
    }
    
    private func getDefaultLaunchImage() -> UIImage? {
        let screen = UIScreen.main
        UIGraphicsBeginImageContextWithOptions(screen.bounds.size, true, screen.scale)
        if let color = WCLImagePickerOptions.launchColor {
            color.setFill()
        }else {
            WCLImagePickerOptions.tintColor.setFill()
        }
        UIRectFill(screen.bounds)
        if let maskImage = WCLImagePickerBundle.imageFromBundle("image_photoAlbum") {
            maskImage.draw(at: CGPoint(x: screen.bounds.size.width/2 - maskImage.size.width/2, y: screen.bounds.size.height/2 - maskImage.size.height/2))
        }
        let originImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return originImage
    }
    
    //MRAK: animationDelegate
    /**
     动画完成后移除当前view
     */
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            removeFromSuperview()
        }
    }
}
