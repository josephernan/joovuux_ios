//
//  MainSettingsVC.m
//  JooVuuX
//
//  Created by Vladislav on 28.09.15.
//  Copyright (c) 2015 lsoft. All rights reserved.
//

#import "MainSettingsVC.h"
#import "SettingsTVC.h"
#import "NSString+Utils.h"
#import "PopUpDialogDiligate.h"
#import "CameraManager.h"
#import "AppDelegate.h"

@interface MainSettingsVC () <UITableViewDelegate, UITableViewDataSource, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate>

{
    BOOL dateFormatCheck;
    BOOL beepNoisesCheck;
    BOOL recordLEDCheck;
    BOOL modeCheck;
    BOOL powerOnCheck;
    BOOL standByCheck;
    BOOL motionDetectionCheck;
    BOOL motionDSCheck;
    BOOL TVOutCheck;
    BOOL GSensorCheck;
    BOOL GSensorSCheck;
    BOOL carPlateStampCheck;
    BOOL speedStampCheck;
    BOOL timeModeCheck;
    BOOL speedUnitCheck;
    BOOL powerOffDisconnectCheck;
    BOOL lowBatteryWarningCheck;
}
@property (nonatomic,retain) AppDelegate *appDelegate;
@property(strong, nonatomic)UIView * bgrdResetView;

@property (strong, nonatomic)UILabel* label;
@property (strong, nonatomic)UIView* backgroudView;

@property (strong, nonatomic)UIView *viewPickerCameraTime;
@property (strong, nonatomic)UIView *viewPickerFromTime;
@property (strong, nonatomic)UIView *viewPickerToTime;

@property(strong, nonatomic)UIDatePicker* datePicker;
@property (strong, nonatomic)CALayer *bottomBorder;


@property (strong, nonatomic) NSArray * timeArray;
@property (strong, nonatomic) UIPickerView * timePicker;
@property (strong, nonatomic) NSString * fromTime;

@property (strong, nonatomic) UIButton *okCameraTimeButton;

@property (strong, nonatomic) NSArray * chineSymbolArray;

@end

@implementation MainSettingsVC


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
     [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self interfaceOrient];

    self.timeArray = [NSArray new];
    self.timeArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24"];

    self.chineSymbolArray = [NSArray new];
    self.chineSymbolArray = @[@"丶",@"丿",@"乙",@"乚",@"亅",@"二",@"亠",@"人",@"儿",@"亻",@"入",@"八",@"冂",@"冖",@"冫",@"几",@"凵",@"刀",@"力",@"勹",@"匕",@"匚",@"匸",@"十",@"刂",@"士",@"夂",@"夊",@"夕",@"大",@"女",@"子",@"宀",@"寸",@"小",@"⺌",@"⺍",@"尢",@"尣",@"尸",@"屮",@"山",@"巛",@"川",@"巜",@"工",@"己",@"已",@"巳",@"巾",@"干",@"幺",@"广",@"廴",@"廾",@"弋",@"弓",@"彐",@"彑",@"彡",@"彳",@"心",@"忄",@"⺗",@"戈",@"户",@"戸",@"戶",@"手",@"扌",@"龵",@"支",@"攴",@"攵",@"文",@"斗",@"斤",@"方",@"无",@"日",@"曰",@"月",@"木",@"欠",@"止",@"歹",@"歺",@"殳",@"毋",@"比",@"毛",@"氏",@"气",@"水",@"氵",@"氺",@"火",@"灬",@"爪",@"爫",@"父",@"爻",@"爿",@"丬",@"片",@"牙",@"牛",@"⺧",@"犬",@"犭",@"玄",@"玉",@"瓜",@"瓦",@"甘",@"生",@"用",@"甩",@"田",@"疋",@"⺪",@"疒",@"癶",@"白",@"皮",@"皿",@"目",@"矛",@"矢",@"石",@"示",@"礻",@"禸",@"禾",@"穴",@"立",@"竹",@"⺮",@"米",@"糸",@"糹",@"纟",@"缶",@"网",@"罒",@"罓",@"⺳",@"羊",@"⺶",@"⺷",@"羽",@"老",@"耂",@"而",@"耒",@"耳",@"聿",@"⺻",@"肀",@"肉",@"⺼",@"臣",@"自",@"至",@"臼",@"舌",@"舛",@"舟",@"艮",@"色",@"艸",@"艹",@"虍",@"虫",@"血",@"行",@"衣",@"衤",@"襾",@"西",@"覀",@"見",@"见",@"角",@"言",@"訁",@"讠",@"谷",@"豆",@"豕",@"豸",@"貝",@"贝",@"赤",@"走",@"赱",@"足",@"⻊",@"身",@"車",@"车",@"辛",@"辰",@"辵",@"辶",@"⻌",@"⻍",@"邑",@"阝",@"酉",@"釆",@"里",@"金",@"釒",@"钅",@"長",@"镸",@"长",@"門",@"门",@"阜",@"阝",@"隶",@"隹",@"雨",@"青",@"靑",@"非",@"面",@"靣",@"革",@"韋",@"韦",@"韭",@"音",@"頁",@"页",@"風",@"风",@"飛",@"飞",@"食",@"飠",@"饣",@"首",@"香",@"馬",@"马",@"骨",@"高",@"髙",@"髟",@"鬥",@"斗",@"鬯",@"鬲",@"鬼",@"魚",@"鱼",@"鳥",@"鸟",@"鹵",@"卤",@"鹿",@"麥",@"麦",@"麻",@"黃",@"黍",@"黑",@"黹",@"黽",@"黾",@"鼎",@"鼓",@"鼠",@"鼻",@"齊",@"齐",@"齒",@"齿",@"龍",@"龙",@"龜",@"龟",@"頁"];

    
    
    self.appDelegate = [[UIApplication sharedApplication] delegate];
    for (UITableViewCell * cell in self.DateFormatCollection) {
        [self cell:cell setHidden:YES];
        [self reloadDataAnimated:NO];
        dateFormatCheck = YES;
    }
    
    for (UITableViewCell * cell in self.DefaultModeCollection) {
        [self cell:cell setHidden:YES];
        [self reloadDataAnimated:NO];
        modeCheck = YES;
    }
    
    for (UITableViewCell * cell in self.PowerOnAutoCollection) {
        [self cell:cell setHidden:YES];
        [self reloadDataAnimated:NO];
        powerOnCheck = YES;
    }
    
    for (UITableViewCell * cell in self.StandByCollection) {
        [self cell:cell setHidden:YES];
        [self reloadDataAnimated:NO];
        standByCheck = YES;
    }
    
    for (UITableViewCell * cell in self.MotionDSCollection) {
        [self cell:cell setHidden:YES];
        [self reloadDataAnimated:NO];
        motionDSCheck = YES;
    }
    
    for (UITableViewCell * cell in self.TVOutCollection) {
        [self cell:cell setHidden:YES];
        [self reloadDataAnimated:NO];
        TVOutCheck = YES;
    }
    
    for (UITableViewCell * cell in self.GSensorSCollection) {
        [self cell:cell setHidden:YES];
        [self reloadDataAnimated:NO];
        GSensorSCheck = YES;
    }
    
    for (UITableViewCell * cell in self.timeModeCell) {
        [self cell:cell setHidden:YES];
        [self reloadDataAnimated:NO];
        timeModeCheck = YES;
    }
    
    for (UITableViewCell * cell in self.speedUnitCollection) {
        [self cell:cell setHidden:YES];
        [self reloadDataAnimated:NO];
        speedUnitCheck = YES;
    }
    
    for (UITableViewCell * cell in self.powerOffDisconnectCollection) {
        [self cell:cell setHidden:YES];
        [self reloadDataAnimated:NO];
        powerOffDisconnectCheck = YES;
    }
    
    [self cell:self.motionDetectionCell setHidden:YES];
    motionDetectionCheck = YES;
    [self cell:self.carNumberCell setHidden:YES];
    carPlateStampCheck = YES;
    [self cell:self.speedUnitCell setHidden:YES];
    speedUnitCheck = YES;
    [self cell:self.GSensorCell setHidden:YES];
    GSensorCheck = YES;
    
    [self reloadDataAnimated:NO];
    
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [self.resetAllSettings addTarget:self action:@selector(resetSettingsButtonHighlight:) forControlEvents:UIControlEventTouchDown];
    [self.resetAllSettings addTarget:self action:@selector(resetSettingsButton:) forControlEvents:UIControlEventTouchDragOutside];
  
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startIndicator) name:@"startActivity" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stopIndicator) name:@"stopActivity" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(alertCamera21) name:@"camera21" object:nil];
    //if ([[NSUserDefaults standardUserDefaults] boolForKey:@"firstOpenMainSettingsKEY"]) {
        [self loadAllSettings];
    //}
}

