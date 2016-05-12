//
//  CroppingViewController.h
//  AvatarCroppingDemo
//
//  Created by Mac os x on 16/5/4.
//  Copyright © 2016年 YCS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CroppingConstant.h"

@class CroppingViewController;

@protocol CroppingViewDelegate <NSObject>
@required
- (void)croppingViewController:(CroppingViewController *)cropper didFinishCropped:(UIImage *)croppedImage;
@end

@interface CroppingViewController : UIViewController
@property (strong, nonatomic) UIImage *image;
@property (assign, nonatomic) CGSize croppingSize;
@property (assign, nonatomic) CroppingType croppingType;
@property (weak, nonatomic  ) id<CroppingViewDelegate> delegate;
@end
