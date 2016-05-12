//
//  ImageTool.m
//  AvatarCroppingDemo
//
//  Created by Mac os x on 16/5/12.
//  Copyright © 2016年 YCS. All rights reserved.
//

#import "ImageTool.h"

@implementation ImageTool

+ (UIImage *)imageAfterCompressWithImage:(UIImage *)image quality:(CGFloat)quality {
    
    NSData *data = UIImageJPEGRepresentation(image, quality);
    return [[UIImage alloc] initWithData:data];
}

+ (UIImage *)croppingImageView:(UIImageView *)imageView rect:(CGRect)rect {

    CGFloat scale = [UIScreen mainScreen].scale;
    CGRect realRect = (CGRect){{rect.origin.x * scale, rect.origin.y * scale}, {rect.size.width * scale, rect.size.height * scale}};
    UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, YES, scale);
    [imageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    CGImageRef imageRef = CGImageCreateWithImageInRect(UIGraphicsGetImageFromCurrentImageContext().CGImage, realRect);
    UIImage *image = [[UIImage alloc] initWithCGImage:imageRef];
    UIGraphicsEndImageContext();
    CGImageRelease(imageRef);
  
    return image;
}
@end