-(void)alertCamera21
{
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Camera is recording now, the setting has not been set on the camera" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alertView show];
}

-(void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
     [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self saveAllSettings];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) saveAllSettings
{
    if ([self.appDelegate isConnected]) {
        if ([[[CameraManager cameraManager] allSettingsDict] isKindOfClass:[NSMutableDictionary class]]) {
            NSArray * dict = [[NSArray alloc] init];
            @try {
                dict = @[
                         @{@"speed_unit":self.speedUnitDestinationLabel.text},
                         @{@"motion_det_sens":self.motionDetectionSensDestinationLabel.text},
                         @{@"standby_time":self.standByDestinationLabel.text},
                         @{@"spinnerPowerOnAutoRecord":self.powerOnDestinationLabel.text},
                         @{@"default_mode":self.defaultModeDestinationLabel.text},
                         @{@"data_format":self.dateFormatLabelDestination.text},
                         @{@"time_mode_start_time":self.fromTimeLabel.text},
                         @{@"time_mode_finish_time":self.toTimeLabel.text},
                         @{@"toggleCarNumber":self.carNumberTextField.text},
                         @{@"wifi_password":self.WiFiPasswordTextField.text},
                         @{@"motion_detection":motionDetectionCheck?@"off":@"on"},
                         @{@"g_sensor":GSensorCheck?@"off":@"on"},
                         @{@"car_plate_stamp":carPlateStampCheck?@"off":@"on"},
                         @{@"speed_stamp":speedStampCheck?@"on":@"off"},
                         @{@"time_mode":timeModeCheck?@"off":@"on"},
                         @{@"toggleBeepNoises":beepNoisesCheck?@"on":@"off"},
                         @{@"toggleRecordingLEDindicator":recordLEDCheck?@"off":@"on"},
                         @{@"power_off_disconnect":self.PoweroffDisconnectDestinationLabel.text},
                         @{@"low_battery_warning":lowBatteryWarningCheck?@"on":@"off"},
                         ];
                
                [[[CameraManager cameraManager] allSettingsDict] setObject:dict forKey:@"mainSettings"];
            }
            @catch (NSException * __unused exception) {}
            
        }
       
    }
}

-(void) loadAllSettings
{
    NSMutableDictionary * settings = [NSMutableDictionary new];
    NSMutableArray * array = [NSMutableArray new];
    array = [[[CameraManager cameraManager] allSettingsDict] valueForKey:@"mainSettings"];
    
    for (int i = 0; i < array.count; i++) {
        NSDictionary * obj = [array objectAtIndex:i];
        [settings setValuesForKeysWithDictionary:obj];
    }

    
    self.speedUnitDestinationLabel.text = [settings valueForKey:@"speed_unit"];
   
    
    //self.GSensorDestinationLabel.text =
    //self.TVOutDestinationLabel.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"TVOutDestinationLabel"];
    
    
    self.motionDetectionSensDestinationLabel.text = [settings valueForKey:@"motion_det_sens"];
    self.standByDestinationLabel.text = [settings valueForKey:@"standby_time"];
    self.powerOnDestinationLabel.text = [settings valueForKey:@"spinnerPowerOnAutoRecord"];
    self.PoweroffDisconnectDestinationLabel.text = [settings valueForKey:@"power_off_disconnect"];
    self.defaultModeDestinationLabel.text = [settings valueForKey:@"default_mode"];
    self.dateFormatLabelDestination.text = [settings valueForKey:@"data_format"];
    self.fromTimeLabel.text = [settings valueForKey:@"time_mode_start_time"];
    self.toTimeLabel.text = [settings valueForKey:@"time_mode_finish_time"];
    self.carNumberTextField.text = [settings valueForKey:@"toggleCarNumber"];
    self.WiFiPasswordTextField.text = [settings valueForKey:@"wifi_password"];
    
    //    syncCheck = [[NSUserDefaults standardUserDefaults] boolForKey:@"syncCheck"];
    if (![[settings valueForKey:@"motion_detection"] isEqualToString:@"on"]) {
        motionDetectionCheck = YES;
    }
    else
    {
        motionDetectionCheck = NO;
    }

    if (![[settings valueForKey:@"g_sensor"] isEqualToString:@"on"]) {
        GSensorCheck = YES;
    }
    else
    {
        GSensorCheck = NO;
    }
    
    if (![[settings valueForKey:@"car_plate_stamp"] isEqualToString:@"on"]) {
        carPlateStampCheck = YES;
    }
    else
    {
        carPlateStampCheck = NO;
    }
    
    if (![[settings valueForKey:@"speed_stamp"] isEqualToString:@"on"]) {
        speedStampCheck = NO;
    }
    else
    {
        speedStampCheck = YES;
    }
    
    if (![[settings valueForKey:@"time_mode"] isEqualToString:@"on"]) {
        timeModeCheck = YES;
    }
    else
    {
        timeModeCheck = NO;
    }

    
    if (![[settings valueForKey:@"toggleBeepNoises"] isEqualToString:@"on"]) {
        beepNoisesCheck = NO;
    }
    else
    {
        beepNoisesCheck = YES;
    }
    
    if (![[settings valueForKey:@"toggleRecordingLEDindicator"] isEqualToString:@"on"]) {
        recordLEDCheck = YES;
    }
    else
    {
        recordLEDCheck = NO;
    }

    if (![[settings valueForKey:@"low_battery_warning"] isEqualToString:@"on"]) {
        lowBatteryWarningCheck = NO;
    }
    else
    {
        lowBatteryWarningCheck = YES;
    }

    if (!motionDetectionCheck) {
        [self.motionDetection setTitle:@"ON" forState:UIControlStateNormal];
        [self.motionDetection setBackgroundColor:[UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1]];
        [self cell:self.motionDetectionCell setHidden:NO];
    }else
    {
        for (UITableViewCell * cell in self.MotionDSCollection) {
            [self cell:cell setHidden:YES];
        }
        [self.motionDetection setTitle:@"OFF" forState:UIControlStateNormal];
        [self.motionDetection setBackgroundColor:[UIColor colorWithRed:166/256.0 green:166/256.0 blue:166/256.0 alpha:1]];
    }

    if (!GSensorCheck)
    {
        [self cell:self.GSensorCell setHidden:NO];
        [self.GSensor setTitle:@"ON" forState:UIControlStateNormal];
        [self.GSensor setBackgroundColor:[UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1]];

    }else
    {
        [self cell:self.GSensorCell setHidden:YES];
        [self.GSensor setTitle:@"OFF" forState:UIControlStateNormal];
        [self.GSensor setBackgroundColor:[UIColor colorWithRed:166/256.0 green:166/256.0 blue:166/256.0 alpha:1]];
        for (UITableViewCell * cell in self.GSensorSCollection) {
            [self cell:cell setHidden:YES];
        }
    }

    if (!carPlateStampCheck)
    {
        [self cell:self.carNumberCell setHidden:NO];
        [self.carPlateStamp setTitle:@"ON" forState:UIControlStateNormal];
        [self.carPlateStamp setBackgroundColor:[UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1]];
    }else
    {
        [self cell:self.carNumberCell setHidden:YES];
        [self.carPlateStamp setTitle:@"OFF" forState:UIControlStateNormal];
        [self.carPlateStamp setBackgroundColor:[UIColor colorWithRed:166/256.0 green:166/256.0 blue:166/256.0 alpha:1]];
    }
    
    if (!speedStampCheck) {
        [self cell:self.speedUnitCell setHidden:YES];
        [self.speedStamp setTitle:@"OFF" forState:UIControlStateNormal];
        [self.speedStamp setBackgroundColor:[UIColor colorWithRed:166/256.0 green:166/256.0 blue:166/256.0 alpha:1]];
        for (UITableViewCell * cell in self.speedUnitCollection) {
            [self cell:cell setHidden:YES];
        }
    }else
    {
        [self cell:self.speedUnitCell setHidden:NO];
        [self.speedStamp setTitle:@"ON" forState:UIControlStateNormal];
        [self.speedStamp setBackgroundColor:[UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1]];
    }
    
    if (!timeModeCheck)
    {
        for (UITableViewCell * cell in self.timeModeCell) {
            [self cell:cell setHidden:NO];
        }
        [self.timeMode setTitle:@"ON" forState:UIControlStateNormal];
        [self.timeMode setBackgroundColor:[UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1]];

    }else
    {
        for (UITableViewCell * cell in self.timeModeCell) {
            [self cell:cell setHidden:YES];
        }
        [self.timeMode setTitle:@"OFF" forState:UIControlStateNormal];
        [self.timeMode setBackgroundColor:[UIColor colorWithRed:166/256.0 green:166/256.0 blue:166/256.0 alpha:1]];
    }
    
    if (!beepNoisesCheck) {
        [self.beepNioses setTitle:@"OFF" forState:UIControlStateNormal];
        [self.beepNioses setBackgroundColor:[UIColor colorWithRed:166/256.0 green:166/256.0 blue:166/256.0 alpha:1]];

    }else
    {
        [self.beepNioses setTitle:@"ON" forState:UIControlStateNormal];
        [self.beepNioses setBackgroundColor:[UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1]];
    }
    
    if (!recordLEDCheck)
    {
        [self.recordingLED setTitle:@"ON" forState:UIControlStateNormal];
        [self.recordingLED setBackgroundColor:[UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1]];
    }else
    {
        [self.recordingLED setTitle:@"OFF" forState:UIControlStateNormal];
        [self.recordingLED setBackgroundColor:[UIColor colorWithRed:166/256.0 green:166/256.0 blue:166/256.0 alpha:1]];
    }
    
    [self reloadDataAnimated:NO];
}


