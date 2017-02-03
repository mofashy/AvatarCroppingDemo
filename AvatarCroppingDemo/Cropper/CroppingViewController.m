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
@property (strong, nonatomic) CroppingImageView *croppingImageView;
@property (strong, nonatomic) CroppingCoverView *croppingCoverView;
@end

@implementation CroppingViewController

#pragma mark - Life cycle

- (void)dealloc {
    
    NSLog(@"%@ dealloc", NSStringFromClass([self class]));
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor blackColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneAction:)];
    
    [self.view addSubview:self.croppingImageView];
    [self.view addSubview:self.croppingCoverView];
}

#pragma mark - Event handler

- (void)doneAction:(UIBarButtonItem *)sender {
    
    CGFloat x = (SCREEN_WIDTH - _croppingSize.width) * 0.5;
    CGFloat y = (SCREEN_HEIGHT - _croppingSize.height) * 0.5;
    CGRect rect = (CGRect){{x, y}, _croppingSize};
    CGRect newRect = [self.croppingCoverView convertRect:rect toView:_croppingImageView.imageView];
    UIImage *image = [ImageTool croppingImageView:self.croppingImageView.imageView rect:newRect];
    
    if (self.doneBlock) {
        self.doneBlock(image);
    }
}

#pragma mark - Getter   |   Setter

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
