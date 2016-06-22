//
//  StreamVC.h
//  JooVuuX
//
//  Created by Vladislav on 01.10.15.
//  Copyright (c) 2015 lsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <GBPing/GBPing.h>
#import "KxMovieViewController.h"

@interface StreamVC : UIViewController <GBPingDelegate>
{
    int pingCount;
    int pingError;
}

-(void) startStreaming;
@property (strong, nonatomic) GBPing *ping;
@property (strong, nonatomic) UIActivityIndicatorView * indicator;
@property (weak, nonatomic) IBOutlet UIImageView *streamImageView;


@property (strong, nonatomic) NSString * orientation;
@property (weak, nonatomic) IBOutlet UIView *streamView;
@property (weak, nonatomic) IBOutlet UIButton *stream;
@property (weak, nonatomic) IBOutlet UIView *photoVIew;
@property (weak, nonatomic) IBOutlet UIButton *photo;
@property (weak, nonatomic) IBOutlet UIView *videoView;
@property (weak, nonatomic) IBOutlet UIButton *video;
@property (weak, nonatomic) IBOutlet UIView *settingsView;
@property (weak, nonatomic) IBOutlet UIButton *settings;
@property (weak, nonatomic) IBOutlet UIView *infoVIew;
@property (weak, nonatomic) IBOutlet UIButton *info;

@property (weak, nonatomic) IBOutlet UIButton * modes;

- (IBAction)settingsButton:(UIButton *)sender;
- (IBAction)videoButton:(UIButton *)sender;
- (IBAction)modeList:(UIButton *)sender;
- (IBAction)infoButton:(UIButton *)sender;
- (IBAction)photoButton:(UIButton *)sender;
- (IBAction)streamWButton:(UIButton *)sender;

- (IBAction)modeOneButton:(UIButton *)sender;
- (IBAction)modeTwoButton:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *modeOneButton;
@property (weak, nonatomic) IBOutlet UIButton *modeTwoButton;
@property (weak, nonatomic) IBOutlet UILabel *modeOneLabel;
@property (weak, nonatomic) IBOutlet UILabel *modeTwoLabel;
@property (weak, nonatomic) IBOutlet UIView *backgroundModeView;




@end