-(void) alertResetSettings
{
    UIAlertView *subAlert = [[UIAlertView alloc] initWithTitle:@""
                                                       message:@"Reset Settings Did Complete Successfully."
                                                      delegate:self
                                             cancelButtonTitle:@"Close"
                                             otherButtonTitles:nil];
    
    [subAlert show];
}


//-(void) showSyncDateAndTime
//{
//    if (!syncCheck) {
//        NSDate *today = [NSDate date];
//        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//        [dateFormatter setDateFormat:@"yyyyMMdd_HHmmss"];
//        NSString *currentTime = [dateFormatter stringFromDate:today];
//        [[CameraManager cameraManager] params:currentTime type:@"toggleSyncFateAndTime"];
//        [self cell:self.syncDateAndTimeCell setHidden:YES];
//        [self reloadDataAnimated:YES];
//        [self.syncDateAndTimeButton setTitle:@"ON" forState:UIControlStateNormal];
//        [self.syncDateAndTimeButton setBackgroundColor:[UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1]];
//        
//        syncCheck = YES;
//        
//    }else {
//        
//        [self cell:self.syncDateAndTimeCell setHidden:NO];
//        [self reloadDataAnimated:YES];
//        syncCheck = NO;
//        [self.syncDateAndTimeButton setTitle:@"OFF" forState:UIControlStateNormal];
//        [self.syncDateAndTimeButton setBackgroundColor:[UIColor colorWithRed:166/256.0 green:166/256.0 blue:166/256.0 alpha:1]];
//    }
//}



-(void) showDateFormatCollection
{
    if (dateFormatCheck) {
        for (UITableViewCell * cell in self.DateFormatCollection) {
            [self cell:cell setHidden:NO];
            [self reloadDataAnimated:YES];
            dateFormatCheck = NO;
            
        }
    } else {
        
        for (UITableViewCell * cell in self.DateFormatCollection) {
            [self cell:cell setHidden:YES];
            [self reloadDataAnimated:YES];
            dateFormatCheck = YES;
            
        }
    }
}

-(void) showBeepNoises
{
    if (!beepNoisesCheck) {
        [[CameraManager cameraManager] params:@"on" type:@"toggleBeepNoises"];
        [self.beepNioses setTitle:@"ON" forState:UIControlStateNormal];
        [self.beepNioses setBackgroundColor:[UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1]];
        beepNoisesCheck = YES;
        
    }
    else {
        [[CameraManager cameraManager] params:@"off" type:@"toggleBeepNoises"];
        [self.beepNioses setTitle:@"OFF" forState:UIControlStateNormal];
        [self.beepNioses setBackgroundColor:[UIColor colorWithRed:166/256.0 green:166/256.0 blue:166/256.0 alpha:1]];
        beepNoisesCheck = NO;
    }
}


-(void) showRecordLed
{
    if (!recordLEDCheck) {
        [[CameraManager cameraManager] params:@"off" type:@"toggleRecordingLEDindicator"];
        [self.recordingLED setTitle:@"OFF" forState:UIControlStateNormal];
        [self.recordingLED setBackgroundColor:[UIColor colorWithRed:166/256.0 green:166/256.0 blue:166/256.0 alpha:1]];
        recordLEDCheck = YES;
        
    }else {
        [[CameraManager cameraManager] params:@"on" type:@"toggleRecordingLEDindicator"];
        [self.recordingLED setTitle:@"ON" forState:UIControlStateNormal];
        [self.recordingLED setBackgroundColor:[UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1]];
        recordLEDCheck = NO;
    }
}

-(void) showMotionDetection
{
    if (!motionDetectionCheck) {
        [[CameraManager cameraManager] params:@"off" type:@"motion_detection"];
        [self cell:self.motionDetectionCell setHidden:YES];
        [self reloadDataAnimated:YES];
        motionDetectionCheck = YES;
        [self.motionDetection setTitle:@"OFF" forState:UIControlStateNormal];
        [self.motionDetection setBackgroundColor:[UIColor colorWithRed:166/256.0 green:166/256.0 blue:166/256.0 alpha:1]];
        for (UITableViewCell * cell in self.MotionDSCollection) {
            [self cell:cell setHidden:YES];
            [self reloadDataAnimated:YES];
            motionDSCheck = YES;
        }
        
    } else {
        [[CameraManager cameraManager] params:@"on" type:@"motion_detection"];
        [self cell:self.motionDetectionCell setHidden:NO];
        [self reloadDataAnimated:YES];
        [self.motionDetection setTitle:@"ON" forState:UIControlStateNormal];
        [self.motionDetection setBackgroundColor:[UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1]];
        motionDetectionCheck = NO;
    }
}



-(void) showDefaultModeCollection
{
    if (modeCheck) {
        for (UITableViewCell * cell in self.DefaultModeCollection) {
            [self cell:cell setHidden:NO];
            [self reloadDataAnimated:YES];
            modeCheck = NO;
            
        }
    } else {
        
        for (UITableViewCell * cell in self.DefaultModeCollection) {
            [self cell:cell setHidden:YES];
            [self reloadDataAnimated:YES];
            modeCheck = YES;
            
        }
    }
}

-(void) showPowerOnAutoCollection
{
    if (powerOnCheck) {
        for (UITableViewCell * cell in self.PowerOnAutoCollection) {
            [self cell:cell setHidden:NO];
            [self reloadDataAnimated:YES];
            powerOnCheck = NO;
            
        }
    } else {
        
        for (UITableViewCell * cell in self.PowerOnAutoCollection) {
            [self cell:cell setHidden:YES];
            [self reloadDataAnimated:YES];
            powerOnCheck = YES;
            
        }
    }
}


-(void) showStandByCollection
{
    if (standByCheck) {
        for (UITableViewCell * cell in self.StandByCollection) {
            [self cell:cell setHidden:NO];
            [self reloadDataAnimated:YES];
            standByCheck = NO;
            
        }
    } else {
        
        for (UITableViewCell * cell in self.StandByCollection) {
            [self cell:cell setHidden:YES];
            [self reloadDataAnimated:YES];
            standByCheck = YES;
            
        }
    }
}

-(void) showMotionDSCollection
{
    if (motionDSCheck) {
        for (UITableViewCell * cell in self.MotionDSCollection) {
            [self cell:cell setHidden:NO];
            [self reloadDataAnimated:YES];
            motionDSCheck = NO;
            
        }
    } else {
        
        for (UITableViewCell * cell in self.MotionDSCollection) {
            [self cell:cell setHidden:YES];
            [self reloadDataAnimated:YES];
            motionDSCheck = YES;
            
        }
    }
}

-(void) showTVOutCollection
{
    if (TVOutCheck) {
        for (UITableViewCell * cell in self.TVOutCollection) {
            [self cell:cell setHidden:NO];
            [self reloadDataAnimated:YES];
            TVOutCheck = NO;
            
        }
    } else {
        
        for (UITableViewCell * cell in self.TVOutCollection) {
            [self cell:cell setHidden:YES];
            [self reloadDataAnimated:YES];
            TVOutCheck = YES;
            
        }
    }
}


