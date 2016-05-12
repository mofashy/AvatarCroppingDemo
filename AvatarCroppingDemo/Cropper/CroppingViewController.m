//
//  CroppingViewController.m
//  AvatarCroppingDemo
//
//  Created by Mac os x on 16/5/4.
//  Copyright © 2016年 YCS. All rights reserved.
//

#import "CroppingViewController.h"
#import "CroppingCoverView.h"
#import "CroppingImageView.h"

@interface CroppingViewController ()
@property (strong, nonatomic) UIButton *doneButton;
@property (strong, nonatomic) CroppingImageView *croppingImageView;
@property (strong, nonatomic) CroppingCoverView *croppingCoverView;
@end

@implementation CroppingViewController

#pragma mark - Life cycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.croppingImageView];
    [self.view addSubview:self.croppingCoverView];
    [self.view addSubview:self.doneButton];
}

#pragma mark - Event handler

- (void)doneAction {
    
    CGFloat x = (SCREEN_WIDTH - _croppingSize.width) * 0.5;
    CGFloat y = (SCREEN_HEIGHT - _croppingSize.height) * 0.5;
    CGRect rect = (CGRect){{x, y}, _croppingSize};
    CGRect newRect = [self.croppingCoverView convertRect:rect toView:_croppingImageView.imageView];
    UIImage *image = [ImageTool croppingImageView:self.croppingImageView.imageView rect:newRect];
    
    if ([self.delegate respondsToSelector:@selector(croppingViewController:didFinishCropped:)]) {
        
        [self.delegate croppingViewController:self didFinishCropped:image];
    }
}

#pragma mark - Getter   |   Setter

- (UIButton *)doneButton {
    
    if (!_doneButton) {
        _doneButton = ({
            CGFloat width = 44.0;
            UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
            doneButton.frame = CGRectMake(SCREEN_WIDTH - 15 - width, 0, width, 44);
            [doneButton setTitle:@"Done" forState:UIControlStateNormal];
            [doneButton addTarget:self action:@selector(doneAction) forControlEvents:UIControlEventTouchUpInside];
            doneButton;});
    }
    
    return _doneButton;
}

- (CroppingImageView *)croppingImageView {
    
    if (!_croppingImageView) {
        _croppingImageView = [[CroppingImageView alloc] initWithFrame:SCREEN_RECT croppingSize:_croppingSize image:_image];
    }
    
    return _croppingImageView;
}

- (CroppingCoverView *)croppingCoverView {
    
    if (!_croppingCoverView) {
        _croppingCoverView = [[CroppingCoverView alloc] initWithCroppingSize:_croppingSize croppingType:_croppingType];
    }
    
    return _croppingCoverView;
}
@end
