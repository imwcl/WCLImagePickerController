# WCLImagePickerController

![](https://img.shields.io/badge/Swift-3.0-blue.svg?style=flat)

`WCLImagePickerController`是一个可以简单自定义的图片选择器

![wcl.gif](http://imwcl.oss-cn-shanghai.aliyuncs.com/github/WclImagePickerController/wcl.gif)

# Demo

可以通过[Appetize.io](https://appetize.io/app/hue1a1gmunhh46dtcxuj8ycfd4?device=iphone5s&scale=75&orientation=portrait&osVersion=9.3)允许我的Demo，非常方便~

# 使用

首先因为权限问题需要加入照片权限和摄像头的权限：

在项目的`info.plist`

`NSPhotoLibraryUsageDescription`和`NSCameraUsageDescription`

可以下载项目查看demo

```swift
// 推出WCLImagePickerController
WCLImagePickerController.present(inVC: self, delegate: self)

// 实现代理
func wclImagePickerCancel(_ picker: WCLImagePickerController) {
    picker.dismiss(animated: true, completion: nil)
}
    
func wclImagePickerComplete(_ picker: WCLImagePickerController, imageArr: [UIImage]) {
   picker.dismiss(animated: true, completion: nil)
}
    
func wclImagePickerError(_ picker: WCLImagePickerController, error: WCLError) {
    let al = UIAlertController.init(title: nil, message: error.lcalizable, preferredStyle: .alert)
    let cancel = UIAlertAction.init(title: WCLImagePickerBundle.localizedString(key: "取消"), style: .cancel, handler: nil)
    al.addAction(cancel)
    self.vc?.present(al, animated: true, completion: nil)
 }
```

# 自定义

以下属性都是可以自定义的，下面是一下默认的配置

```swift
public struct WCLImagePickerOptions {
    //字体设置，默认苹方字体
    static var fontLightName: String   = "PingFangSC-Light"
    static var fontRegularName: String = "PingFangSC-Regular"
    static var fontMediumName: String  = "PingFangSC-Medium"
    
    //MARK: 图片选择器的选项
    //是否需要拍照功能
    static var needPickerCamera: Bool  = true
    //相册页每行的照片数，默认每行3张
    static var photoLineNum: Int       = 3
    //相册选择页照片的间隔，默认3，最小为2
    static var photoInterval: Int      = 3
    //相册选择器最大选择的照片数
    static var maxPhotoSelectNum: Int  = 9
    //是否显示selectView
    static var isShowSelecView: Bool   = true
    
    //MARK: launchImage的配置
    //相册启动图片和启动颜色，二选一，launchImage优先级高
    static var launchImage: UIImage?   = nil
    //没有设置默认用imageTintColor
    static var launchColor: UIColor?   = nil
    
    //MARK: 状态栏的样式
    static var statusBarStyle: UIStatusBarStyle = .lightContent
    
    //MARK: 图片的配置
    static var imageBuffer: UIImage?        = WCLImagePickerBundle.imageFromBundle("image_buffer")
    static var ablumSelectBackGround: UIImage?   = WCLImagePickerBundle.imageFromBundle("image_ablumSelectBackGround")
    static var cameraImage: UIImage?   = WCLImagePickerBundle.imageFromBundle("image_camera")
    static var pickerArrow: UIImage?   = WCLImagePickerBundle.imageFromBundle("image_pickerArrow")
    static var pickerDefault: UIImage? = WCLImagePickerBundle.imageFromBundle("image_pickerDefault")
    static var selectPlaceholder: UIImage? = WCLImagePickerBundle.imageFromBundle("image_selectPlaceholder")
    
    //MARK: 颜色的配置
    static var tintColor: UIColor       = UIColor(red: 49/255, green: 47/255, blue: 47/255, alpha: 1)
    //没有设置默认用imageTintColor
    static var pickerSelectColor: UIColor?   = UIColor(red: 255/255, green: 0/255, blue: 27/255, alpha: 1)
    //没有设置默认用imageTintColor
    static var selectViewBackColor: UIColor? = nil
}
```

