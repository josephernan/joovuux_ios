//
//  TableViewController.m
//  JooVuuX
//
//  Created by Andrey on 09.06.15.
//  Copyright (c) 2015 lsoft. All rights reserved.
//

#import "SettingsTVC.h"
#import "NSString+Utils.h"
#import "PopUpDialogDiligate.h"

static NSString * DATE_FORMAT_TABLE = @"dateFormatTable";
static NSString * DEFAULT_MODE_CAMERA_STARTS = @"defaultModeCameraStarts";
static NSString * POWER_ON_AUTO_RECORD = @"powerOnAutoRecord";
static NSString * STANDBY_TIME = @"standbyTime";
static NSString * POWER_OFF_DISCONNECT = @"powerOffDisconnect";
static NSString * MOTION_DETECTION_SENSITIVITY = @"motionDetectionSensitivity";
static NSString * MOTION_TURN_OFF = @"motionTurnOff";
static NSString * TV_OUT = @"TVOut";

static NSString * SUNC_DATE_AND_TIME = @"suncDateAndTime";
static NSString * BEEP_NOISES = @"beepNoises";
static NSString * RECORDING_LED_INDICATOR = @"recordingLedIndicator";
static NSString * MOTION_DETECTION = @"motionDetection";
static NSString * G_SENSOR = @"gSensor";
static NSString * CAR_PLATE_STAMP = @"carPlateStamp";
static NSString * SPEED_STAMP = @"speedStamp";

@interface SettingsTVC ()

@end

@implementation SettingsTVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:72/255.0 green:216/255.0 blue:183/255.0 alpha:1];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    self.popupDialogs = [[NSMutableDictionary alloc] init];
    self.userDefaults = [NSUserDefaults standardUserDefaults];
    
    [self initPopupTables];
    [self setSettingsView];
    [self loadSwithSettings];
    
}

#pragma mark - setSettingsView

