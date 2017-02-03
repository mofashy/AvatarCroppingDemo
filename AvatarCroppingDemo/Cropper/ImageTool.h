//
//  ImageTool.h
//  AvatarCroppingDemo
//
//  Created by Mac os x on 16/5/12.
//  Copyright © 2016年 YCS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageTool : NSObject

+ (UIImage *)turnImageWithInfo:(NSDictionary<NSString *,id> *)info;
+ (UIImage *)croppingImageView:(UIImageView *)imageView rect:(CGRect)rect;
@end
