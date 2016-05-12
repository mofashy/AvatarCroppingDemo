//
//  CroppingImageView.h
//  AvatarCroppingDemo
//
//  Created by Mac os x on 16/5/4.
//  Copyright © 2016年 YCS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CroppingImageView : UIScrollView
@property (strong, nonatomic) UIImageView *imageView;

- (instancetype)initWithFrame:(CGRect)frame croppingSize:(CGSize)croppingSize image:(UIImage *)image;
@end
