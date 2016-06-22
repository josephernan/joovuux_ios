//
//  MainScreenVC.h
//  JooVuuX
//
//  Created by Vladislav on 25.09.15.
//  Copyright (c) 2015 lsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainScreenVC : UIViewController

@property (weak, nonatomic) IBOutlet UIView *mainSettingsView;
@property (weak, nonatomic) IBOutlet UIView *modeSettingsView;

@property (weak, nonatomic) IBOutlet UIButton *mainSettings;
@property (weak, nonatomic) IBOutlet UIButton *modeSettings;


- (IBAction)mainSettingsAction:(UIButton *)sender;
- (IBAction)modeSettinsAction:(UIButton *)sender;



@property (weak, nonatomic) IBOutlet UIView *galeryView;

@property (weak, nonatomic) IBOutlet UIButton *galery;
- (IBAction)galaryButton:(UIButton *)sender;


@property (weak, nonatomic) IBOutlet UIView *streamingView;
@property (weak, nonatomic) IBOutlet UIButton *streaming;
- (IBAction)streamingButton:(UIButton *)sender;


@property (weak, nonatomic) IBOutlet UIView *photoView;
@property (weak, nonatomic) IBOutlet UIButton *photo;
- (IBAction)photoButton:(UIButton *)sender;


@property (weak, nonatomic) IBOutlet UIView *videoView;
@property (weak, nonatomic) IBOutlet UIButton *video;
- (IBAction)videoButton:(UIButton *)sender;


@property (weak, nonatomic) IBOutlet UIView *connectingView;
@property (weak, nonatomic) IBOutlet UIButton *conntecting;
- (IBAction)connectiongButton:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIView *cameraView;
@property (weak, nonatomic) IBOutlet UIButton *camera;
- (IBAction)cameraButton:(UIButton *)sender;


@property BOOL emergency;
@property (strong, nonatomic) UIImage * clearState;
@property (strong, nonatomic) UIImage * emergencyState;
@property (strong, nonatomic) UIImage * normalState;



@end
