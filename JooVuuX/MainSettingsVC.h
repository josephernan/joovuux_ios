//
//  MainSettingsVC.h
//  JooVuuX
//
//  Created by Vladislav on 28.09.15.
//  Copyright (c) 2015 lsoft. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "StaticDataTableViewController.h"

@interface MainSettingsVC : StaticDataTableViewController


- (IBAction)backButton:(UIBarButtonItem *)sender;

- (IBAction)SyncDateAndTimeButton:(UIButton *)sender;
- (IBAction)dateFormatButton:(UIButton *)sender;
- (IBAction)BeepNoisesButton:(UIButton *)sender;
- (IBAction)recordingLedButton:(UIButton *)sender;
- (IBAction)defaultModeButton:(UIButton *)sender;
- (IBAction)powerOnButton:(UIButton *)sender;
- (IBAction)standByButton:(UIButton *)sender;
- (IBAction)motionDetectionButton:(UIButton *)sender;
- (IBAction)motionSDButton:(UIButton *)sender;
- (IBAction)tvOutButton:(UIButton *)sender;
- (IBAction)GSensorButton:(UIButton *)sender;
- (IBAction)GSensorSButton:(UIButton *)sender;
- (IBAction)carPlateStampButton:(UIButton *)sender;
- (IBAction)speedStampButton:(UIButton *)sender;
- (IBAction)timeModeButton:(UIButton *)sender;
- (IBAction)speedUnitButton:(UIButton *)sender;
- (IBAction)poweroffDisconnectButton:(UIButton *)sender;
- (IBAction)lowBatteryWarningButton:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *timeMode;
@property (weak, nonatomic) IBOutlet UIButton *syncDateAndTimeButton;
@property (weak, nonatomic) IBOutlet UIButton *beepNioses;
@property (weak, nonatomic) IBOutlet UIButton *recordingLED;
@property (weak, nonatomic) IBOutlet UIButton *motionDetection;
@property (weak, nonatomic) IBOutlet UIButton *GSensor;
@property (weak, nonatomic) IBOutlet UIButton *carPlateStamp;
@property (weak, nonatomic) IBOutlet UIButton *speedStamp;
@property (weak, nonatomic) IBOutlet UIButton *btnLowBatteryWarning;


@property (weak, nonatomic) IBOutlet UITableViewCell *syncDateAndTimeCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *motionDetectionCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *GSensorCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *carNumberCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *WiFiPasswordCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *speedUnitCell;


@property (strong, nonatomic) IBOutletCollection(UITableViewCell) NSArray *DateFormatCollection;
@property (strong, nonatomic) IBOutletCollection(UITableViewCell) NSArray *DefaultModeCollection;
@property (strong, nonatomic) IBOutletCollection(UITableViewCell) NSArray *PowerOnAutoCollection;
@property (strong, nonatomic) IBOutletCollection(UITableViewCell) NSArray *StandByCollection;
@property (strong, nonatomic) IBOutletCollection(UITableViewCell) NSArray *MotionDSCollection;
@property (strong, nonatomic) IBOutletCollection(UITableViewCell) NSArray *TVOutCollection;
@property (strong, nonatomic) IBOutletCollection(UITableViewCell) NSArray *GSensorSCollection;
@property (strong, nonatomic) IBOutletCollection(UITableViewCell) NSArray *timeModeCell;
@property (strong, nonatomic) IBOutletCollection(UITableViewCell) NSArray *speedUnitCollection;
@property (strong, nonatomic) IBOutletCollection(UITableViewCell) NSArray *powerOffDisconnectCollection;


//// SET DATA AND ALL SHIT

- (IBAction)chooseDateFormatF:(UIButton *)sender;
- (IBAction)chooseDateFormatS:(UIButton *)sender;
- (IBAction)chooseDateFormatM:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UILabel *chooseDateFormatFLabel;
@property (weak, nonatomic) IBOutlet UILabel *chooseDateFormatSLabel;
@property (weak, nonatomic) IBOutlet UILabel *chooseDateFormatMLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateFormatLabelDestination;

/////////////////////////////////


@property (weak, nonatomic) IBOutlet UILabel *chooseDefaultModeFLabel;
@property (weak, nonatomic) IBOutlet UILabel *chooseDefaultModeSLabel;
@property (weak, nonatomic) IBOutlet UILabel *defaultModeDestinationLabel;

- (IBAction)ChooseDefaultModeFButton:(UIButton *)sender;
- (IBAction)ChooseDefaultModeSButton:(UIButton *)sender;

/////////////////////////////////////




