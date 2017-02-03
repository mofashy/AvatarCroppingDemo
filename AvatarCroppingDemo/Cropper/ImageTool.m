//
//  ImageTool.m
//  AvatarCroppingDemo
//
//  Created by Mac os x on 16/5/12.
//  Copyright © 2016年 YCS. All rights reserved.
//

#import "ImageTool.h"

@implementation ImageTool

+ (UIImage *)turnImageWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *image=[info objectForKey:UIImagePickerControllerOriginalImage];
    //类型为 UIImagePickerControllerOriginalImage 时图片角度
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"]) {
        UIImageOrientation imageOrientation=image.imageOrientation;
        if(imageOrientation!=UIImageOrientationUp) {
            // 原始图片可以根据照相时的角度来显示，但 UIImage无法判定，于是出现获取的图片会向左转90度的现象。
            UIGraphicsBeginImageContext(image.size);
            [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
            image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
        }
    }
    return image;
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
