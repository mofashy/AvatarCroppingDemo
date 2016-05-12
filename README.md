# AvatarCroppingDemo（仿QQ头像裁剪）

## 特性

>1、仿QQ头像裁剪，可以定义裁剪框的形状

## 效果演示

![Demo GIF](AvatarCroppingDemo/ScreenShot/gifdemo.gif)<br/>

## 使用说明

### 1、请拖拽Cropper目录到您的项目中<br />
### 2、初始化
```objc
#import "CroppingViewController.h"
...

// 初始化裁剪控制器
CroppingViewController *viewController = [[CroppingViewController alloc] init];

// 指定需要裁剪的图片
viewController.image = [ImageTool imageAfterCompressWithImage:[info objectForKey:UIImagePickerControllerOriginalImage] quality:0.8];
    
// 指定裁剪框的形状和大小
viewController.croppingSize = _roundImageView.frame.size;
viewController.croppingType = CroppingTypeRound;
```

### 3、完成裁剪后调用的代理方法
```objc
- (void)croppingViewController:(CroppingViewController *)cropper didFinishCropped:(UIImage *)croppedImage;
```

## 注

>1、暂时没对push方式展示控制器进行处理，可能影响图片的拖拽
