//
//  ModeTwoVC.h
//  JooVuuX
//
//  Created by Vladislav on 29.09.15.
//  Copyright (c) 2015 lsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StaticDataTableViewController.h"


@interface ModeTwoVC : StaticDataTableViewController

- (IBAction)backButton:(UIBarButtonItem *)sender;
- (IBAction)audioAction:(UIButton *)sender;
- (IBAction)videoTimeStampButton:(UIButton *)sender;
- (IBAction)rotateDegreesButton:(UIButton *)sender;
- (IBAction)loopRecordingButton:(UIButton *)sender;
- (IBAction)timeLapseButton:(UIButton *)sender;
- (IBAction)displaySpeedButton:(UIButton *)sender;
- (IBAction)VideoResolutionButton:(UIButton *)sender;
- (IBAction)videoBitRatesButton:(UIButton *)sender;
- (IBAction)wdrButton:(UIButton *)sender;
- (IBAction)fieldOfViewButton:(UIButton *)sender;
- (IBAction)videoClipButton:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *fieldOfViewButton;

@property (weak, nonatomic) IBOutlet UIButton *audio;
@property (weak, nonatomic) IBOutlet UIButton *loopRecording;
@property (weak, nonatomic) IBOutlet UIButton *videoTimeStamp;
@property (weak, nonatomic) IBOutlet UIButton *rotateDegrees;
@property (weak, nonatomic) IBOutlet UIButton *displaySpeed;
@property (weak, nonatomic) IBOutlet UIButton *wdr;

@property (weak, nonatomic) IBOutlet UITableViewCell *VideoClipCell;

@property (strong, nonatomic) IBOutletCollection(UITableViewCell) NSArray *timeLapseCollection;
@property (strong, nonatomic) IBOutletCollection(UITableViewCell) NSArray *videoBitRatesCollection;
@property (strong, nonatomic) IBOutletCollection(UITableViewCell) NSArray *fieldOfViewCollection;
@property (strong, nonatomic) IBOutletCollection(UITableViewCell) NSArray *videoResolutionCollection;
@property (strong, nonatomic) IBOutletCollection(UITableViewCell) NSArray *videoClipCollection;

///////////////////




@property (weak, nonatomic) IBOutlet UILabel *resolutionDesctinationLabel;
@property (weak, nonatomic) IBOutlet UILabel *resolution1Label;
@property (weak, nonatomic) IBOutlet UILabel *resolution2Label;
@property (weak, nonatomic) IBOutlet UILabel *resolution3Label;
@property (weak, nonatomic) IBOutlet UILabel *resolution4Label;
@property (weak, nonatomic) IBOutlet UILabel *resolution5Label;
@property (weak, nonatomic) IBOutlet UILabel *resolution6Label;
@property (weak, nonatomic) IBOutlet UILabel *resolution7Label;
@property (weak, nonatomic) IBOutlet UILabel *resolution8Label;

- (IBAction)resolution1Button:(UIButton *)sender;
- (IBAction)resolution2Button:(UIButton *)sender;
- (IBAction)resolution3Button:(UIButton *)sender;
- (IBAction)resolution5Button:(UIButton *)sender;
- (IBAction)resolution6Button:(UIButton *)sender;
- (IBAction)resolution7Button:(UIButton *)sender;
- (IBAction)resolution8Button:(UIButton *)sender;
- (IBAction)resolution9Button:(UIButton *)sender;
//////////////////////////////////

@property (weak, nonatomic) IBOutlet UILabel *videoBitDestinationLabel;
@property (weak, nonatomic) IBOutlet UILabel *videoBit1Label;
@property (weak, nonatomic) IBOutlet UILabel *videoBit2Label;
@property (weak, nonatomic) IBOutlet UILabel *videoBit3Label;
- (IBAction)videoBit1Button:(UIButton *)sender;
- (IBAction)videoBit2Button:(UIButton *)sender;
- (IBAction)videoBit3Button:(UIButton *)sender;
///////////////////////////////////

@property (weak, nonatomic) IBOutlet UILabel *fieldOfViewDestinationLabel;
@property (weak, nonatomic) IBOutlet UILabel *fieldOfView1Label;
@property (weak, nonatomic) IBOutlet UILabel *fieldOfView2Label;
@property (weak, nonatomic) IBOutlet UILabel *fieldOfView3Label;
@property (weak, nonatomic) IBOutlet UILabel *fieldOfView4Label;

- (IBAction)fieldOfView1Button:(UIButton *)sender;
- (IBAction)fieldOfView2Button:(UIButton *)sender;
- (IBAction)fieldOfView3Button:(UIButton *)sender;
- (IBAction)fieldOfView4Button:(UIButton *)sender;
///////////////////////////////////

@property (weak, nonatomic) IBOutlet UILabel *timeLapsDestinationLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLaps1Label;
@property (weak, nonatomic) IBOutlet UILabel *timeLaps2Label;
@property (weak, nonatomic) IBOutlet UILabel *timeLaps3Label;
@property (weak, nonatomic) IBOutlet UILabel *timeLaps4Label;
@property (weak, nonatomic) IBOutlet UILabel *timeLaps5Label;

- (IBAction)timeLaps1Button:(UIButton *)sender;
- (IBAction)timeLaps2Button:(UIButton *)sender;
- (IBAction)timeLaps3Button:(UIButton *)sender;
- (IBAction)timeLaps4Button:(UIButton *)sender;
- (IBAction)timeLaps5Button:(UIButton *)sender;
///////////////////////////////////////

@property (weak, nonatomic) IBOutlet UILabel *videoClipDestinationLabel;
@property (weak, nonatomic) IBOutlet UILabel *videoClip1Label;
@property (weak, nonatomic) IBOutlet UILabel *videoClip2Label;
@property (weak, nonatomic) IBOutlet UILabel *videoClip3Label;
@property (weak, nonatomic) IBOutlet UILabel *videoClip4Label;
@property (weak, nonatomic) IBOutlet UILabel *videoClip5Label;
@property (weak, nonatomic) IBOutlet UILabel *videoClip6Label;

- (IBAction)videoClip1Button:(UIButton *)sender;
- (IBAction)videoClip2Button:(UIButton *)sender;
- (IBAction)videoClip3Button:(UIButton *)sender;
- (IBAction)videoClip4Button:(UIButton *)sender;
- (IBAction)videoClip5Button:(UIButton *)sender;
- (IBAction)videoClip6Button:(UIButton *)sender;



@property (strong, nonatomic) NSString * orientation;


- (IBAction)resetAllSettings:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *resetAllSettingsMode2;
@property (weak, nonatomic) IBOutlet UILabel *resetAllSettingsMode2Label;



@property (strong, nonatomic) UIActivityIndicatorView * indicator;



@end