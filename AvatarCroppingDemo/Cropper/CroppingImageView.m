//
//  CroppingImageView.m
//  AvatarCroppingDemo
//
//  Created by Mac os x on 16/5/4.
//  Copyright © 2016年 YCS. All rights reserved.
//

#import "CroppingImageView.h"
#import "CroppingConstant.h"

@interface CroppingImageView () <UIScrollViewDelegate>
@property (assign, nonatomic) CGSize croppingSize;
@end

@implementation CroppingImageView

- (instancetype)initWithFrame:(CGRect)frame croppingSize:(CGSize)croppingSize image:(UIImage *)image {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.croppingSize = croppingSize;
        self.minimumZoomScale = 0.5;
        self.maximumZoomScale = 1.5;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.backgroundColor = [UIColor blackColor];
        self.delegate = self;
        
        [self addSubview:self.imageView];
        
        CGFloat x = 15.0;
        CGFloat width = SCREEN_WIDTH - x * 2;
        CGFloat height = width / image.size.width * image.size.height;
        CGFloat y = (SCREEN_HEIGHT - height) * 0.5;
        self.imageView.frame = CGRectMake(x, y, width, height);
        self.imageView.image = image;
    }
    
    return self;
}

#pragma mark - UIScrollViewDelegate

- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    
    return _imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    
    CGFloat width = MAX(scrollView.contentSize.width, CGRectGetWidth(scrollView.frame));
    CGFloat height = MAX(scrollView.contentSize.height, CGRectGetHeight(scrollView.frame));
    _imageView.center = CGPointMake(width * 0.5, height * 0.5);
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view atScale:(CGFloat)scale {
    
    BOOL widthShortterThanPreferred = CGRectGetWidth(_imageView.frame) < _croppingSize.width;
    BOOL heightShortterThanPreferred = CGRectGetHeight(_imageView.frame) < _croppingSize.height;
    CGSize minimumSize = CGSizeZero;
    if (widthShortterThanPreferred) {
        CGFloat newHeight = CGRectGetHeight(_imageView.frame) * _croppingSize.width / CGRectGetWidth(_imageView.frame);
        heightShortterThanPreferred = newHeight < _croppingSize.height;
        minimumSize = CGSizeMake(_croppingSize.width, newHeight);
    }
    
    if (heightShortterThanPreferred) {
        CGFloat newWidth = CGRectGetWidth(_imageView.frame) * _croppingSize.height / CGRectGetHeight(_imageView.frame);
        minimumSize = CGSizeMake(newWidth, _croppingSize.height);
    }
    
    
    if (!CGSizeEqualToSize(CGSizeZero, minimumSize)) {
        CGFloat x = (SCREEN_WIDTH - minimumSize.width) * 0.5;
        CGFloat y = (SCREEN_HEIGHT - minimumSize.height) * 0.5;
        [UIView animateWithDuration:0.3 animations:^{
            _imageView.frame = (CGRect){{x, y}, minimumSize};
        }];
    } else {
        [UIView animateWithDuration:0.3 animations:^{
            _imageView.center = self.center;
        }];
    }
}

#pragma mark - Event handler

- (void)draggingImage:(UIPanGestureRecognizer *)recognizer {
    
    CGPoint point = [recognizer translationInView:self];
    recognizer.view.center = CGPointMake(recognizer.view.center.x + point.x, recognizer.view.center.y + point.y);
    [recognizer setTranslation:CGPointMake(0, 0) inView:self];
    
    if (recognizer.state == UIGestureRecognizerStateEnded ||
        recognizer.state == UIGestureRecognizerStateCancelled) {
        
        BOOL minXLargerThanRequired = CGRectGetMinX(_imageView.frame) > (SCREEN_WIDTH - _croppingSize.width) * 0.5;
        BOOL minYLargerThanRequired = CGRectGetMinY(_imageView.frame) > (SCREEN_HEIGHT - _croppingSize.height) * 0.5;
        BOOL maxXLittleThanRequired = CGRectGetMaxX(_imageView.frame) < (SCREEN_WIDTH + _croppingSize.width) * 0.5;
        BOOL maxYLittleThanRequired = CGRectGetMaxY(_imageView.frame) < (SCREEN_HEIGHT + _croppingSize.height) * 0.5;
        CGRect rect = _imageView.frame;
        
        if (minXLargerThanRequired) {
            rect.origin.x = (SCREEN_WIDTH - _croppingSize.width) * 0.5;
        }
        if (minYLargerThanRequired) {
            rect.origin.y = (SCREEN_HEIGHT - _croppingSize.height) * 0.5;
        }
        if (maxXLittleThanRequired) {
            rect.origin.x = (SCREEN_WIDTH + _croppingSize.width) * 0.5 - CGRectGetWidth(_imageView.frame);
        }
        if (maxYLittleThanRequired) {
            rect.origin.y = (SCREEN_HEIGHT + _croppingSize.height) * 0.5 - CGRectGetHeight(_imageView.frame);
        }
        
        [UIView animateWithDuration:0.3 animations:^{
            _imageView.frame = rect;
        }];
    }
}

#pragma mark - Getter   |   Setter

- (UIImageView *)imageView {
    
    if (!_imageView) {
        _imageView = ({
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.userInteractionEnabled = YES;
            imageView.backgroundColor = [UIColor blackColor];
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            [imageView addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(draggingImage:)]];
            imageView;});
    }
    
    return _imageView;
}
@end
