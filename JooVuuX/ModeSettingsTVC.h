//
//  ModeSettingsTVC.h
//  JooVuuX
//
//  Created by Andrey on 11.06.15.
//  Copyright (c) 2015 lsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XDPopupListView.h"
#import "StaticDataTableViewController.h"
#import <QuartzCore/QuartzCore.h>


@interface ModeSettingsTVC : StaticDataTableViewController <UITextFieldDelegate>
{
    Boolean * buttonOneChecked;
    Boolean * buttonTwoChecked;
    Boolean * buttonThreeChecked;
    Boolean * buttonFourChecked;
    BOOL loopRecordingBool;
    BOOL timedModeBool;
    BOOL startTimeBool;
    BOOL stopTimeBool;
}

@property (strong, nonatomic) NSMutableDictionary * popupDialogs;

@property (strong, nonatomic) NSUserDefaults * userDefaults;

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *backgroundView;

@property (strong, nonatomic) IBOutletCollection(UITableViewCell) NSArray *showAndHiddenModeCell;

@property (strong, nonatomic) IBOutletCollection(UITableViewCell) NSArray *showAndHiddenPhotoModeCell;

@property (weak, nonatomic) IBOutlet UITableViewCell *VideoClipLenghtCell;

@property (strong, nonatomic) NSDateFormatter *dateFormatter;



/////////Start and Stop

@property (weak, nonatomic) IBOutlet UITableViewCell *startTimeCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *stopTimeCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *startTimePickerCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *stopTimePickerCell;
@property (weak, nonatomic) IBOutlet UIButton *startTime;
- (IBAction)startTime:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *stopTime;
- (IBAction)stopTime:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIDatePicker *startTimePicker;
- (IBAction)startTimePicker:(UIDatePicker *)sender;
@property (weak, nonatomic) IBOutlet UIDatePicker *stopTimePicker;
- (IBAction)stopTimePicker:(UIDatePicker *)sender;



/////////modeButton
@property (weak, nonatomic) IBOutlet UIButton *modeOneButton;
- (IBAction)modeOneButton:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *modeTwoButton;
- (IBAction)modeTwoButton:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *modeThreeButton;
- (IBAction)modeThreeButton:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *modeFourButton;
- (IBAction)modeFourButton:(UIButton *)sender;

/////////

/////////popupButton

@property (weak, nonatomic) IBOutlet UIButton *videoResolutions;
- (IBAction)videoResolutions:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *videoBitRates;
- (IBAction)videoBitRates:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *videoClipLenght;
- (IBAction)videoClipLenght:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *WDR;
- (IBAction)WDR:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *fieldOfView;
- (IBAction)fieldOfView:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *timeLapseVideo;
- (IBAction)timeLapseVideo:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *artificialLightFrequency;
- (IBAction)artificialLightFrequency:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *burstPhotoMode;
- (IBAction)burstPhotoMode:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *photoResolution;
- (IBAction)photoResolution:(UIButton *)sender;

/////////

////////switch

@property (weak, nonatomic) IBOutlet UISwitch *audio;
- (IBAction)audio:(UISwitch *)sender;

@property (weak, nonatomic) IBOutlet UISwitch *videoTimeStamp;
- (IBAction)videoTimeStamp:(UISwitch *)sender;


@property (weak, nonatomic) IBOutlet UISwitch *rotate180Degrees;
- (IBAction)rotate180Degrees:(UISwitch *)sender;

@property (weak, nonatomic) IBOutlet UISwitch *loopRecording;
- (IBAction)loopRecording:(UISwitch *)sender;

@property (weak, nonatomic) IBOutlet UISwitch *timedMode;
- (IBAction)timedMode:(UISwitch *)sender;

@property (weak, nonatomic) IBOutlet UISwitch *displaySpeed;
- (IBAction)displaySpeed:(UISwitch *)sender;

@property (weak, nonatomic) IBOutlet UISwitch *LDWS;
- (IBAction)LDWS:(UISwitch *)sender;

@property (weak, nonatomic) IBOutlet UISwitch *FDWS;
- (IBAction)FDWS:(UISwitch *)sender;


@property (weak, nonatomic) IBOutlet UISwitch *dateTimestamp;
- (IBAction)dateTimestamp:(UISwitch *)sender;

@property (weak, nonatomic) IBOutlet UISwitch *rotatePhotosDegrees;
- (IBAction)rotatePhotosDegrees:(UISwitch *)sender;

@property (weak, nonatomic) IBOutlet UISwitch *timeLapsePhoto;
- (IBAction)timeLapsePhoto:(UISwitch *)sender;

@property (weak, nonatomic) IBOutlet UISwitch *timeLapseVideoPhotoMode;
- (IBAction)timeLapseVideoPhotoMode:(UISwitch *)sender;








@end