-(void) showGSensor
{
    if (!GSensorCheck) {
        [[CameraManager cameraManager] params:@"off" type:@"g_sensor"];
        [self cell:self.GSensorCell setHidden:YES];
        [self reloadDataAnimated:YES];
        [self.GSensor setTitle:@"OFF" forState:UIControlStateNormal];
        [self.GSensor setBackgroundColor:[UIColor colorWithRed:166/256.0 green:166/256.0 blue:166/256.0 alpha:1]];
        GSensorCheck = YES;
        for (UITableViewCell * cell in self.GSensorSCollection) {
            [self cell:cell setHidden:YES];
            [self reloadDataAnimated:YES];
            GSensorSCheck = YES;
        }
        
    }else {
        [[CameraManager cameraManager] params:@"on" type:@"g_sensor"];
        [self cell:self.GSensorCell setHidden:NO];
        [self reloadDataAnimated:YES];
        [self.GSensor setTitle:@"ON" forState:UIControlStateNormal];
        [self.GSensor setBackgroundColor:[UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1]];
        GSensorCheck = NO;
        
    }
}


-(void) showGSensorSCollection
{
    if (GSensorSCheck) {
        for (UITableViewCell * cell in self.GSensorSCollection) {
            [self cell:cell setHidden:NO];
            [self reloadDataAnimated:YES];
            GSensorSCheck = NO;
            
        }
    } else {
        
        for (UITableViewCell * cell in self.GSensorSCollection) {
            [self cell:cell setHidden:YES];
            [self reloadDataAnimated:YES];
            GSensorSCheck = YES;
            
        }
    }
}

-(void) showTimeModeCollection
{
    if (timeModeCheck) {
        for (UITableViewCell * cell in self.timeModeCell) {
            [self cell:cell setHidden:NO];
            [self reloadDataAnimated:YES];
    }
            [[CameraManager cameraManager] params:@"on" type:@"time_mode"];
            [self.timeMode setTitle:@"ON" forState:UIControlStateNormal];
            [self.timeMode setBackgroundColor:[UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1]];
            timeModeCheck = NO;
        
        
    } else {
        
        for (UITableViewCell * cell in self.timeModeCell) {
            [self cell:cell setHidden:YES];
            [self reloadDataAnimated:YES];
        }
            [[CameraManager cameraManager] params:@"off" type:@"time_mode"];
            [self.timeMode setTitle:@"OFF" forState:UIControlStateNormal];
            [self.timeMode setBackgroundColor:[UIColor colorWithRed:166/256.0 green:166/256.0 blue:166/256.0 alpha:1]];
            timeModeCheck = YES;
        
        
    }
}


-(void) showSpeedUnitCollection
{
    if (speedUnitCheck) {
        for (UITableViewCell * cell in self.speedUnitCollection) {
            [self cell:cell setHidden:NO];
            [self reloadDataAnimated:YES];
            speedUnitCheck = NO;
            
        }
    } else {
        
        for (UITableViewCell * cell in self.speedUnitCollection) {
            [self cell:cell setHidden:YES];
            [self reloadDataAnimated:YES];
            speedUnitCheck = YES;
            
        }
    }
}
-(void) showCarPlate
{
    if (!carPlateStampCheck) {
        [[CameraManager cameraManager] params:@"off" type:@"car_plate_stamp"];
        [self cell:self.carNumberCell setHidden:YES];
        [self reloadDataAnimated:YES];
        carPlateStampCheck = YES;
        [self.carPlateStamp setTitle:@"OFF" forState:UIControlStateNormal];
        [self.carPlateStamp setBackgroundColor:[UIColor colorWithRed:166/256.0 green:166/256.0 blue:166/256.0 alpha:1]];
    } else {
        
        [[CameraManager cameraManager] params:@"on" type:@"car_plate_stamp"];
        [self cell:self.carNumberCell setHidden:NO];
        [self reloadDataAnimated:YES];
        carPlateStampCheck = NO;
        [self.carPlateStamp setTitle:@"ON" forState:UIControlStateNormal];
        [self.carPlateStamp setBackgroundColor:[UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1]];
    }
}

-(void) showSpeedStamp
{
    if (!speedStampCheck) {
        [[CameraManager cameraManager] params:@"on" type:@"speed_stamp"];
        [self cell:self.speedUnitCell setHidden:NO];
        [self reloadDataAnimated:YES];
        speedStampCheck = YES;
        [self.speedStamp setTitle:@"ON" forState:UIControlStateNormal];
        [self.speedStamp setBackgroundColor:[UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1]];
    } else {
        [[CameraManager cameraManager] params:@"off" type:@"speed_stamp"];
        [self cell:self.speedUnitCell setHidden:YES];
        [self reloadDataAnimated:YES];
        [self.speedStamp setTitle:@"OFF" forState:UIControlStateNormal];
        [self.speedStamp setBackgroundColor:[UIColor colorWithRed:166/256.0 green:166/256.0 blue:166/256.0 alpha:1]];
        speedStampCheck = NO;
        for (UITableViewCell * cell in self.speedUnitCollection) {
            [self cell:cell setHidden:YES];
            [self reloadDataAnimated:YES];
            speedUnitCheck = YES;
        }
    }

}



#pragma mark - Actions

