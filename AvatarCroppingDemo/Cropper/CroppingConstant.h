//
//  CroppingConstant.h
//  AvatarCroppingDemo
//
//  Created by Mac os x on 16/5/4.
//  Copyright © 2016年 YCS. All rights reserved.
//

#ifndef CroppingConstant_h
#define CroppingConstant_h

// MARK: Import framework

#import "ImageTool.h"

// MARK: Macro define

#define SCREEN_RECT [UIScreen mainScreen].bounds
#define SCREEN_WIDTH CGRectGetWidth(SCREEN_RECT)
#define SCREEN_HEIGHT CGRectGetHeight(SCREEN_RECT)

// MARK: Enum

typedef NS_ENUM(NSUInteger, CroppingType) {
    CroppingTypeRound,
    CroppingTypeRectangle,
};

#endif /* Constant_h */
