//
//  CroppingCoverView.m
//  AvatarCroppingDemo
//
//  Created by Mac os x on 16/5/4.
//  Copyright © 2016年 YCS. All rights reserved.
//

#import "CroppingCoverView.h"

@implementation CroppingCoverView

- (instancetype)initWithCroppingSize:(CGSize)croppingSize croppingType:(CroppingType)croppingType {
    
    self = [super init];
    if (self) {
        
        self.frame = SCREEN_RECT;
        self.userInteractionEnabled = NO;
        CGPoint original = CGPointMake((SCREEN_WIDTH - croppingSize.width) * 0.5, (SCREEN_HEIGHT - croppingSize.height) * 0.5);
        
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.fillColor = [[UIColor blackColor] CGColor];
        shapeLayer.fillRule = kCAFillRuleEvenOdd;
        shapeLayer.opacity = 0.5;
        [self.layer addSublayer:shapeLayer];
        
        UIBezierPath *innerPath;
        switch (croppingType) {
            case CroppingTypeRound:
                innerPath = [UIBezierPath bezierPathWithOvalInRect:(CGRect){original, croppingSize}];
                break;
            case CroppingTypeRectangle:
                innerPath = [UIBezierPath bezierPathWithRect:(CGRect){original, croppingSize}];
                break;
        }
        
        UIBezierPath *outterPath = [UIBezierPath bezierPathWithRect:SCREEN_RECT];
        [outterPath appendPath:innerPath];
        shapeLayer.path = outterPath.CGPath;
    }
    
    return self;
}
@end