- (IBAction)backButton:(UIBarButtonItem *)sender {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"getToken" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)SyncDateAndTimeButton:(UIButton *)sender
{

    UIActivityIndicatorView * indicator = [[UIActivityIndicatorView alloc] init];
    [self.syncDateAndTimeCell addSubview:indicator];
    indicator.frame = CGRectMake(CGRectGetMaxX(self.cameraTimeDestinationLabel.frame) - 30, 14, 20, 20);
    [indicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
    [indicator setColor:[UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1]];
    self.cameraTimeDestinationLabel.text = @" ";
    
    [indicator startAnimating];
    
    
    if ([self.appDelegate isConnected]) {
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
            NSDate *currentDate = [NSDate date];
            NSLog(@"%@", currentDate);
            NSDateFormatter *dateForm = [NSDateFormatter new];
            [dateForm setDateFormat:@"yyyyMMdd_HHmmss"];
            NSString *strDate = [dateForm stringFromDate:currentDate];
            NSLog(@"%@", [dateForm stringFromDate:currentDate]);
            [[CameraManager cameraManager] paramsNoGlobal:strDate type:@"camera_time"];
            
            
            NSString * string = [[CameraManager cameraManager] getCameraTime];
            NSString *dateString = string;
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyyMMdd_HHmmss"];
            NSDate *dateFromString = [[NSDate alloc] init];
            dateFromString = [dateFormatter dateFromString:dateString];
            NSDateFormatter *dateFormatterr = [[NSDateFormatter alloc] init];
            
            if ([self.dateFormatLabelDestination.text isEqualToString:@"YYYYMMDD"]) {
                [dateFormatterr setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
            }
            else if ([self.dateFormatLabelDestination.text isEqualToString:@"DDMMYYYY"])
            {
                [dateFormatterr setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
            }
            else if ([self.dateFormatLabelDestination.text isEqualToString:@"MMDDYYYY"])
            {
                [dateFormatterr setDateFormat:@"MM/dd/yyyy HH:mm:ss"];
            }
            else
            {
                [dateFormatterr setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
            }
            
            
            NSString *stringDate = [dateFormatterr stringFromDate:dateFromString];
            NSLog(@"%@", stringDate);
            
            
            dispatch_async(dispatch_get_main_queue(), ^(void){
                self.cameraTimeDestinationLabel.text = stringDate;
                [indicator stopAnimating];
            });
            
        });
    }
    else
    {
        [indicator stopAnimating];
    }
}

- (IBAction)dateFormatButton:(UIButton *)sender {
    
    [self showDateFormatCollection];
    
}

- (IBAction)BeepNoisesButton:(UIButton *)sender {
    
    [self showBeepNoises];
}

- (IBAction)recordingLedButton:(UIButton *)sender {
    
    [self showRecordLed];
}

- (IBAction)defaultModeButton:(UIButton *)sender {
    
    [self showDefaultModeCollection];
}

- (IBAction)powerOnButton:(UIButton *)sender {
    
    [self showPowerOnAutoCollection];
}

- (IBAction)standByButton:(UIButton *)sender {
    
    [self showStandByCollection];
}

- (IBAction)motionDetectionButton:(UIButton *)sender {
    
    [self showMotionDetection];
}


- (IBAction)motionSDButton:(UIButton *)sender {
    
    [self showMotionDSCollection];
   
}

- (IBAction)tvOutButton:(UIButton *)sender {
    
    [self showTVOutCollection];
}


- (IBAction)GSensorButton:(UIButton *)sender {
    
    [self showGSensor];
  
}

- (IBAction)GSensorSButton:(UIButton *)sender {
    
    [self showGSensorSCollection];
 
}

- (IBAction)carPlateStampButton:(UIButton *)sender {
    
    [self showCarPlate];
}



- (IBAction)speedStampButton:(UIButton *)sender {
    
    [self showSpeedStamp];
}



- (IBAction)timeModeButton:(UIButton *)sender {
    [self showTimeModeCollection];
}


- (IBAction)speedUnitButton:(UIButton *)sender {
    [self showSpeedUnitCollection];
}

- (IBAction)poweroffDisconnectButton:(id)sender {
    if (powerOffDisconnectCheck) {
        for (UITableViewCell * cell in self.powerOffDisconnectCollection) {
            [self cell:cell setHidden:NO];
            [self reloadDataAnimated:YES];
            powerOffDisconnectCheck = NO;
            
        }
    } else {
        
        for (UITableViewCell * cell in self.powerOffDisconnectCollection) {
            [self cell:cell setHidden:YES];
            [self reloadDataAnimated:YES];
            powerOffDisconnectCheck = YES;
            
        }
    }
}

- (IBAction)lowBatteryWarningButton:(UIButton *)sender {
    if (!lowBatteryWarningCheck) {
        [[CameraManager cameraManager] params:@"on" type:@"low_battery_warning"];
        [self.btnLowBatteryWarning setTitle:@"ON" forState:UIControlStateNormal];
        [self.btnLowBatteryWarning setBackgroundColor:[UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1]];
        lowBatteryWarningCheck = YES;
        
    }
    else {
        [[CameraManager cameraManager] params:@"off" type:@"low_battery_warning"];
        [self.btnLowBatteryWarning setTitle:@"OFF" forState:UIControlStateNormal];
        [self.btnLowBatteryWarning setBackgroundColor:[UIColor colorWithRed:166/256.0 green:166/256.0 blue:166/256.0 alpha:1]];
        lowBatteryWarningCheck = NO;
    }
}



#pragma mark - ActionSetData
- (IBAction)chooseDateFormatF:(UIButton *)sender {
    
    self.dateFormatLabelDestination.text = self.chooseDateFormatFLabel.text;
      [[CameraManager cameraManager] params:@"YYYYMMDD" type:@"data_format"];
    for (UITableViewCell * cell in self.DateFormatCollection) {
        [self cell:cell setHidden:YES];
        [self reloadDataAnimated:YES];
        dateFormatCheck = YES;
    }
}

- (IBAction)chooseDateFormatS:(UIButton *)sender {
    
     self.dateFormatLabelDestination.text = self.chooseDateFormatSLabel.text;
     [[CameraManager cameraManager] params:@"DDMMYYYY" type:@"data_format"];
     for (UITableViewCell * cell in self.DateFormatCollection) {
        [self cell:cell setHidden:YES];
        [self reloadDataAnimated:YES];
        dateFormatCheck = YES;
    }
}

- (IBAction)chooseDateFormatM:(UIButton *)sender {
    
    self.dateFormatLabelDestination.text = self.chooseDateFormatMLabel.text;
    [[CameraManager cameraManager] params:@"MMDDYYYY" type:@"data_format"];
    for (UITableViewCell * cell in self.DateFormatCollection) {
        [self cell:cell setHidden:YES];
        [self reloadDataAnimated:YES];
        dateFormatCheck = YES;
    }
}


- (IBAction)ChooseDefaultModeFButton:(UIButton *)sender {
    
    self.defaultModeDestinationLabel.text = self.chooseDefaultModeFLabel.text;
    [[CameraManager cameraManager] params:@"mode1" type:@"default_mode"];
    for (UITableViewCell * cell in self.DefaultModeCollection) {
        [self cell:cell setHidden:YES];
        [self reloadDataAnimated:YES];
        modeCheck = YES;
    }
}

- (IBAction)ChooseDefaultModeSButton:(UIButton *)sender {
    
    self.defaultModeDestinationLabel.text = self.chooseDefaultModeSLabel.text;
    [[CameraManager cameraManager] params:@"mode2" type:@"default_mode"];
    for (UITableViewCell * cell in self.DefaultModeCollection) {
        [self cell:cell setHidden:YES];
        [self reloadDataAnimated:YES];
        modeCheck = YES;
    }
}




- (IBAction)choosePowerOnFButton:(UIButton *)sender {
    
    self.powerOnDestinationLabel.text = self.choosePowerOnFLabel.text;
    [[CameraManager cameraManager] params:@"Button only" type:@"spinnerPowerOnAutoRecord"];
    for (UITableViewCell * cell in self.PowerOnAutoCollection) {
        [self cell:cell setHidden:YES];
        [self reloadDataAnimated:YES];
        powerOnCheck = YES;
    }
}

- (IBAction)choosePowerOnSButton:(UIButton *)sender {
    
    self.powerOnDestinationLabel.text = self.choseePowerOnSLabel.text;
     [[CameraManager cameraManager] params:@"Auto Start" type:@"spinnerPowerOnAutoRecord"];
    for (UITableViewCell * cell in self.PowerOnAutoCollection) {
        [self cell:cell setHidden:YES];
        [self reloadDataAnimated:YES];
        powerOnCheck = YES;
    }
}


- (IBAction)chooseStandByFButton:(UIButton *)sender {
    self.standByDestinationLabel.text = self.chooseStandByFlabel.text;
     [[CameraManager cameraManager] params:@"off" type:@"standby_time"];
    for (UITableViewCell * cell in self.StandByCollection) {
        [self cell:cell setHidden:YES];
        [self reloadDataAnimated:YES];
        standByCheck = YES;
    }

}

- (IBAction)chooseStandBySButton:(UIButton *)sender {
    self.standByDestinationLabel.text = self.chooseStandBySlabel.text;
    [[CameraManager cameraManager] params:@"1_min" type:@"standby_time"];
    for (UITableViewCell * cell in self.StandByCollection) {
        [self cell:cell setHidden:YES];
        [self reloadDataAnimated:YES];
        standByCheck = YES;
    }
}

- (IBAction)chooseStandByTButton:(UIButton *)sender {
    self.standByDestinationLabel.text = self.chooseStandByTlabel.text;
     [[CameraManager cameraManager] params:@"3_min" type:@"standby_time"];
    for (UITableViewCell * cell in self.StandByCollection) {
        [self cell:cell setHidden:YES];
        [self reloadDataAnimated:YES];
        standByCheck = YES;
    }
}

- (IBAction)chooseStandByFourButton:(UIButton *)sender {
    self.standByDestinationLabel.text = self.chooseStandByFourLabel.text;
     [[CameraManager cameraManager] params:@"5_min" type:@"standby_time"];
    for (UITableViewCell * cell in self.StandByCollection) {
        [self cell:cell setHidden:YES];
        [self reloadDataAnimated:YES];
        standByCheck = YES;
    }
}


- (IBAction)chooseMotionDetectionSensFButton:(UIButton *)sender {
    self.motionDetectionSensDestinationLabel.text = self.motionDetectionSensFLabel.text;
    [[CameraManager cameraManager] params:@"high" type:@"motion_det_sens"];
    for (UITableViewCell * cell in self.MotionDSCollection) {
        [self cell:cell setHidden:YES];
        [self reloadDataAnimated:YES];
        motionDSCheck = YES;
    }
}

- (IBAction)chooseMotionDetectionSensSButton:(UIButton *)sender {
    self.motionDetectionSensDestinationLabel.text = self.motionDetectionSensSLabel.text;
     [[CameraManager cameraManager] params:@"medium" type:@"motion_det_sens"];
    for (UITableViewCell * cell in self.MotionDSCollection) {
        [self cell:cell setHidden:YES];
        [self reloadDataAnimated:YES];
        motionDSCheck = YES;
    }

}

- (IBAction)chooseMotionDetectionSensTButton:(UIButton *)sender {
    self.motionDetectionSensDestinationLabel.text = self.motionDetectionSensTLabel.text;
    [[CameraManager cameraManager] params:@"low" type:@"motion_det_sens"];
    for (UITableViewCell * cell in self.MotionDSCollection) {
        [self cell:cell setHidden:YES];
        [self reloadDataAnimated:YES];
        motionDSCheck = YES;
    }

}


- (IBAction)chooseTVOutFButton:(UIButton *)sender {
    self.TVOutDestinationLabel.text = self.chooseTVOutFLabel.text;
    [[CameraManager cameraManager] params:@"NTSC" type:@"tv_type"];
    for (UITableViewCell * cell in self.TVOutCollection) {
        [self cell:cell setHidden:YES];
        [self reloadDataAnimated:YES];
        TVOutCheck = YES;
    }

}

- (IBAction)chooseTVOutSButton:(UIButton *)sender {
    self.TVOutDestinationLabel.text = self.chooseTVOutSLabel.text;
     [[CameraManager cameraManager] params:@"PAL" type:@"tv_type"];
    for (UITableViewCell * cell in self.TVOutCollection) {
        [self cell:cell setHidden:YES];
        [self reloadDataAnimated:YES];
        TVOutCheck = YES;
    }
}


- (IBAction)chooseGSensorFButton:(UIButton *)sender {
    self.GSensorDestinationLabel.text = self.chooseGSensorFLabel.text;
    [[CameraManager cameraManager] params:@"High" type:@"g_sensor_sensitivity"];
    for (UITableViewCell * cell in self.GSensorSCollection) {
        [self cell:cell setHidden:YES];
        [self reloadDataAnimated:YES];
        GSensorSCheck = YES;
    }
}

- (IBAction)chooseGSensorSButton:(UIButton *)sender {
    self.GSensorDestinationLabel.text = self.chooseGSensorSLabel.text;
    [[CameraManager cameraManager] params:@"Medium" type:@"g_sensor_sensitivity"];
    for (UITableViewCell * cell in self.GSensorSCollection) {
        [self cell:cell setHidden:YES];
        [self reloadDataAnimated:YES];
        GSensorSCheck = YES;
    }
}

- (IBAction)chooseGSensorTButton:(UIButton *)sender {
    self.GSensorDestinationLabel.text = self.chooseGSensorTLabel.text;
    [[CameraManager cameraManager] params:@"Low" type:@"g_sensor_sensitivity"];
    for (UITableViewCell * cell in self.GSensorSCollection) {
        [self cell:cell setHidden:YES];
        [self reloadDataAnimated:YES];
        GSensorSCheck = YES;
    }
}


- (IBAction)chooseSpeedUnitFButton:(UIButton *)sender {
    self.speedUnitDestinationLabel.text = self.chooseSpeedUnitFLabel.text;
    [[CameraManager cameraManager] params:@"KPH" type:@"speed_unit"];
    for (UITableViewCell * cell in self.speedUnitCollection) {
        [self cell:cell setHidden:YES];
        [self reloadDataAnimated:YES];
        speedUnitCheck = YES;
    }
}

- (IBAction)chooseSpeedUnitSButton:(UIButton *)sender {
    self.speedUnitDestinationLabel.text = self.chooseSpeedUnitSLabel.text;
     [[CameraManager cameraManager] params:@"MPH" type:@"speed_unit"];
    for (UITableViewCell * cell in self.speedUnitCollection) {
        [self cell:cell setHidden:YES];
        [self reloadDataAnimated:YES];
        speedUnitCheck = YES;
    }
}

- (IBAction)cameraTime:(UIButton *)sender {
    
    self.tableView.scrollEnabled = NO;
    
    self.backgroudView = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x,
                                                                  self.view.frame.origin.y,
                                                                  self.view.frame.size.width,
                                                                  self.view.frame.size.height)];
    
    self.backgroudView.backgroundColor = [UIColor colorWithRed:0/256.0 green:0/256.0 blue:0/256.0 alpha:0.3];
    
    self.backgroudView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self.navigationController.view addSubview:self.backgroudView];
    
    if ([self.orientation isEqualToString:@"Landscape"])
    {
        self.viewPickerCameraTime = [[UIView alloc]
                                     initWithFrame:CGRectMake(30, 21, 420, 275)];
    }
    if ([self.orientation isEqualToString:@"Portrait"])
    {
        self.viewPickerCameraTime = [[UIView alloc]
                                     initWithFrame:CGRectMake(self.backgroudView.frame.origin.x + 20,
                                                              self.backgroudView.frame.origin.y + 100,
                                                              self.view.frame.size.width - 40,
                                                              275.0f)];
    }
    
     self.viewPickerCameraTime.backgroundColor = [UIColor whiteColor];
    
     self.viewPickerCameraTime.autoresizingMask =   UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    
    [self.backgroudView addSubview:self.viewPickerCameraTime];
    
    self.datePicker = [[UIDatePicker alloc] init];
    
    self.datePicker.frame = CGRectMake(0,
                                       50,
                                       self.viewPickerCameraTime.frame.size.width,
                                       180.0f);
    self.datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    
    self.datePicker.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    [self.viewPickerCameraTime addSubview:self.datePicker];
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, self.viewPickerCameraTime.frame.size.width, 50)];
    
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm"];
    NSString * timeDatePicker = [dateFormatter stringFromDate:self.datePicker.date];
    [self.label setFont:[UIFont systemFontOfSize:18]];
     self.label.text = timeDatePicker;
    [self.viewPickerCameraTime addSubview: self.label];
    
    self.bottomBorder = [CALayer layer];
    self.bottomBorder.frame = CGRectMake(-20, 43.0f, self.viewPickerCameraTime.frame.size.width , 1.0f);
    self.bottomBorder.backgroundColor = [UIColor colorWithWhite:0.8f
                                                     alpha:1.0f].CGColor;
    
    self.label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.label.layer addSublayer:self.bottomBorder];
    
    self.okCameraTimeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.okCameraTimeButton addTarget:self action:@selector(camerasTime:) forControlEvents:UIControlEventTouchUpInside];
    [self.okCameraTimeButton setTitle:@"Ok" forState:UIControlStateNormal];
    [self.okCameraTimeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.okCameraTimeButton setBackgroundColor:[UIColor whiteColor]];
    self.okCameraTimeButton.frame = CGRectMake(self.viewPickerCameraTime.frame.origin.x, CGRectGetMaxY(self.datePicker.frame)+5 , self.viewPickerCameraTime.frame.size.width -40.f, 40.0);
    
    self.okCameraTimeButton.autoresizingMask = UIViewAutoresizingFlexibleWidth;

    [self.viewPickerCameraTime addSubview:self.okCameraTimeButton];
    
    [self.datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
}



