//
//  ModeSettingsTVC.m
//  JooVuuX
//
//  Created by Andrey on 11.06.15.
//  Copyright (c) 2015 lsoft. All rights reserved.
//

#import "ModeSettingsTVC.h"
#import "NSString+Utils.h"
#import "PopUpDialogDiligate.h"

static NSString * VIDEO_RESOLUTION              = @"videoResolutions";
static NSString * AUDIO                         = @"audio";
static NSString * AUDIO_FOUR                    = @"audioFour";
static NSString * VIDEO_TIME_STAMP              = @"videoTimeStamp";
static NSString * ROTATE_180_DEGREES            = @"rotate180Degrees";
static NSString * LOOP_RECORDING                = @"loopRecording";
static NSString * VIDEO_BIT_RATES               = @"videoBitRates";
static NSString * VIDEO_CLIP_LENGHT             = @"videoClipLenght";
static NSString * WDR                           = @"wdr";
static NSString * FIELD_OF_VIEW                 = @"fieldOfView";
static NSString * TIME_LAPSE_VIDEO              = @"timeLapseVideo";
static NSString * TIMED_MODE                    = @"timedMode";
static NSString * DISPLAY_SPEED                 = @"displaySpeed";
static NSString * BURST_PHOTO_MODE              = @"burstPhotoMode";
static NSString * ARITIFICIAL_LIGHT_FREQUENCY   = @"artificialLightFrequency";
static NSString * LOOP_RECORDING_BOOL           = @"loopRecordingBool";
static NSString * TIMED_MODE_BOOL               = @"timedModeBool";
static NSString * LDWS                          = @"LDWS";
static NSString * FDWS                          = @"FDWS";

static NSString * DATE_TIMESTAMP                = @"dateTimestamp";
static NSString * PHOTO_RESOLUTION              = @"photoResolution";
static NSString * ROTATE_PHOTOS_DEGREES         = @"rotatePhotosDegrees";
static NSString * TIME_LAPSE_PHOTO              = @"timeLapsePhoto";
static NSString * TIME_LAPSE_VIDE_PHOTO_MODE    = @"timeLapseVideoPhotoMode";

static NSString * START_TIME                    = @"startTime";
static NSString * STOP_TIME                     = @"stopTime";


static NSString * MODE1 = @"MODE 1";
static NSString * MODE2 = @"MODE 2";
static NSString * MODE3 = @"MODE 3";

@interface ModeSettingsTVC () 

@property (strong, nonatomic) NSString * currentMode;

@end

@implementation ModeSettingsTVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.startTimePicker setValue:[UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1.0f] forKeyPath:@"textColor"];
    [self.stopTimePicker setValue:[UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1.0f] forKeyPath:@"textColor"];
    [self.startTimePicker setTintColor:[UIColor redColor]];
    
    
    
    
    
    
    
    
    self.currentMode = MODE1;
    
    self.popupDialogs = [[NSMutableDictionary alloc] init];
    self.userDefaults = [NSUserDefaults standardUserDefaults];
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [_modeOneButton setSelected:YES];
    
    [self showModeCellAndHidePhotoModeCell];

    [self.modeOneButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
   
    [self initPopupTables];
    [self setSettingsView];
    [self loadKeyValueSettings];
    
    startTimeBool = NO;
    stopTimeBool = NO;
    
    self.startTimePicker.datePickerMode = UIDatePickerModeTime;
    self.stopTimePicker.datePickerMode = UIDatePickerModeTime;
    
    [self startTimeMethod];
    [self stopTimeMethod];
    
    if (loopRecordingBool) {
        [self cell:self.VideoClipLenghtCell setHidden:NO];
        [self reloadDataAnimated:NO];
    }
    else
    {
        [self cell:self.VideoClipLenghtCell setHidden:YES];
        [self reloadDataAnimated:NO];
    }
    
    if (timedModeBool) {
        [self cell:self.startTimeCell setHidden:NO];
        [self cell:self.stopTimeCell setHidden:NO];
        [self reloadDataAnimated:NO];
    }
    else
    {
        [self cell:self.startTimeCell setHidden:YES];
        [self cell:self.stopTimeCell setHidden:YES];
        [self reloadDataAnimated:NO];
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - setSettingsView

-(void) setSettingsView
{
    
    
    
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:
                                     [UIImage imageNamed:@"background"]];
    
    for (UIView * view in self.backgroundView) {
        
        [view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"beckground-box"]]];
        
    }
    NSDictionary *titleAttributes =@{NSFontAttributeName :[UIFont fontWithName:@"Helvetica-Bold" size:14.0],
                                     NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    [[UINavigationBar appearance] setTitleTextAttributes:
     titleAttributes];
}