@property (weak, nonatomic) IBOutlet UILabel *choosePowerOnFLabel;
@property (weak, nonatomic) IBOutlet UILabel *choseePowerOnSLabel;
@property (weak, nonatomic) IBOutlet UILabel *powerOnDestinationLabel;

- (IBAction)choosePowerOnFButton:(UIButton *)sender;
- (IBAction)choosePowerOnSButton:(UIButton *)sender;

///////////////////////


@property (weak, nonatomic) IBOutlet UILabel *standByDestinationLabel;
@property (weak, nonatomic) IBOutlet UILabel *chooseStandByFlabel;
@property (weak, nonatomic) IBOutlet UILabel *chooseStandBySlabel;
@property (weak, nonatomic) IBOutlet UILabel *chooseStandByTlabel;
@property (weak, nonatomic) IBOutlet UILabel *chooseStandByFourLabel;

- (IBAction)chooseStandByFButton:(UIButton *)sender;
- (IBAction)chooseStandBySButton:(UIButton *)sender;
- (IBAction)chooseStandByTButton:(UIButton *)sender;
- (IBAction)chooseStandByFourButton:(UIButton *)sender;

/////////////////////////////


//////////////////////////////


@property (weak, nonatomic) IBOutlet UILabel *motionDetectionSensDestinationLabel;
@property (weak, nonatomic) IBOutlet UILabel *motionDetectionSensFLabel;
@property (weak, nonatomic) IBOutlet UILabel *motionDetectionSensSLabel;
@property (weak, nonatomic) IBOutlet UILabel *motionDetectionSensTLabel;

- (IBAction)chooseMotionDetectionSensFButton:(UIButton *)sender;
- (IBAction)chooseMotionDetectionSensSButton:(UIButton *)sender;
- (IBAction)chooseMotionDetectionSensTButton:(UIButton *)sender;

///////////////////////////////


@property (weak, nonatomic) IBOutlet UILabel *TVOutDestinationLabel;
@property (weak, nonatomic) IBOutlet UILabel *chooseTVOutFLabel;
@property (weak, nonatomic) IBOutlet UILabel *chooseTVOutSLabel;

- (IBAction)chooseTVOutFButton:(UIButton *)sender;
- (IBAction)chooseTVOutSButton:(UIButton *)sender;
/////////////////////////////

@property (weak, nonatomic) IBOutlet UILabel *PoweroffDisconnectDestinationLabel;
@property (weak, nonatomic) IBOutlet UILabel *choosePoweroffFLabel;
@property (weak, nonatomic) IBOutlet UILabel *choosePoweroffSLabel;
- (IBAction)choosePoweroffFButton:(UIButton *)sender;
- (IBAction)choosePoweroffSButton:(UIButton *)sender;


@property (weak, nonatomic) IBOutlet UILabel *GSensorDestinationLabel;
@property (weak, nonatomic) IBOutlet UILabel *chooseGSensorFLabel;
@property (weak, nonatomic) IBOutlet UILabel *chooseGSensorSLabel;
@property (weak, nonatomic) IBOutlet UILabel *chooseGSensorTLabel;

- (IBAction)chooseGSensorFButton:(UIButton *)sender;
- (IBAction)chooseGSensorSButton:(UIButton *)sender;
- (IBAction)chooseGSensorTButton:(UIButton *)sender;
/////////////////////////////////

@property (weak, nonatomic) IBOutlet UILabel *speedUnitDestinationLabel;
@property (weak, nonatomic) IBOutlet UILabel *chooseSpeedUnitFLabel;
@property (weak, nonatomic) IBOutlet UILabel *chooseSpeedUnitSLabel;
- (IBAction)chooseSpeedUnitFButton:(UIButton *)sender;
- (IBAction)chooseSpeedUnitSButton:(UIButton *)sender;
///////////////////////////////////



@property (weak, nonatomic) IBOutlet UILabel *cameraTimeDestinationLabel;


- (IBAction)cameraTime:(UIButton *)sender;
- (IBAction)fromTimeButton:(UIButton *)sender;
- (IBAction)toTimeButton:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *fromTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *toTimeLabel;

- (IBAction)carNumberButton:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextField *carNumberTextField;
- (IBAction)carNumberTextField:(UITextField *)sender;
@property (strong, nonatomic) NSString * orientation;

- (IBAction)WiFiPasswordButton:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextField *WiFiPasswordTextField;

- (IBAction)resetAllSettingsButton:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *resetAllSettings;

@property (weak, nonatomic) IBOutlet UILabel *resetAllSettingsLabel;


@property (strong, nonatomic) UIActivityIndicatorView * indicator;


@end