- (void)dateChanged:(id)sender
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm"];
    NSString *currentTime = [dateFormatter stringFromDate:self.datePicker.date];
    self.label.text = currentTime;
    NSLog(@"%@", currentTime);
}

- (void)camerasTime:(UIButton*)button
{
    
    UIActivityIndicatorView * indicator = [[UIActivityIndicatorView alloc] init];
    [self.viewPickerCameraTime addSubview:indicator];
    self.okCameraTimeButton.hidden = YES;
    indicator.center = self.okCameraTimeButton.center;
    [indicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
    [indicator setColor:[UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1]];
    [indicator startAnimating];
    
    
    
    if ([self.appDelegate isConnected]) {
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
            NSDate *currentDate = [NSDate date];
            NSLog(@"%@", currentDate);
            NSDateFormatter *dateForm = [NSDateFormatter new];
            [dateForm setDateFormat:@"yyyyMMdd_HHmmss"];
            NSString *strDate = [dateForm stringFromDate:currentDate];
            NSLog(@"%@", [dateForm stringFromDate:currentDate]);
            [[CameraManager cameraManager] paramsNoGlobal:strDate type:@"camera_time"];
            
            
            NSString * string = [[CameraManager cameraManager] getCameraTime];
            NSString *dateString = string;
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyyMMdd_HHmmss"];
            NSDate *dateFromString = [[NSDate alloc] init];
            dateFromString = [dateFormatter dateFromString:dateString];
            NSDateFormatter *dateFormatterr = [[NSDateFormatter alloc] init];
            if ([self.dateFormatLabelDestination.text isEqualToString:@"YYYYMMDD"]) {
                [dateFormatterr setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
            }
            else if ([self.dateFormatLabelDestination.text isEqualToString:@"DDMMYYYY"])
            {
                [dateFormatterr setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
            }
            else if ([self.dateFormatLabelDestination.text isEqualToString:@"MMDDYYYY"])
            {
                [dateFormatterr setDateFormat:@"MM/dd/yyyy HH:mm:ss"];
            }
            else
            {
                [dateFormatterr setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
            }
            NSString *stringDate = [dateFormatterr stringFromDate:self.datePicker.date];
            NSLog(@"%@", stringDate);
            dispatch_async(dispatch_get_main_queue(), ^(void){
                self.cameraTimeDestinationLabel.text = stringDate;
                [indicator stopAnimating];
                self.tableView.scrollEnabled = YES;
                self.backgroudView.hidden = YES;
                self.okCameraTimeButton.hidden = YES;
                
                self.backgroudView = nil;
                self.okCameraTimeButton = nil;
                self.viewPickerCameraTime = nil;
            });
            
        });
    }
    else
    {
        NSDateFormatter *dateFormatterr = [[NSDateFormatter alloc] init];
        if ([self.dateFormatLabelDestination.text isEqualToString:@"YYYYMMDD"]) {
            [dateFormatterr setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
        }
        else if ([self.dateFormatLabelDestination.text isEqualToString:@"DDMMYYYY"])
        {
            [dateFormatterr setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
        }
        else if ([self.dateFormatLabelDestination.text isEqualToString:@"MMDDYYYY"])
        {
            [dateFormatterr setDateFormat:@"MM/dd/yyyy HH:mm:ss"];
        }
        else
        {
            [dateFormatterr setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
        }
        NSString *stringDate = [dateFormatterr stringFromDate:self.datePicker.date];
        NSLog(@"%@", stringDate);
        self.cameraTimeDestinationLabel.text = stringDate;
        [indicator stopAnimating];
        self.tableView.scrollEnabled = YES;
        self.backgroudView.hidden = YES;
        self.okCameraTimeButton.hidden = YES;
        
        self.backgroudView = nil;
        self.okCameraTimeButton = nil;
        self.viewPickerCameraTime = nil;
    }
    
   
}


- (IBAction)fromTimeButton:(UIButton *)sender {
    self.tableView.scrollEnabled = NO;
    self.backgroudView = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x,self.view.frame.origin.x,self.view.frame.size.width,self.view.frame.size.height)];
    self.backgroudView.backgroundColor = [UIColor colorWithRed:0/256.0 green:0/256.0 blue:0/256.0 alpha:0.3];
    self.backgroudView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.navigationController.view addSubview:self.backgroudView];
    
    if ([self.orientation isEqualToString:@"Landscape"])
    {
        self.viewPickerFromTime = [[UIView alloc] initWithFrame:CGRectMake(30, 21, 420, 240)];
    }
    if ([self.orientation isEqualToString:@"Portrait"])
    {
        self.viewPickerFromTime = [[UIView alloc] initWithFrame:CGRectMake(self.backgroudView.frame.origin.x + 20,self.backgroudView.frame.origin.y + 100,self.view.frame.size.width - 40,240)];
        self.viewPickerFromTime.center = self.tableView.center;
    }

    self.viewPickerFromTime.autoresizingMask =   UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    self.viewPickerFromTime.backgroundColor = [UIColor whiteColor];
    [self.backgroudView addSubview:self.viewPickerFromTime];
    
    
    
    self.timePicker = [[UIPickerView alloc] init];
    self.timePicker.frame = CGRectMake(0,10,self.viewPickerFromTime.frame.size.width,215);
    [self.timePicker setDataSource: self];
    [self.timePicker setDelegate: self];
    self.timePicker.showsSelectionIndicator = YES;
    self.timePicker.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.viewPickerFromTime addSubview:self.timePicker];


    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(fromTime:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"Ok" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1] forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor whiteColor]];
    button.frame = CGRectMake(0, self.viewPickerFromTime.frame.size.height - 35, self.viewPickerFromTime.frame.size.width, 25);
    button.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.viewPickerFromTime addSubview:button];
    
    self.fromTime = @"1";
}