#pragma mark - set Button presset

- (void)modeSelected:(UIButton *)selectBtn btn2:(UIButton *)btn2 btn3:(UIButton *)btn3 btn4:(UIButton *)btn4
{
    [selectBtn setBackgroundImage: [UIImage imageNamed:@"mode_pressed"] forState:UIControlStateNormal];
    [selectBtn setSelected:YES];
    [selectBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [btn2 setBackgroundImage:[UIImage imageNamed:@"mode_not_pressed"] forState:UIControlStateNormal];
    [btn2 setSelected:NO];
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [btn3 setBackgroundImage:[UIImage imageNamed:@"mode_not_pressed"] forState:UIControlStateNormal];
    [btn3 setSelected:NO];
    [btn3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [btn4 setBackgroundImage:[UIImage imageNamed:@"mode_not_pressed"] forState:UIControlStateNormal];
    [btn4 setSelected:NO];
    [btn4 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self initPopupTables];
    [self loadKeyValueSettings];
    
}

- (IBAction)modeOneButton:(UIButton *)sender
{
    self.currentMode = MODE1;
    [self modeSelected:_modeOneButton btn2:_modeTwoButton btn3:_modeThreeButton btn4:_modeFourButton];
    [self showModeCellAndHidePhotoModeCell];
    
}

- (IBAction)modeTwoButton:(UIButton *)sender
{
    self.currentMode = MODE2;
    [self modeSelected:_modeTwoButton btn2:_modeOneButton btn3:_modeThreeButton btn4:_modeFourButton];
    [self showModeCellAndHidePhotoModeCell];
    
}

- (IBAction)modeThreeButton:(UIButton *)sender
{
    self.currentMode = MODE3;
    [self modeSelected:_modeThreeButton btn2:_modeOneButton btn3:_modeTwoButton btn4:_modeFourButton];
    [self showModeCellAndHidePhotoModeCell];
}

- (IBAction)modeFourButton:(UIButton *)sender
{
    [self showPhotoModeCellAndHideModeCell];
    [self modeSelected:_modeFourButton btn2:_modeOneButton btn3:_modeTwoButton btn4:_modeThreeButton];
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

-(void) initPopupTables
{
    NSMutableArray * videoResolutions = [NSMutableArray arrayWithObjects:@"2304x1296P 30FPS", @"1920x1080P 60FPS", @"1920x1080P 45FPS",  @"1920x1080P 30FPS HDR",  @"1920X1080P 30FPS",  @"1280x720P 60FPS",  @"1280x720P 30FPS", nil];
    
    [self initPopupTableViewButton:videoResolutions forKey:[VIDEO_RESOLUTION stringByAppendingString:self.currentMode] button:self.videoResolutions];
    

    NSMutableArray * videoBitRates = [NSMutableArray arrayWithObjects:@"30", @"24", @"15", @"10", @"5", nil];
    [self initPopupTableViewButton:videoBitRates forKey:[VIDEO_BIT_RATES stringByAppendingString:self.currentMode] button:self.videoBitRates];
    
    
    NSMutableArray * videoClipLenght = [NSMutableArray arrayWithObjects:@"1", @"2", @"3", @"5", @"10", @"Off", nil];
    [self initPopupTableViewButton:videoClipLenght forKey:[VIDEO_CLIP_LENGHT stringByAppendingString:self.currentMode] button:self.videoClipLenght];
    
    
    NSMutableArray * wdrData = [NSMutableArray arrayWithObjects:@"On", @"Off", @"Low Light", nil];
    [self initPopupTableViewButton:wdrData forKey:[WDR stringByAppendingString:self.currentMode] button:self.WDR];
    
    
    NSMutableArray * fieldOfView = [NSMutableArray arrayWithObjects:@"155", @"140", @"125", @"110", @"90", @"60", nil];
    [self initPopupTableViewButton:fieldOfView forKey:[FIELD_OF_VIEW stringByAppendingString:self.currentMode] button:self.fieldOfView];
    
    
    NSMutableArray * timeLapseVideo = [NSMutableArray arrayWithObjects:@"Off", @"Hours", @"Minutes", @"Seconds", nil];
    [self initPopupTableViewButton:timeLapseVideo forKey:[TIME_LAPSE_VIDEO stringByAppendingString:self.currentMode] button:self.timeLapseVideo];
    
    
    NSMutableArray * artificialLightFrequency = [NSMutableArray arrayWithObjects:@"60 MHZ", @"50 MHZ", nil];
    [self initPopupTableViewButton:artificialLightFrequency forKey:[ARITIFICIAL_LIGHT_FREQUENCY stringByAppendingString:self.currentMode] button:self.artificialLightFrequency];
    
    
    NSMutableArray * burstPhotoMode = [NSMutableArray arrayWithObjects:@"Off", @"5", @"10", nil];
    [self initPopupTableViewButton:burstPhotoMode forKey:[BURST_PHOTO_MODE stringByAppendingString:self.currentMode] button:self.burstPhotoMode];
    
    NSMutableArray * photoResolution = [NSMutableArray arrayWithObjects:@"16M(4608X3456 4:3)", @"13M(4128X3096 4:3)", @"8M(3264X2448  4:3)", @"5M(2560X1920 4:3)", nil];
    [self initPopupTableViewButton:photoResolution forKey:PHOTO_RESOLUTION button:self.photoResolution];
}

#pragma mark - initSwitch

- (IBAction)audio:(UISwitch *)sender
{
    [self.userDefaults setBool:self.audio.isOn forKey:[AUDIO stringByAppendingString:self.currentMode]];
}

- (IBAction)videoTimeStamp:(UISwitch *)sender
{
    [self.userDefaults setBool:self.videoTimeStamp.isOn forKey:[VIDEO_TIME_STAMP stringByAppendingString:self.currentMode]];
}

- (IBAction)rotate180Degrees:(UISwitch *)sender
{
    [self.userDefaults setBool:self.rotate180Degrees.isOn forKey:[ROTATE_180_DEGREES stringByAppendingString:self.currentMode]];
}

- (IBAction)loopRecording:(UISwitch *)sender
{
    [self.userDefaults setBool:self.loopRecording.isOn forKey:[LOOP_RECORDING stringByAppendingString:self.currentMode]];
    
    if (self.loopRecording.isOn) {
        loopRecordingBool = YES;
        [self.userDefaults setBool:loopRecordingBool forKey:[LOOP_RECORDING_BOOL stringByAppendingString:self.currentMode]];
        [self cell:self.VideoClipLenghtCell setHidden:NO];
        [self reloadDataAnimated:YES];
        
    }
    else
    {
        loopRecordingBool = NO;
        [self.userDefaults setBool:loopRecordingBool forKey:[LOOP_RECORDING_BOOL stringByAppendingString:self.currentMode]];
        [self cell:self.VideoClipLenghtCell setHidden:YES];
        [self reloadDataAnimated:YES];
        
    }
}


- (IBAction)displaySpeed:(UISwitch *)sender
{
    [self.userDefaults setBool:self.displaySpeed.isOn forKey:[DISPLAY_SPEED stringByAppendingString:self.currentMode]];
}

- (IBAction)timedMode:(UISwitch *)sender
{
    [self.userDefaults setBool:self.timedMode.isOn forKey:[TIMED_MODE stringByAppendingString:self.currentMode]];
    
    if (self.timedMode.isOn) {
        timedModeBool = YES;
        [self.userDefaults setBool:timedModeBool forKey:[TIMED_MODE_BOOL stringByAppendingString:self.currentMode]];
        [self cell:self.startTimeCell setHidden:NO];
        [self cell:self.stopTimeCell setHidden:NO];
        [self reloadDataAnimated:YES];
        
    }
    else
    {
        timedModeBool = NO;
        startTimeBool = YES;
        stopTimeBool = YES;
        [self.userDefaults setBool:timedModeBool forKey:[TIMED_MODE_BOOL stringByAppendingString:self.currentMode]];
        [self cell:self.startTimeCell setHidden:YES];
        [self cell:self.stopTimeCell setHidden:YES];
        [self cell:self.startTimePickerCell setHidden:YES];
        [self cell:self.stopTimePickerCell setHidden:YES];
        [self reloadDataAnimated:YES];
        
    }
    
    
}

- (IBAction)LDWS:(UISwitch *)sender
{
    [self.userDefaults setBool:self.LDWS.isOn forKey:[LDWS stringByAppendingString:self.currentMode]];
}

- (IBAction)FDWS:(UISwitch *)sender
{
    [self.userDefaults setBool:self.FDWS.isOn forKey:[FDWS stringByAppendingString:self.currentMode]];
}

- (IBAction)dateTimestamp:(UISwitch *)sender
{
    [self.userDefaults setBool:self.dateTimestamp.isOn forKey:DATE_TIMESTAMP];
}

- (IBAction)rotatePhotosDegrees:(UISwitch *)sender
{
    [self.userDefaults setBool:self.rotatePhotosDegrees.isOn forKey:ROTATE_PHOTOS_DEGREES];
}

- (IBAction)timeLapsePhoto:(UISwitch *)sender
{
    [self.userDefaults setBool:self.timeLapsePhoto.isOn forKey:TIME_LAPSE_PHOTO];
}

- (IBAction)timeLapseVideoPhotoMode:(UISwitch *)sender
{
    [self.userDefaults setBool:self.timeLapseVideoPhotoMode.isOn forKey:TIME_LAPSE_VIDE_PHOTO_MODE];
}


-(void) loadKeyValueSettings
{
    self.audio.on = [self.userDefaults boolForKey:[AUDIO stringByAppendingString:self.currentMode]];
    self.videoTimeStamp.on = [self.userDefaults boolForKey:[VIDEO_TIME_STAMP stringByAppendingString:self.currentMode]];
    self.rotate180Degrees.on = [self.userDefaults boolForKey:[ROTATE_180_DEGREES stringByAppendingString:self.currentMode]];
    self.loopRecording.on = [self.userDefaults boolForKey:[LOOP_RECORDING stringByAppendingString:self.currentMode]];
    self.displaySpeed.on = [self.userDefaults boolForKey:[DISPLAY_SPEED stringByAppendingString:self.currentMode]];
    self.timedMode.on = [self.userDefaults boolForKey:[TIMED_MODE stringByAppendingString:self.currentMode]];
    self.LDWS.on = [self.userDefaults boolForKey:[LDWS stringByAppendingString:self.currentMode]];
    self.FDWS.on = [self.userDefaults boolForKey:[FDWS stringByAppendingString:self.currentMode]];
    self.dateTimestamp.on = [self.userDefaults boolForKey:DATE_TIMESTAMP];
    self.rotatePhotosDegrees.on = [self.userDefaults boolForKey:ROTATE_PHOTOS_DEGREES];
    self.timeLapsePhoto.on = [self.userDefaults boolForKey:TIME_LAPSE_PHOTO];
    self.timeLapseVideoPhotoMode.on = [self.userDefaults boolForKey:TIME_LAPSE_VIDE_PHOTO_MODE];
    
    
    loopRecordingBool = [self.userDefaults boolForKey:[LOOP_RECORDING_BOOL stringByAppendingString:self.currentMode]];
    timedModeBool = [self.userDefaults boolForKey:[TIMED_MODE_BOOL stringByAppendingString:self.currentMode]];
    
    
    if ([self.userDefaults objectForKey:[START_TIME stringByAppendingString:self.currentMode]]) {
        [self.dateFormatter setDateFormat:@"hh:mm a"];
        [self.startTime setTitle:[self.dateFormatter stringFromDate:[self.userDefaults objectForKey:[START_TIME stringByAppendingString:self.currentMode]]] forState:UIControlStateNormal];
        self.startTimePicker.date = [self.userDefaults objectForKey:[START_TIME stringByAppendingString:self.currentMode]];
    }
    if ([self.userDefaults objectForKey:[STOP_TIME stringByAppendingString:self.currentMode]]) {
        [self.dateFormatter setDateFormat:@"hh:mm a"];
        [self.stopTime setTitle:[self.dateFormatter stringFromDate:[self.userDefaults objectForKey:[STOP_TIME stringByAppendingString:self.currentMode]]] forState:UIControlStateNormal];
        self.stopTimePicker.date = [self.userDefaults objectForKey:[STOP_TIME stringByAppendingString:self.currentMode]];
    }
    
    
    
}

#pragma mark - initPopupButton


- (IBAction)videoResolutions:(UIButton *)sender
{
    [(XDPopupListView*)[self.popupDialogs valueForKey:[VIDEO_RESOLUTION stringByAppendingString:self.currentMode]] show];
}


- (IBAction)videoBitRates:(UIButton *)sender
{
    [(XDPopupListView*)[self.popupDialogs valueForKey:[VIDEO_BIT_RATES stringByAppendingString:self.currentMode]] show];
}


- (IBAction)videoClipLenght:(UIButton *)sender
{
    [(XDPopupListView*)[self.popupDialogs valueForKey:[VIDEO_CLIP_LENGHT stringByAppendingString:self.currentMode]] show];
}


- (IBAction)WDR:(UIButton *)sender
{
    [(XDPopupListView*)[self.popupDialogs valueForKey:[WDR stringByAppendingString:self.currentMode]] show];
}


- (IBAction)fieldOfView:(UIButton *)sender
{
    [(XDPopupListView*)[self.popupDialogs valueForKey:[FIELD_OF_VIEW stringByAppendingString:self.currentMode]] show];
}


- (IBAction)timeLapseVideo:(UIButton *)sender
{
    [(XDPopupListView*)[self.popupDialogs valueForKey:[TIME_LAPSE_VIDEO stringByAppendingString:self.currentMode]] show];
}

- (IBAction)artificialLightFrequency:(UIButton *)sender
{
    [(XDPopupListView*)[self.popupDialogs valueForKey:[ARITIFICIAL_LIGHT_FREQUENCY stringByAppendingString:self.currentMode]] show];
}


- (IBAction)burstPhotoMode:(UIButton *)sender
{
    [(XDPopupListView*)[self.popupDialogs valueForKey:[BURST_PHOTO_MODE stringByAppendingString:self.currentMode]] show];
}

- (IBAction)photoResolution:(UIButton *)sender
{
    [(XDPopupListView*)[self.popupDialogs valueForKey:PHOTO_RESOLUTION] show];
}





-(void) showPhotoModeCellAndHideModeCell
{
    for (UITableViewCell * cell in self.showAndHiddenPhotoModeCell) {
        [self cell:cell setHidden:NO];
        [self reloadDataAnimated:NO];
        
    }
    
    for (UITableViewCell * cell in self.showAndHiddenModeCell) {
        [self cell:cell setHidden:YES];
        [self reloadDataAnimated:NO];
        
    }
}

-(void) showModeCellAndHidePhotoModeCell
{
    
    for (UITableViewCell * cell in self.showAndHiddenModeCell) {
        [self cell:cell setHidden:NO];
        [self reloadDataAnimated:NO];
        
    }
    
    for (UITableViewCell * cell in self.showAndHiddenPhotoModeCell) {
        [self cell:cell setHidden:YES];
        [self reloadDataAnimated:NO];
        
    }

}


- (IBAction)startTime:(UIButton *)sender {
    
    [self startTimeMethod];
    
    if ([self.userDefaults objectForKey:[START_TIME stringByAppendingString:self.currentMode]]) {
        [self.dateFormatter setDateFormat:@"hh:mm a"];
        [self.startTime setTitle:[self.dateFormatter stringFromDate:[self.userDefaults objectForKey:[START_TIME stringByAppendingString:self.currentMode]]] forState:UIControlStateNormal];
    }

    
    
}

- (IBAction)stopTime:(UIButton *)sender {
    
    [self stopTimeMethod];
    
    if ([self.userDefaults objectForKey:[STOP_TIME stringByAppendingString:self.currentMode]]) {
        [self.dateFormatter setDateFormat:@"hh:mm a"];
        [self.stopTime setTitle:[self.dateFormatter stringFromDate:[self.userDefaults objectForKey:[STOP_TIME stringByAppendingString:self.currentMode]]] forState:UIControlStateNormal];
    }
    
}

-(void) startTimeMethod
{
    if (startTimeBool) {
        startTimeBool = NO;
        stopTimeBool = YES;
        [self cell:self.startTimePickerCell setHidden:NO];
        [self cell:self.stopTimePickerCell setHidden:YES];
        [self reloadDataAnimated:YES];
    }
    else
    {   startTimeBool = YES;
        [self cell:self.startTimePickerCell setHidden:YES];
        [self reloadDataAnimated:YES];

    }
    
    
    
}

-(void) stopTimeMethod
{
    if (stopTimeBool) {
        stopTimeBool = NO;
        startTimeBool = YES;
        [self cell:self.stopTimePickerCell setHidden:NO];
        [self cell:self.startTimePickerCell setHidden:YES];

        [self reloadDataAnimated:YES];
        
    }
    else
    {
        stopTimeBool = YES;
        [self cell:self.stopTimePickerCell setHidden:YES];

        [self reloadDataAnimated:YES];
        
        
        
    }
}

- (IBAction)startTimePicker:(UIDatePicker *)sender {
    
    [self.dateFormatter setDateFormat:@"hh:mm a"];
    [self.userDefaults setObject:self.startTimePicker.date forKey:[START_TIME stringByAppendingString:self.currentMode]];
    [self.startTime setTitle:@"Done" forState:UIControlStateNormal];

    
    
}
- (IBAction)stopTimePicker:(UIDatePicker *)sender {
    
    [self.dateFormatter setDateFormat:@"hh:mm a"];
    [self.userDefaults setObject:self.stopTimePicker.date forKey:[STOP_TIME stringByAppendingString:self.currentMode]];
    [self.stopTime setTitle:@"Done" forState:UIControlStateNormal];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [cell setBackgroundColor:[UIColor clearColor]];
}

@end