-(void) setSettingsView
{
//    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:
//                                     [UIImage imageNamed:@"background"]];
    
    self.tableView.backgroundColor = [UIColor lightGrayColor];
    
    for (UIView * view in self.backgroundView) {
        
//        [view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"beckground-box"]]];
         [view setBackgroundColor:[UIColor whiteColor]];
        
    }
    
    NSDictionary *titleAttributes =@{NSFontAttributeName :[UIFont fontWithName:@"Helvetica-Bold" size:14.0],
                                     NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    [[UINavigationBar appearance] setTitleTextAttributes:
     titleAttributes];
}


#pragma mark - initSwitch

- (IBAction)suncDateAndTime:(UISwitch *)sender
{
    [self.userDefaults setBool:self.suncDateAndTime.isOn forKey:SUNC_DATE_AND_TIME];
}

- (IBAction)beepNoises:(UISwitch *)sender
{
    [self.userDefaults setBool:self.beepNoises.isOn forKey:BEEP_NOISES];
}

- (IBAction)recordingLedIndicator:(UISwitch *)sender
{
    [self.userDefaults setBool:self.recordingLedIndicator.isOn forKey:RECORDING_LED_INDICATOR];
}

- (IBAction)motionDetection:(UISwitch *)sender
{
    [self.userDefaults setBool:self.motionDetection.isOn forKey:MOTION_DETECTION];
}

- (IBAction)gSensor:(UISwitch *)sender
{
    [self.userDefaults setBool:self.gSensor.isOn forKey:G_SENSOR];
}

- (IBAction)carPlateStamp:(UISwitch *)sender
{
    [self.userDefaults setBool:self.carPlateStamp.isOn forKey:CAR_PLATE_STAMP];
}

-(void) loadSwithSettings
{
    self.suncDateAndTime.on = [self.userDefaults boolForKey:SUNC_DATE_AND_TIME];
    self.beepNoises.on = [self.userDefaults boolForKey:BEEP_NOISES];
    self.recordingLedIndicator.on = [self.userDefaults boolForKey:RECORDING_LED_INDICATOR];
    self.motionDetection.on = [self.userDefaults boolForKey:MOTION_DETECTION];
    self.gSensor.on = [self.userDefaults boolForKey:G_SENSOR];
    self.carPlateStamp.on = [self.userDefaults boolForKey:CAR_PLATE_STAMP];
}



#pragma mark - initPopupTableButtonsActions

- (void)initPopupTableViewButton:(NSMutableArray*) data forKey:(NSString *) key button:(UIButton*) button
{
    PopUpDialogDiligate *diligate = [[PopUpDialogDiligate alloc] init];
    diligate.data = data;
    diligate.key = key;
    [button setTitle:diligate.getCurrentData forState:UIControlStateNormal];
    diligate.button = button;
    
    XDPopupListView * popupListView = [[XDPopupListView alloc] initWithBoundView:button dataSource:diligate delegate:diligate popupType:XDPopupListViewNormal];
    
    [self.popupDialogs setValue:popupListView forKey:key];
    
}


- (IBAction)dateFormatTable:(UIButton *)sender
{
    [(XDPopupListView*)[self.popupDialogs valueForKey:DATE_FORMAT_TABLE] show];
}

- (IBAction)defaultModeCameraStarts:(UIButton *)sender
{
    [(XDPopupListView*)[self.popupDialogs valueForKey:DEFAULT_MODE_CAMERA_STARTS] show];
}

- (IBAction)powerOnAutoRecord:(UIButton *)sender
{
    [(XDPopupListView*)[self.popupDialogs valueForKey:POWER_ON_AUTO_RECORD] show];
}

- (IBAction)standbyTime:(UIButton *)sender
{
    [(XDPopupListView*)[self.popupDialogs valueForKey:STANDBY_TIME] show];
}

- (IBAction)powerOffDisconnect:(UIButton *)sender
{
    [(XDPopupListView*)[self.popupDialogs valueForKey:POWER_OFF_DISCONNECT] show];
}

- (IBAction)motionDetectionSensitivity:(UIButton *)sender
{
    [(XDPopupListView*)[self.popupDialogs valueForKey:MOTION_DETECTION_SENSITIVITY] show];
}

- (IBAction)motionTurnOff:(UIButton *)sender
{
    [(XDPopupListView*)[self.popupDialogs valueForKey:MOTION_TURN_OFF] show];
}

- (IBAction)TVOut:(UIButton *)sender
{
    [(XDPopupListView*)[self.popupDialogs valueForKey:TV_OUT] show];
}

- (IBAction)speedStamp:(UIButton *)sender
{
    [(XDPopupListView*)[self.popupDialogs valueForKey:SPEED_STAMP] show];
}


-(void) initPopupTables
{
    NSMutableArray * dataDateFormatTable = [NSMutableArray arrayWithObjects:@"DD/MM/YYYY", @"YYYY/MM/DD", @"MM/DD/YYYY", nil];
    [self initPopupTableViewButton:dataDateFormatTable forKey:DATE_FORMAT_TABLE button:self.dateFormatTable];
    
    
    NSMutableArray * dataDefaultModeCameraStarts = [NSMutableArray arrayWithObjects:@"Mode 1", @"Mode 2", @"Mode 3", nil];
    
    [self initPopupTableViewButton:dataDefaultModeCameraStarts forKey:DEFAULT_MODE_CAMERA_STARTS button:self.defaultModeCameraStarts];
    
    
    NSMutableArray * powerOnAutoRecord = [NSMutableArray arrayWithObjects:@"Button Only", @"Auto Start", nil];
    
    [self initPopupTableViewButton:powerOnAutoRecord forKey:POWER_ON_AUTO_RECORD button:self.powerOnAutoRecord];
    
    NSMutableArray * standbyTime = [NSMutableArray arrayWithObjects:@"Off", @"15 Seconds", @"30 Seconds", @"1 Minute", @"2 Minutes", @"5 Minutes", nil];
    
    [self initPopupTableViewButton:standbyTime forKey:STANDBY_TIME button:self.standbyTime];
    
    
    NSMutableArray * powerOffDisconnect = [NSMutableArray arrayWithObjects:@"Immediate", @"5 Seconds", nil];
    
    [self initPopupTableViewButton:powerOffDisconnect forKey:POWER_OFF_DISCONNECT button:self.powerOffDisconnect];
    
    
    NSMutableArray * motionDetectionSensitivity = [NSMutableArray arrayWithObjects:@"High", @"Medium", @"Low", nil];
    
    [self initPopupTableViewButton:motionDetectionSensitivity forKey:MOTION_DETECTION_SENSITIVITY button:self.motionDetectionSensitivity];
    
    
    NSMutableArray * motionTurnOff = [NSMutableArray arrayWithObjects:@"5s", @"10s", @"20s", @"30s", @"1 Minute", nil];
    
    [self initPopupTableViewButton:motionTurnOff forKey:MOTION_TURN_OFF button:self.motionTurnOff];
    
    
    NSMutableArray * TVOut = [NSMutableArray arrayWithObjects:@"NTSC", @"PAL", @"16:9", @"16:10", @"4:3", nil];
    
    [self initPopupTableViewButton:TVOut forKey:TV_OUT button:self.TVOut];
    
    NSMutableArray * speedStamp = [NSMutableArray arrayWithObjects:@"MPH", @"KPH", @"Off", nil];
    
    [self initPopupTableViewButton:speedStamp forKey:SPEED_STAMP button:self.speedStamp];
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [cell setBackgroundColor:[UIColor clearColor]];
}


@end