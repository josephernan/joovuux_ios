//
//  TableViewController.h
//  JooVuuX
//
//  Created by Andrey on 09.06.15.
//  Copyright (c) 2015 lsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XDPopupListView.h"

@interface SettingsTVC : UITableViewController

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *backgroundView;

@property (strong, nonatomic) NSMutableDictionary * popupDialogs;

@property (strong, nonatomic) NSUserDefaults * userDefaults;


@property (weak, nonatomic) IBOutlet UISwitch *suncDateAndTime;
- (IBAction)suncDateAndTime:(UISwitch *)sender;

@property (weak, nonatomic) IBOutlet UISwitch *beepNoises;
- (IBAction)beepNoises:(UISwitch *)sender;

@property (weak, nonatomic) IBOutlet UISwitch *recordingLedIndicator;
- (IBAction)recordingLedIndicator:(UISwitch *)sender;

@property (weak, nonatomic) IBOutlet UISwitch *motionDetection;
- (IBAction)motionDetection:(UISwitch *)sender;

@property (weak, nonatomic) IBOutlet UISwitch *gSensor;
- (IBAction)gSensor:(UISwitch *)sender;

@property (weak, nonatomic) IBOutlet UISwitch *carPlateStamp;
- (IBAction)carPlateStamp:(UISwitch *)sender;



- (IBAction)dateFormatTable:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *dateFormatTable;

@property (weak, nonatomic) IBOutlet UIButton *defaultModeCameraStarts;
- (IBAction)defaultModeCameraStarts:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *powerOnAutoRecord;
- (IBAction)powerOnAutoRecord:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *standbyTime;
- (IBAction)standbyTime:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *powerOffDisconnect;
- (IBAction)powerOffDisconnect:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *motionDetectionSensitivity;
- (IBAction)motionDetectionSensitivity:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *motionTurnOff;
- (IBAction)motionTurnOff:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *TVOut;
- (IBAction)TVOut:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *speedStamp;
- (IBAction)speedStamp:(UIButton *)sender;




@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *contentView;



@end
