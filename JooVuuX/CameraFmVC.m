//
//  CameraFmVC.m
//  JooVuuX
//
//  Created by Vladislav on 01.10.15.
//  Copyright (c) 2015 lsoft. All rights reserved.
//

#import "CameraFmVC.h"
#import "WhiteBalanceVC.h"
#import "CameraManager.h"
#import "FCFileManager.h"


@interface CameraFmVC ()

@property (weak, nonatomic) IBOutlet UILabel *cameraFWTitle;


@end

@implementation CameraFmVC


-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([[CameraManager cameraManager] cameraFW].length > 0) {
        self.cameraFWTitle.text = [NSString stringWithFormat:@"Camera FW: %@",[[CameraManager cameraManager] cameraFW]];
    }
    else
    {
        self.cameraFWTitle.text = [NSString stringWithFormat:@"No data :("];
    }
    
    
    self.navigationController.navigationBar.hidden = NO;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
    [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) alertFormatMicroSDCard
{
    UIAlertView *subAlert = [[UIAlertView alloc] initWithTitle:@""
                                                       message:@"The Format Did Complete Successfully."
                                                      delegate:self
                                             cancelButtonTitle:@"Close"
                                             otherButtonTitles:nil];
    
    [subAlert show];
}


#pragma mark - Actions

- (IBAction)backButton:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"getToken" object:nil];
    
}



- (IBAction)whiteBalanceButton:(UIButton *)sender {
    
    self.whiteBalanceLabel.backgroundColor = [UIColor colorWithRed:149/256.0 green:149/256.0 blue:149/256.0 alpha:1];
    WhiteBalanceVC* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"WhiteBalanceVC"];
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (IBAction)formatSdCardButton:(UIButton *)sender {
    
    self.formatSdCardLabel.backgroundColor = [UIColor colorWithRed:149/256.0 green:149/256.0 blue:149/256.0 alpha:1];
    
    [[CameraManager cameraManager] formatSD:@"D:"];
    
    NSString * string = [NSString stringWithFormat:@"/album/"];
    NSString* path = [[FCFileManager pathForDocumentsDirectory] stringByAppendingString:string];
     [FCFileManager removeItemsInDirectoryAtPath:path];
    
    [self alertFormatMicroSDCard];
    
}


@end
