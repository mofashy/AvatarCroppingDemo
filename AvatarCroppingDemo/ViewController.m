//
//  ViewController.m
//  AvatarCroppingDemo
//
//  Created by Mac os x on 16/5/4.
//  Copyright © 2016年 YCS. All rights reserved.
//

#import "ViewController.h"
#import "CroppingViewController.h"

@interface ViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (assign, nonatomic) NSInteger tag;
@property (weak, nonatomic) IBOutlet UIImageView *roundImageView;
@property (weak, nonatomic) IBOutlet UIImageView *rectangleImageView;

@end

@implementation ViewController

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [_roundImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)]];
    [_rectangleImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    __weak __typeof(self)weakSelf = self;
    
    CroppingViewController *viewController = [[CroppingViewController alloc] init];
    viewController.image = [ImageTool turnImageWithInfo:info];
    viewController.doneBlock = ^(UIImage *image) {
        if (weakSelf.tag == 100) {
            weakSelf.roundImageView.image = image;
        } else {
            weakSelf.rectangleImageView.image = image;
        }
        [picker dismissViewControllerAnimated:YES completion:nil];
    };
    if (_tag == 100) {
        viewController.croppingSize = _roundImageView.frame.size;
        viewController.croppingType = CroppingTypeRound;
    } else {
        viewController.croppingSize = _rectangleImageView.frame.size;
        viewController.croppingType = CroppingTypeRectangle;
    }
    
    [picker pushViewController:viewController animated:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Event handler

- (void)tapImageView:(UITapGestureRecognizer *)recognizer {
    
    _tag = recognizer.view.tag;
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"Pick a photo" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancelAction];
    UIAlertAction *captureAction = [UIAlertAction actionWithTitle:@"Capture" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
            pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            pickerController.delegate = self;
            [self presentViewController:pickerController animated:YES completion:nil];
        }
    }];
    [alertController addAction:captureAction];
    UIAlertAction *albumAction = [UIAlertAction actionWithTitle:@"Photo library" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            
            UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
            pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            pickerController.delegate = self;
            [self presentViewController:pickerController animated:YES completion:nil];
        }
    }];
    [alertController addAction:albumAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
@end