- (void)fromTime:(UIButton*)button
{
    self.fromTimeLabel.text = self.fromTime;
    [[CameraManager cameraManager] params:self.fromTime type:@"time_mode_start_time"];
    self.tableView.scrollEnabled = YES;
    self.backgroudView.hidden = YES;
    self.timePicker.hidden = YES;
    self.viewPickerFromTime.hidden = YES;
    
    self.backgroudView = nil;
    self.timePicker = nil;
    self.viewPickerFromTime = nil;;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.fromTime = [self.timeArray objectAtIndex:row];
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.timeArray count];
}

// tell the picker how many components it will have
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// tell the picker the title for a given component
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [self.timeArray objectAtIndex: row];
}

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSAttributedString *attString = [[NSAttributedString alloc] initWithString:[self.timeArray objectAtIndex:row] attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1]}];
    return attString;
}

// tell the picker the width of each row for a given component
//- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
//    int sectionWidth = 300;
//    
//    return sectionWidth;
//}




- (IBAction)toTimeButton:(UIButton *)sender {
    self.tableView.scrollEnabled = NO;
    self.backgroudView = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x,self.view.frame.origin.x,self.view.frame.size.width,self.view.frame.size.height)];
    self.backgroudView.backgroundColor = [UIColor colorWithRed:0/256.0 green:0/256.0 blue:0/256.0 alpha:0.3];
    self.backgroudView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.navigationController.view addSubview:self.backgroudView];
    
    if ([self.orientation isEqualToString:@"Landscape"])
    {
        self.viewPickerFromTime = [[UIView alloc] initWithFrame:CGRectMake(30, 21, 420, 240)];
    }
    if ([self.orientation isEqualToString:@"Portrait"])
    {
        self.viewPickerFromTime = [[UIView alloc] initWithFrame:CGRectMake(self.backgroudView.frame.origin.x + 20,self.backgroudView.frame.origin.y + 100,self.view.frame.size.width - 40,240)];
        self.viewPickerFromTime.center = self.tableView.center;
    }
    
    self.viewPickerFromTime.autoresizingMask =   UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    self.viewPickerFromTime.backgroundColor = [UIColor whiteColor];
    [self.backgroudView addSubview:self.viewPickerFromTime];
    
    
    
    self.timePicker = [[UIPickerView alloc] init];
    self.timePicker.frame = CGRectMake(0,10,self.viewPickerFromTime.frame.size.width,215);
    [self.timePicker setDataSource: self];
    [self.timePicker setDelegate: self];
    self.timePicker.showsSelectionIndicator = YES;
    self.timePicker.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.viewPickerFromTime addSubview:self.timePicker];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(ToTime:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"Ok" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1] forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor whiteColor]];
    button.frame = CGRectMake(0, self.viewPickerFromTime.frame.size.height - 35, self.viewPickerFromTime.frame.size.width, 25);
    button.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.viewPickerFromTime addSubview:button];
  
    self.fromTime = @"1";
    
}

- (void)ToTime:(UIButton*)button
{
    self.toTimeLabel.text = self.fromTime;
    [[CameraManager cameraManager] params:self.fromTime type:@"time_mode_finish_time"];
    self.tableView.scrollEnabled = YES;
    self.backgroudView.hidden = YES;
    self.timePicker.hidden = YES;
    self.viewPickerFromTime.hidden = YES;
    
    self.backgroudView = nil;
    self.timePicker = nil;
    self.viewPickerFromTime = nil;
}

- (IBAction)carNumberButton:(UIButton *)sender {
     [[CameraManager cameraManager] params:self.carNumberTextField.text type:@"toggleCarNumber"];
     [self.carNumberTextField resignFirstResponder];
}

- (IBAction)WiFiPasswordButton:(UIButton *)sender {
    [[CameraManager cameraManager] params:self.WiFiPasswordTextField.text type:@"wifi_password"];
    [self.view endEditing:YES];
    [self.carNumberTextField resignFirstResponder];
}

-(void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if (toInterfaceOrientation == UIInterfaceOrientationPortrait)
    {
        self.orientation = @"Portrait";
        NSLog(@"%@", NSStringFromCGRect(self.viewPickerCameraTime.frame));
    }
    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight)
    {
        self.orientation = @"Landscape";
        NSLog(@"%@", NSStringFromCGRect(self.viewPickerCameraTime.frame));
    }
}

- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [self interfaceOrient];
}

-(void)interfaceOrient
{
    if ([self.orientation isEqualToString:@"Landscape"])
    {
        self.viewPickerToTime.frame = CGRectMake(30, 21, 420, 275);
        self.viewPickerFromTime.frame = CGRectMake(30, 21, 420, 275);
        self.viewPickerCameraTime.frame = CGRectMake(30, 21, 420, 275);
        self.bottomBorder.frame = CGRectMake(-20, 43, self.view.frame.size.width-60, 1);
        NSLog(@"%@", NSStringFromCGRect(self.bottomBorder.frame));
    }
    if ([self.orientation isEqualToString:@"Portrait"])
    {
         self.viewPickerToTime.frame = CGRectMake(20, 100, 280, 275);
         self.viewPickerFromTime.frame = CGRectMake(20, 100, 280, 275);
         self.viewPickerCameraTime.frame = CGRectMake(20, 100, 280, 275);
         self.bottomBorder.frame = CGRectMake(-20, 43, self.view.frame.size.width -40, 1);
         NSLog(@"%@", NSStringFromCGRect(self.bottomBorder.frame));
    }
}

