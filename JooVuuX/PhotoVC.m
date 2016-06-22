//
//  PhotoVC.m
//  JooVuuX
//
//  Created by Vladislav on 13.10.15.
//  Copyright (c) 2015 lsoft. All rights reserved.
//

#import "PhotoVC.h"
#import "FCFileManager.h"
#import "GalleryCVC.h"
#import "CameraManager.h"

@interface PhotoVC ()

@end

@implementation PhotoVC


-(void)viewDidLoad {

    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
     self.photoImageView.contentMode =  UIViewContentModeScaleAspectFit;
    
    NSString * string = [NSString stringWithFormat:@"/album/%@", self.namePhoto];
    NSString* path = [[FCFileManager pathForDocumentsDirectory] stringByAppendingString:string];
    self.photoImageView.image = [FCFileManager readFileAtPathAsImage:path];
    
    UIBarButtonItem *btnAction = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(actionBtn)];
    btnAction.tintColor = [UIColor whiteColor];
    UIBarButtonItem *btnTrash = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(trashBtn)];
    btnTrash.tintColor = [UIColor whiteColor];
     [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:btnTrash, nil]];
    
   // [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:btnAction, btnTrash, nil]];
}

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}



#pragma mark - Actions

-(void) actionBtn {
    
}

-(void) trashBtn
{
    NSString* pathCamera = [NSString stringWithFormat:@"DCIM/100MEDIA/%@", self.namePhoto];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        [[CameraManager cameraManager ] deleteFileFromCamera:pathCamera];
    });
    NSString * string = [NSString stringWithFormat:@"/album/%@", self.namePhoto];
    NSString* path = [[FCFileManager pathForDocumentsDirectory] stringByAppendingString:string];
    [FCFileManager removeItemAtPath:path];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)backButton:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}





@end