- (IBAction)resetAllSettingsButton:(UIButton *)sender {
    
    [self.resetAllSettings setTitle:@"ON" forState:UIControlStateNormal];
    [self.resetAllSettings setBackgroundColor:[UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1]];
    
    
    [self startIndicator];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        
        if ([self.appDelegate isConnected])
        {
            
            [[CameraManager cameraManager] resetAllSettings];
            
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            //syncCheck = NO;
            //[self cell:self.syncDateAndTimeCell setHidden:NO];
            //[self.syncDateAndTimeButton setTitle:@"OFF" forState:UIControlStateNormal];
            //[self.syncDateAndTimeButton setBackgroundColor:[UIColor colorWithRed:166/256.0 green:166/256.0 blue:166/256.0 alpha:1]];
            //self.cameraTimeDestinationLabel.text = @"";
            
            
            
            for (UITableViewCell * cell in self.DateFormatCollection) {
                [self cell:cell setHidden:YES];
                dateFormatCheck = YES;
            }
            
            
            self.dateFormatLabelDestination.text = @"DDMMYYY";
            
            
            beepNoisesCheck = YES;
            [self.beepNioses setTitle:@"ON" forState:UIControlStateNormal];
            [self.beepNioses setBackgroundColor:[UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1]];
            
            
            recordLEDCheck = NO;
            [self.recordingLED setTitle:@"ON" forState:UIControlStateNormal];
            [self.recordingLED setBackgroundColor:[UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1]];
            
            
            
            for (UITableViewCell * cell in self.DefaultModeCollection) {
                [self cell:cell setHidden:YES];
                modeCheck = YES;
            }
            self.defaultModeDestinationLabel.text = @"mode1";
            
            
            
            for (UITableViewCell * cell in self.PowerOnAutoCollection) {
                [self cell:cell setHidden:YES];
                powerOnCheck = YES;
            }
            self.powerOnDestinationLabel.text = @"Auto Start";
            
            
            
            for (UITableViewCell * cell in self.StandByCollection) {
                [self cell:cell setHidden:YES];
                standByCheck = YES;
            }
            self.standByDestinationLabel.text = @"1 min";
            
            
            
            [self cell:self.motionDetectionCell setHidden:YES];
            motionDetectionCheck = YES;
            [self.motionDetection setTitle:@"OFF" forState:UIControlStateNormal];
            [self.motionDetection setBackgroundColor:[UIColor colorWithRed:166/256.0 green:166/256.0 blue:166/256.0 alpha:1]];
            for (UITableViewCell * cell in self.MotionDSCollection) {
                [self cell:cell setHidden:YES];
                motionDSCheck = YES;
            }
            self.motionDetectionSensDestinationLabel.text = @"high";
            
            
            
            for (UITableViewCell * cell in self.TVOutCollection) {
                [self cell:cell setHidden:YES];
                TVOutCheck = YES;
            }
            self.TVOutDestinationLabel.text = @"PAL";
            
            
            
            [self cell:self.GSensorCell setHidden:NO];
            [self.GSensor setTitle:@"ON" forState:UIControlStateNormal];
            [self.GSensor setBackgroundColor:[UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1]];
            GSensorCheck = NO;
            for (UITableViewCell * cell in self.GSensorSCollection) {
                [self cell:cell setHidden:YES];
                GSensorSCheck = YES;
            }
            self.GSensorDestinationLabel.text = @"High";
            
            
            
            [self cell:self.carNumberCell setHidden:YES];
            carPlateStampCheck = YES;
            [self.carPlateStamp setTitle:@"OFF" forState:UIControlStateNormal];
            [self.carPlateStamp setBackgroundColor:[UIColor colorWithRed:166/256.0 green:166/256.0 blue:166/256.0 alpha:1]];
            
            
            
            [self cell:self.speedUnitCell setHidden:YES];
            [self.speedStamp setTitle:@"OFF" forState:UIControlStateNormal];
            [self.speedStamp setBackgroundColor:[UIColor colorWithRed:166/256.0 green:166/256.0 blue:166/256.0 alpha:1]];
            speedStampCheck = NO;
            for (UITableViewCell * cell in self.speedUnitCollection) {
                [self cell:cell setHidden:YES];
                speedUnitCheck = YES;
            }
            
            
            
            for (UITableViewCell * cell in self.timeModeCell) {
                [self cell:cell setHidden:YES];
            }
            [self.timeMode setTitle:@"OFF" forState:UIControlStateNormal];
            [self.timeMode setBackgroundColor:[UIColor colorWithRed:166/256.0 green:166/256.0 blue:166/256.0 alpha:1]];
            timeModeCheck = YES;
            
            lowBatteryWarningCheck = NO;
            [self.btnLowBatteryWarning setTitle:@"OFF" forState:UIControlStateNormal];
            [self.btnLowBatteryWarning setBackgroundColor:[UIColor colorWithRed:166/256.0 green:166/256.0 blue:166/256.0 alpha:1]];
            
            [self.indicator stopAnimating];
            self.bgrdResetView.hidden = YES;
            self.tableView.scrollEnabled = YES;
            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
            [self reloadDataAnimated:YES];
            [self alertResetSettings];
            [self.resetAllSettings setTitle:@"OFF" forState:UIControlStateNormal];
            [self.resetAllSettings setBackgroundColor:[UIColor colorWithRed:166/256.0 green:166/256.0 blue:166/256.0 alpha:1]];
        });
    });
    
}

-(void)resetSettingsButtonHighlight:(UIButton*) button {
    
    self.resetAllSettings.backgroundColor = [UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1];
}

-(void)resetSettingsButton:(UIButton*) button {
    
    self.resetAllSettings.backgroundColor = [UIColor colorWithRed:149/256.0 green:149/256.0 blue:149/256.0 alpha:1];
}

-(void) startIndicator {
    self.tableView.scrollEnabled = NO;
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    self.bgrdResetView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height * 2)];
    self.bgrdResetView.backgroundColor = [UIColor colorWithRed:0/256.0 green:0/256.0 blue:0/256.0 alpha:0.3];
    [self.view addSubview:self.bgrdResetView];
    [self.view bringSubviewToFront:self.bgrdResetView];
    
    self.indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.indicator.center = self.bgrdResetView.center;
    [self.bgrdResetView addSubview:self.indicator];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self.indicator startAnimating];
}

-(void) stopIndicator {
    [self.indicator stopAnimating];
    self.bgrdResetView.hidden = YES;
    self.tableView.scrollEnabled = YES;
    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
}



- (IBAction)carNumberTextField:(UITextField *)sender
{
    NSString * string = sender.text;
    
    if (!(([string isEqualToString:@""]))) {
        unichar unicodevalue = [string characterAtIndex:0];
        if ((unicodevalue >= 19968 && unicodevalue <= 40959) || (unicodevalue >= 13312 && unicodevalue <= 19967) || (unicodevalue >= 63744 && unicodevalue <= 64255) || (unicodevalue >= 12544 && unicodevalue <= 12591) || (unicodevalue >= 12704 && unicodevalue <= 12735)) {
            sender.text = @"";
        }
    }
}



-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([textField isEqual:self.carNumberTextField]) {
        
        if (!(([string isEqualToString:@""]))) {
            unichar unicodevalue = [string characterAtIndex:0];
            if ((unicodevalue >= 19968 && unicodevalue <= 40959) || (unicodevalue >= 13312 && unicodevalue <= 19967) || (unicodevalue >= 63744 && unicodevalue <= 64255) || (unicodevalue >= 12544 && unicodevalue <= 12591) || (unicodevalue >= 12704 && unicodevalue <= 12735)) {
                return NO;
            }
        }
        
        if(range.length + range.location > textField.text.length)
        {
            return NO;
        }
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        return newLength <= 10;

    }
    else if ([textField isEqual:self.WiFiPasswordTextField])
    {
        if(range.length + range.location > textField.text.length)
        {
            return NO;
        }
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        return newLength <= 10;
    }
    else
    {
        return YES;
    }
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    return YES;
}


- (IBAction)choosePoweroffFButton:(UIButton *)sender {
    self.PoweroffDisconnectDestinationLabel.text = self.choosePoweroffFLabel.text;
    [[CameraManager cameraManager] params:@"1 sec" type:@"power_off_disconnect"];
    for (UITableViewCell * cell in self.powerOffDisconnectCollection) {
        [self cell:cell setHidden:YES];
        [self reloadDataAnimated:YES];
        powerOffDisconnectCheck = YES;
    }
    
}


- (IBAction)choosePoweroffSButton:(UIButton *)sender {
    self.PoweroffDisconnectDestinationLabel.text = self.choosePoweroffSLabel.text;
    [[CameraManager cameraManager] params:@"10 sec" type:@"power_off_disconnect"];
    for (UITableViewCell * cell in self.powerOffDisconnectCollection) {
        [self cell:cell setHidden:YES];
        [self reloadDataAnimated:YES];
        powerOffDisconnectCheck = YES;
    }

}
@end
