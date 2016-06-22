//
//  ModeTwoVC.m
//  JooVuuX
//
//  Created by Vladislav on 29.09.15.
//  Copyright (c) 2015 lsoft. All rights reserved.
//

#import "ModeTwoVC.h"
#import "ModeSettingsVC.h"
#import "PhotoModeVC.h"
#import "CameraManager.h"
#import "StreamVC.h"
#import "AppDelegate.h"

@interface ModeTwoVC ()<UITableViewDelegate, UITableViewDataSource>


{
    BOOL fieldOfViewHDR;
    BOOL fieldOfViewSEC;
    BOOL videoResolutionCheck;
    BOOL imageRotationCheck;
    BOOL audioCheck;
    BOOL videoTimeStampCheck;
    BOOL rotateDegreesCheck;
    BOOL loopRecordingCheck;
    BOOL videoBitRatesCheck;
    BOOL wdrCheck;
    BOOL fieldOfViewCheck;
    BOOL timeLapseCheck;
    BOOL displaySpeedCheck;
    BOOL videoClipCheck;
    BOOL checkWindow;
    __weak IBOutlet UITableViewCell *fieldOfView;
    __weak IBOutlet UITableViewCell *wdrCell;
    __weak IBOutlet UITableViewCell *timeLapseCell;
    
    
    
    IBOutletCollection(UITableViewCell) NSArray *imageRotationCellArray;
    __weak IBOutlet UILabel *imageRotationLabel;

}

- (IBAction)imageRotationShowButton:(UIButton *)sender;
- (IBAction)imageRotationOneButton:(UIButton *)sender;
- (IBAction)imageRotationTwoButton:(UIButton *)sender;
- (IBAction)imageRotationThreeButton:(UIButton *)sender;

@property(strong, nonatomic)UIView * bgrdResetView;

@property (strong, nonatomic) UIButton * button;
@property (strong, nonatomic)UIImageView * imageViewRight;
@property (nonatomic,retain) AppDelegate *appDelegate;
@end

@implementation ModeTwoVC


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.appDelegate = [[UIApplication sharedApplication] delegate];
       
    for (UITableViewCell * cell in self.videoResolutionCollection) {
        [self cell:cell setHidden:YES];
        [self reloadDataAnimated:NO];
        videoResolutionCheck = YES;
    }
    
    for (UITableViewCell * cell in self.videoBitRatesCollection) {
        [self cell:cell setHidden:YES];
        [self reloadDataAnimated:NO];
        videoBitRatesCheck = YES;
    }
    
    for (UITableViewCell * cell in self.fieldOfViewCollection) {
        [self cell:cell setHidden:YES];
        [self reloadDataAnimated:NO];
        fieldOfViewCheck = YES;
    }
    
    for (UITableViewCell * cell in self.timeLapseCollection) {
        [self cell:cell setHidden:YES];
        [self reloadDataAnimated:NO];
        timeLapseCheck = YES;
    }
    
    for (UITableViewCell * cell in self.videoClipCollection) {
        [self cell:cell setHidden:YES];
        [self reloadDataAnimated:NO];
        videoClipCheck = YES;
    }

    for (UITableViewCell * cell in imageRotationCellArray) {
        [self cell:cell setHidden:YES];
        [self reloadDataAnimated:NO];
        imageRotationCheck = YES;
    }
    
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [self.resetAllSettingsMode2 addTarget:self action:@selector(resetSettingsMode2ButtonHighlight:) forControlEvents:UIControlEventTouchDown];
    [self.resetAllSettingsMode2 addTarget:self action:@selector(resetSettingsMode2Button:) forControlEvents:UIControlEventTouchDragOutside];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startIndicator) name:@"startActivity" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stopIndicator) name:@"stopActivity" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(alertCamera21) name:@"camera21" object:nil];
    //if ([[NSUserDefaults standardUserDefaults] boolForKey:@"firstOpenModeTwoKEY"]) {
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
            NSString * videoBit;
            if ([self.videoBitDestinationLabel.text isEqualToString:@"High"])
            {
                videoBit = @"S.Fine";
            }
            else if ([self.videoBitDestinationLabel.text isEqualToString:@"Medium"])
            {
                videoBit = @"Fine";
            }
            else if ([self.videoBitDestinationLabel.text isEqualToString:@"Low"])
            {
                videoBit = @"Normal";
            }
            
            
            
            NSArray * dict = [[NSArray alloc] init];
            dict = @[
                     @{@"video_resolution_mode2":self.resolutionDesctinationLabel.text},
                     @{@"video_quality_mode2":videoBit},
                     @{@"video_length_mode2":self.videoClipDestinationLabel.text},
                     @{@"fleld_view_mode2":self.fieldOfViewDestinationLabel.text},
                     @{@"timelapse_video_mode2":self.timeLapsDestinationLabel.text},
                     
                     @{@"audio_mode2":audioCheck?@"on":@"off"},
                     @{@"video_timestamp_mode2":videoTimeStampCheck?@"on":@"off"},
                     @{@"rotate_video_mode2":imageRotationLabel.text},
                     @{@"loop_record_mode2":loopRecordingCheck?@"off":@"on"},
                     @{@"wdr_mode2":wdrCheck?@"off":@"on"}
                     ];
            
            [[[CameraManager cameraManager] allSettingsDict] setObject:dict forKey:@"modeTwo"];
        }
    }
}

-(void) checkFieldOfView
{
    if ([self.resolutionDesctinationLabel.text rangeOfString:@"HDR "].location != NSNotFound) {
        fieldOfViewHDR = NO;
    }
    else
    {
        fieldOfViewHDR = YES;
    }
    
    if ([self.timeLapsDestinationLabel.text rangeOfString:@"sec"].location != NSNotFound) {
        fieldOfViewSEC = NO;
    }
    else
    {
        fieldOfViewSEC = YES;
    }
    
    
    
    if (fieldOfViewHDR && fieldOfViewSEC) {
        self.fieldOfViewButton.hidden = NO;
    }
    else
    {
        self.fieldOfViewDestinationLabel.text = @"155";
        self.fieldOfViewButton.hidden = YES;
    }
}


-(void) loadAllSettings
{
    
    NSMutableDictionary * settings = [NSMutableDictionary new];
    NSMutableArray * array = [NSMutableArray new];
    array = [[[CameraManager cameraManager] allSettingsDict] valueForKey:@"modeTwo"];
    
    for (int i = 0; i < array.count; i++) {
        NSDictionary * obj = [array objectAtIndex:i];
        [settings setValuesForKeysWithDictionary:obj];
    }
    
    
    self.resolutionDesctinationLabel.text = [settings valueForKey:@"video_resolution_mode2"];
    
    if ([[settings valueForKey:@"video_quality_mode2"] isEqualToString:@"S.Fine"])
    {
        self.videoBitDestinationLabel.text = @"High";
    }
    else if ([[settings valueForKey:@"video_quality_mode2"] isEqualToString:@"Fine"])
    {
        self.videoBitDestinationLabel.text = @"Medium";
    }
    else if ([[settings valueForKey:@"video_quality_mode2"] isEqualToString:@"Normal"])
    {
        self.videoBitDestinationLabel.text = @"Low";
    }
    
    self.videoClipDestinationLabel.text = [settings valueForKey:@"video_length_mode2"];
    self.fieldOfViewDestinationLabel.text = [settings valueForKey:@"fleld_view_mode2"];
    
    NSString * replaceStr = [settings valueForKey:@"timelapse_video_mode2"];
    replaceStr = [replaceStr stringByReplacingOccurrencesOfString:@"_" withString:@" "];
    self.timeLapsDestinationLabel.text = replaceStr;
    
    
    
    if (![[settings valueForKey:@"audio_mode2"] isEqualToString:@"on"]) {
        audioCheck = NO;
    }
    else
    {
        audioCheck = YES;
    }
    
    if (![[settings valueForKey:@"video_timestamp_mode2"] isEqualToString:@"on"]) {
        videoTimeStampCheck = NO;
    }
    else
    {
        videoTimeStampCheck = YES;
    }
    
    imageRotationLabel.text = [settings valueForKey:@"rotate_video_mode2"];
    
    if (![[settings valueForKey:@"loop_record_mode2"] isEqualToString:@"on"]) {
        loopRecordingCheck = YES;
    }
    else
    {
        loopRecordingCheck = NO;
    }
    
    if (![[settings valueForKey:@"wdr_mode2"] isEqualToString:@"on"]) {
        wdrCheck = YES;
    }
    else
    {
        wdrCheck = NO;
    }
    
    
    //if (![[settings valueForKey:@"g_sensor"] isEqualToString:@"on"]) {
    displaySpeedCheck = YES;
    //}
    //else
    //{
    //    displaySpeedCheck = NO;
    //}

    
    if (!audioCheck)
    {
        [self.audio setTitle:@"OFF" forState:UIControlStateNormal];
        [self.audio setBackgroundColor:[UIColor colorWithRed:166/256.0 green:166/256.0 blue:166/256.0 alpha:1]];
    }else
    {
        [self.audio setTitle:@"ON" forState:UIControlStateNormal];
        [self.audio setBackgroundColor:[UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1]];
    }
    
    if (!videoTimeStampCheck)
    {
        [self.videoTimeStamp setTitle:@"OFF" forState:UIControlStateNormal];
        [self.videoTimeStamp setBackgroundColor:[UIColor colorWithRed:166/256.0 green:166/256.0 blue:166/256.0 alpha:1]];
    }else
    {
        [self.videoTimeStamp setTitle:@"ON" forState:UIControlStateNormal];
        [self.videoTimeStamp setBackgroundColor:[UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1]];
    }
    
    if (!loopRecordingCheck)
    {
        [self cell:self.VideoClipCell setHidden:NO];
        [self.loopRecording setTitle:@"ON" forState:UIControlStateNormal];
        [self.loopRecording setBackgroundColor:[UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1]];
    }else
    {
        [self cell:self.VideoClipCell setHidden:YES];
        [self.loopRecording setTitle:@"OFF" forState:UIControlStateNormal];
        [self.loopRecording setBackgroundColor:[UIColor colorWithRed:166/256.0 green:166/256.0 blue:166/256.0 alpha:1]];
        for (UITableViewCell * cell in self.videoClipCollection) {
            [self cell:cell setHidden:YES];
        }
    }
    
    if (!wdrCheck)
    {
        [self.wdr setTitle:@"ON" forState:UIControlStateNormal];
        [self.wdr setBackgroundColor:[UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1]];
    }else
    {
        [self.wdr setTitle:@"OFF" forState:UIControlStateNormal];
        [self.wdr setBackgroundColor:[UIColor colorWithRed:166/256.0 green:166/256.0 blue:166/256.0 alpha:1]];
    }
    
    if (!displaySpeedCheck)
    {
        [self.displaySpeed setTitle:@"ON" forState:UIControlStateNormal];
        [self.displaySpeed setBackgroundColor:[UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1]];
    }else
    {
        [self.displaySpeed setTitle:@"OFF" forState:UIControlStateNormal];
        [self.displaySpeed setBackgroundColor:[UIColor colorWithRed:166/256.0 green:166/256.0 blue:166/256.0 alpha:1]];
    }
    
    [self checkFieldOfView];
    
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


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    return 40;
}




- (UIView*) tableView: (UITableView*) tableView viewForHeaderInSection: (NSInteger)section {
    
    self.button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.button addTarget:self
                    action:@selector(aMethod:)
          forControlEvents:UIControlEventTouchUpInside];
    self.button.backgroundColor = [UIColor clearColor];
    self.button.frame = CGRectMake((self.view.frame.size.width) - 70, 3.0, 60, 35);
    
    self.imageViewRight = [[UIImageView alloc]
                           initWithFrame:CGRectMake((self.view.frame.size.width) - 50, 8.0, 15, 25)];
    UIImage *btnImage = [UIImage imageNamed:@"arrow_right_mode_pick.png"];
    self.imageViewRight.image = btnImage;

    if ([self.orientation isEqualToString:@"Landscape"])
    {
        self.button.frame = CGRectMake((self.view.frame.size.width) - 70, 3.0, 60, 35);
        self.imageViewRight.frame = CGRectMake((self.view.frame.size.width) - 50, 8.0, 15, 25);
    }
    if ([self.orientation isEqualToString:@"Portrait"])
    {
        self.button.frame = CGRectMake((self.view.frame.size.width) - 70, 3.0, 60, 35);
        self.imageViewRight.frame = CGRectMake((self.view.frame.size.width) - 50, 8.0, 15, 25);
    }
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button1 addTarget:self
                action:@selector(backMode:)
      forControlEvents:UIControlEventTouchUpInside];
    button1.backgroundColor = [UIColor clearColor];
    button1.frame = CGRectMake(10, 3.0, 60, 35);
    
    UIImageView *imageViewLeft = [[UIImageView alloc]
                                  initWithFrame:CGRectMake( 30, 8.0, 15, 25)];
    UIImage *btnI = [UIImage imageNamed:@"arrow_left_mode_pick.png"];
    imageViewLeft.image = btnI;
    
    UIView* view = [[UIView alloc] init];
    UILabel* label = [[UILabel alloc] init];
    [view setBackgroundColor:[UIColor whiteColor]];
    label.text = [self tableView: tableView titleForHeaderInSection: section];
    label.textAlignment = NSTextAlignmentCenter;
    [label sizeToFit];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    [label setTextColor:[UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1]];
    [label setFont:[UIFont systemFontOfSize:12]];
    [view addSubview:label];
    [view addConstraints:
     @[[NSLayoutConstraint constraintWithItem:label
                                    attribute:NSLayoutAttributeCenterX
                                    relatedBy:NSLayoutRelationEqual
                                       toItem:view
                                    attribute:NSLayoutAttributeCenterX
                                   multiplier:1 constant:0],
       [NSLayoutConstraint constraintWithItem:label
                                    attribute:NSLayoutAttributeCenterY
                                    relatedBy:NSLayoutRelationEqual
                                       toItem:view
                                    attribute:NSLayoutAttributeCenterY
                                   multiplier:1 constant:0]]];
    [view addSubview:self.button];
    [view addSubview:button1];
    [view addSubview:self.imageViewRight];
    [view addSubview:imageViewLeft];
    
    return view;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    if (fromInterfaceOrientation == UIInterfaceOrientationPortrait) {
        [UIView animateWithDuration:0 animations:^{
            self.button.frame = CGRectMake((self.view.frame.size.width) - 70, 3.0, 60, 35);
            self.imageViewRight.frame = CGRectMake((self.view.frame.size.width) - 50, 8.0, 15, 25);
        }];
    }
    if (fromInterfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
        [UIView animateWithDuration:0 animations:^{
            self.button.frame = CGRectMake((self.view.frame.size.width) - 70, 3.0, 60, 35);
            self.imageViewRight.frame = CGRectMake((self.view.frame.size.width) - 50, 8.0, 15, 25);
        }];
    }
    if (fromInterfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        [UIView animateWithDuration:0 animations:^{
            self.imageViewRight.frame = CGRectMake((self.view.frame.size.width) - 50, 8.0, 15, 25);
            self.button.frame = CGRectMake((self.view.frame.size.width) - 70, 3.0, 60, 35);
        }];
    }
}

-(void)aMethod:(UIButton*) button {
    
    PhotoModeVC* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"PhotoModeVC"];
    vc.orientation = self.orientation;
    [self.navigationController pushViewController:vc animated:NO];
    
}

-(void)backMode:(UIButton*) button {
    
    ModeSettingsVC * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ModeSettingsVC"];
    vc.orientation = self.orientation;
    [self.navigationController pushViewController:vc animated:NO];
    
    
}


-(void) showVideoResolutionCollection
{
    if (videoResolutionCheck) {
        for (UITableViewCell * cell in self.videoResolutionCollection) {
            [self cell:cell setHidden:NO];
            [self reloadDataAnimated:YES];
            videoResolutionCheck = NO;
            
        }
    } else {
        
        for (UITableViewCell * cell in self.videoResolutionCollection) {
            [self cell:cell setHidden:YES];
            [self reloadDataAnimated:YES];
            videoResolutionCheck = YES;
            
        }
    }
}

-(void) showVideoBitRatesCollection
{
    if (videoBitRatesCheck) {
        for (UITableViewCell * cell in self.videoBitRatesCollection) {
            [self cell:cell setHidden:NO];
            [self reloadDataAnimated:YES];
            videoBitRatesCheck = NO;
            
        }
    } else {
        
        for (UITableViewCell * cell in self.videoBitRatesCollection) {
            [self cell:cell setHidden:YES];
            [self reloadDataAnimated:YES];
            videoBitRatesCheck = YES;
            
        }
    }
}


-(void) showfieldOfViewCollection
{
    if (fieldOfViewCheck) {
        for (UITableViewCell * cell in self.fieldOfViewCollection) {
            [self cell:cell setHidden:NO];
            [self reloadDataAnimated:YES];
            fieldOfViewCheck = NO;
            
        }
    } else {
        
        for (UITableViewCell * cell in self.fieldOfViewCollection) {
            [self cell:cell setHidden:YES];
            [self reloadDataAnimated:YES];
            fieldOfViewCheck = YES;
            
        }
    }
}


-(void) showTimeLapseCollection
{
    if (timeLapseCheck) {
        for (UITableViewCell * cell in self.timeLapseCollection) {
            [self cell:cell setHidden:NO];
            [self reloadDataAnimated:YES];
            timeLapseCheck = NO;
            
        }
    } else {
        
        for (UITableViewCell * cell in self.timeLapseCollection) {
            [self cell:cell setHidden:YES];
            [self reloadDataAnimated:YES];
            timeLapseCheck = YES;
            
        }
    }
}

-(void) showVideoClipCollection
{
    if (videoClipCheck) {
        for (UITableViewCell * cell in self.videoClipCollection) {
            [self cell:cell setHidden:NO];
            [self reloadDataAnimated:YES];
            videoClipCheck = NO;
            
        }
    } else {
        
        for (UITableViewCell * cell in self.videoClipCollection) {
            [self cell:cell setHidden:YES];
            [self reloadDataAnimated:YES];
            videoClipCheck = YES;
            
        }
    }
}

#pragma mark - Actions

- (IBAction)backButton:(UIBarButtonItem *)sender {

    checkWindow = [[NSUserDefaults standardUserDefaults] boolForKey:@"checkWindows"];
    if (checkWindow) {
        checkWindow = YES;
        [[NSUserDefaults standardUserDefaults] setBool:checkWindow forKey:@"checkWindows"];
        for (UIViewController *controller in self.navigationController.viewControllers)
        {
            if ([controller isKindOfClass:[StreamVC class]])
            {
                [self.navigationController popToViewController:controller animated:YES];
                break;
            }
        }
         }else {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}


- (IBAction)audioAction:(UIButton *)sender {
    
    if (!audioCheck) {
         [[CameraManager cameraManager] params:@"on" type:@"audio_mode2"];
        [self.audio setTitle:@"ON" forState:UIControlStateNormal];
        [self.audio setBackgroundColor:[UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1]];
        audioCheck = YES;
        
    } else {
         [[CameraManager cameraManager] params:@"off" type:@"audio_mode2"];
        [self.audio setTitle:@"OFF" forState:UIControlStateNormal];
        [self.audio setBackgroundColor:[UIColor colorWithRed:166/256.0 green:166/256.0 blue:166/256.0 alpha:1]];
        audioCheck = NO;
    }
}

- (IBAction)videoTimeStampButton:(UIButton *)sender {
    if (!videoTimeStampCheck) {
         [[CameraManager cameraManager] params:@"on" type:@"video_timestamp_mode2"];
        [self.videoTimeStamp setTitle:@"ON" forState:UIControlStateNormal];
        [self.videoTimeStamp setBackgroundColor:[UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1]];
        videoTimeStampCheck = YES;
        
    } else {
         [[CameraManager cameraManager] params:@"off" type:@"video_timestamp_mode2"];
        [self.videoTimeStamp setTitle:@"OFF" forState:UIControlStateNormal];
        [self.videoTimeStamp setBackgroundColor:[UIColor colorWithRed:166/256.0 green:166/256.0 blue:166/256.0 alpha:1]];
        videoTimeStampCheck = NO;
    }
}


- (IBAction)rotateDegreesButton:(UIButton *)sender {
//    
//    if (!rotateDegreesCheck) {
//         [[CameraManager cameraManager] params:@"on" type:@"rotate_video_mode2"];
//        [self.rotateDegrees setTitle:@"ON" forState:UIControlStateNormal];
//        [self.rotateDegrees setBackgroundColor:[UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1]];
//        rotateDegreesCheck = YES;
//        
//    } else {
//         [[CameraManager cameraManager] params:@"off" type:@"rotate_video_mode2"];
//        [self.rotateDegrees setTitle:@"OFF" forState:UIControlStateNormal];
//        [self.rotateDegrees setBackgroundColor:[UIColor colorWithRed:166/256.0 green:166/256.0 blue:166/256.0 alpha:1]];
//        rotateDegreesCheck = NO;
//        
//    }
}

- (IBAction)loopRecordingButton:(UIButton *)sender {
    
    if (!loopRecordingCheck) {
         [[CameraManager cameraManager] params:@"off" type:@"loop_record_mode2"];
        [self cell:self.VideoClipCell setHidden:YES];
        [self reloadDataAnimated:YES];
        [self.loopRecording setTitle:@"OFF" forState:UIControlStateNormal];
        [self.loopRecording setBackgroundColor:[UIColor colorWithRed:166/256.0 green:166/256.0 blue:166/256.0 alpha:1]];
        loopRecordingCheck = YES;
        for (UITableViewCell * cell in self.videoClipCollection) {
            [self cell:cell setHidden:YES];
            [self reloadDataAnimated:YES];
            videoClipCheck = YES;
            
        }
        
    }else {
         [[CameraManager cameraManager] params:@"on" type:@"loop_record_mode2"];
        [self cell:self.VideoClipCell setHidden:NO];
        [self reloadDataAnimated:YES];
        loopRecordingCheck = NO;
        [self.loopRecording setTitle:@"ON" forState:UIControlStateNormal];
        [self.loopRecording setBackgroundColor:[UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1]];
        
    }
}

- (IBAction)timeLapseButton:(UIButton*)sender {
    
    [self showTimeLapseCollection];
}

- (IBAction)displaySpeedButton:(UIButton *)sender {
    
    if (!displaySpeedCheck) {
        [[CameraManager cameraManager] params:@"off" type:@"speed_stamp_mode2"];
        [self.displaySpeed setTitle:@"OFF" forState:UIControlStateNormal];
        [self.displaySpeed setBackgroundColor:[UIColor colorWithRed:166/256.0 green:166/256.0 blue:166/256.0 alpha:1]];
        displaySpeedCheck = YES;
        
    } else {
         [[CameraManager cameraManager] params:@"on" type:@"speed_stamp_mode2"];
        displaySpeedCheck = NO;
        [self.displaySpeed setTitle:@"ON" forState:UIControlStateNormal];
        [self.displaySpeed setBackgroundColor:[UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1]];
    }
    
}

- (IBAction)VideoResolutionButton:(UIButton *)sender {
    
    [self showVideoResolutionCollection];
    
}

- (IBAction)videoBitRatesButton:(UIButton *)sender {
    [self showVideoBitRatesCollection];
    
}

- (IBAction)wdrButton:(UIButton *)sender {
    
    if (!wdrCheck) {
        [[CameraManager cameraManager] params:@"off" type:@"wdr_mode2"];
        [self.wdr setTitle:@"OFF" forState:UIControlStateNormal];
        [self.wdr setBackgroundColor:[UIColor colorWithRed:166/256.0 green:166/256.0 blue:166/256.0 alpha:1]];
        wdrCheck = YES;
        
    } else {
        [[CameraManager cameraManager] params:@"on" type:@"wdr_mode2"];
        wdrCheck = NO;
        [self.wdr setTitle:@"ON" forState:UIControlStateNormal];
        [self.wdr setBackgroundColor:[UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1]];
    }
}

- (IBAction)fieldOfViewButton:(UIButton *)sender {
    
    [self showfieldOfViewCollection];
    
}

- (IBAction)videoClipButton:(UIButton *)sender {
    [self showVideoClipCollection];
    
}


#pragma mark -ActionSetData
- (IBAction)resolution1Button:(UIButton *)sender {
    self.resolutionDesctinationLabel.text = self.resolution1Label.text;
    [self checkFieldOfView];
    [self hideWDRAndTimeLapseAndFieldOfView:NO];
    [[CameraManager cameraManager] params:@"2560x1080 30P 21:9" type:@"video_resolution_mode2"];
    for (UITableViewCell * cell in self.videoResolutionCollection) {
        [self cell:cell setHidden:YES];
        [self reloadDataAnimated:YES];
        videoResolutionCheck = YES;
    }
}

- (IBAction)resolution2Button:(UIButton *)sender {
    self.resolutionDesctinationLabel.text = self.resolution2Label.text;
    [self checkFieldOfView];
    [self hideWDRAndTimeLapseAndFieldOfView:NO];
    [[CameraManager cameraManager] params:@"2304x1296 30P 16:9" type:@"video_resolution_mode2"];
    for (UITableViewCell * cell in self.videoResolutionCollection) {
        [self cell:cell setHidden:YES];
        [self reloadDataAnimated:YES];
        videoResolutionCheck = YES;
    }
}

- (IBAction)resolution3Button:(UIButton *)sender {
    self.resolutionDesctinationLabel.text = self.resolution3Label.text;
    [self checkFieldOfView];
    [self hideWDRAndTimeLapseAndFieldOfView:NO];
     [[CameraManager cameraManager] params:@"1920x1080 60P 16:9" type:@"video_resolution_mode2"];
    for (UITableViewCell * cell in self.videoResolutionCollection) {
        [self cell:cell setHidden:YES];
        [self reloadDataAnimated:YES];
        videoResolutionCheck = YES;
    }
}



- (IBAction)resolution5Button:(UIButton *)sender {
    self.resolutionDesctinationLabel.text = self.resolution4Label.text;
    [self checkFieldOfView];
    [self hideWDRAndTimeLapseAndFieldOfView:NO];
     [[CameraManager cameraManager] params:@"1920x1080 45P 16:9" type:@"video_resolution_mode2"];
    for (UITableViewCell * cell in self.videoResolutionCollection) {
        [self cell:cell setHidden:YES];
        [self reloadDataAnimated:YES];
        videoResolutionCheck = YES;
    }
}

- (IBAction)resolution6Button:(UIButton *)sender {
    self.resolutionDesctinationLabel.text = self.resolution5Label.text;
    [self checkFieldOfView];
    [self hideWDRAndTimeLapseAndFieldOfView:NO];
      [[CameraManager cameraManager] params:@"1920x1080 30P 16:9" type:@"video_resolution_mode2"];
    for (UITableViewCell * cell in self.videoResolutionCollection) {
        [self cell:cell setHidden:YES];
        [self reloadDataAnimated:YES];
        videoResolutionCheck = YES;
    }
}

- (IBAction)resolution7Button:(UIButton *)sender {
    self.resolutionDesctinationLabel.text = self.resolution6Label.text;
    [self checkFieldOfView];
    [self hideWDRAndTimeLapseAndFieldOfView:YES];
     [[CameraManager cameraManager] params:@"HDR 1920x1080 30P 16:9" type:@"video_resolution_mode2"];
    for (UITableViewCell * cell in self.videoResolutionCollection) {
        [self cell:cell setHidden:YES];
        [self reloadDataAnimated:YES];
        videoResolutionCheck = YES;
    }
}

- (IBAction)resolution8Button:(UIButton *)sender {
    self.resolutionDesctinationLabel.text = self.resolution7Label.text;
    [self checkFieldOfView];
    [self hideWDRAndTimeLapseAndFieldOfView:YES];
    [[CameraManager cameraManager] params:@"1280x720 60P 16:9" type:@"video_resolution_mode2"];
    for (UITableViewCell * cell in self.videoResolutionCollection) {
        [self cell:cell setHidden:YES];
        [self reloadDataAnimated:YES];
        videoResolutionCheck = YES;
    }
}

- (IBAction)resolution9Button:(UIButton *)sender {
    self.resolutionDesctinationLabel.text = self.resolution8Label.text;
    [self checkFieldOfView];
    [self hideWDRAndTimeLapseAndFieldOfView:NO];
     [[CameraManager cameraManager] params:@"1280x720 30P 16:9" type:@"video_resolution_mode2"];
    for (UITableViewCell * cell in self.videoResolutionCollection) {
        [self cell:cell setHidden:YES];
        [self reloadDataAnimated:YES];
        videoResolutionCheck = YES;
    }
}


-(void) hideWDRAndTimeLapseAndFieldOfView:(BOOL)hide
{
    if (hide) {
        [[[UIAlertView alloc] initWithTitle:@"" message:@"HDR mode can not support FOV change, or else camera may get hanged" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }
    
    timeLapseCheck = NO;
    [self showTimeLapseCollection];
    
    [self cell:timeLapseCell setHidden:hide];
    [self cell:wdrCell setHidden:hide];
    self.fieldOfViewButton.enabled = !hide;
}





- (IBAction)videoBit1Button:(UIButton *)sender {
    self.videoBitDestinationLabel.text = self.videoBit1Label.text;
     [[CameraManager cameraManager] params:@"S.Fine" type:@"video_quality_mode2"];
    for (UITableViewCell * cell in self.videoBitRatesCollection) {
        [self cell:cell setHidden:YES];
        [self reloadDataAnimated:YES];
        videoBitRatesCheck = YES;
    }
}

- (IBAction)videoBit2Button:(UIButton *)sender {
    self.videoBitDestinationLabel.text = self.videoBit2Label.text;
     [[CameraManager cameraManager] params:@"Fine" type:@"video_quality_mode2"];
    for (UITableViewCell * cell in self.videoBitRatesCollection) {
        [self cell:cell setHidden:YES];
        [self reloadDataAnimated:YES];
        videoBitRatesCheck = YES;
    }
    
}

- (IBAction)videoBit3Button:(UIButton *)sender {
    self.videoBitDestinationLabel.text = self.videoBit3Label.text;
     [[CameraManager cameraManager] params:@"Normal" type:@"video_quality_mode2"];
    for (UITableViewCell * cell in self.videoBitRatesCollection) {
        [self cell:cell setHidden:YES];
        [self reloadDataAnimated:YES];
        videoBitRatesCheck = YES;
    }
    
}

- (IBAction)fieldOfView1Button:(UIButton *)sender {
    self.fieldOfViewDestinationLabel.text = self.fieldOfView1Label.text;
     [[CameraManager cameraManager] params:@"155" type:@"fleld_view_mode2"];
    for (UITableViewCell * cell in self.fieldOfViewCollection) {
        [self cell:cell setHidden:YES];
        [self reloadDataAnimated:YES];
        fieldOfViewCheck = YES;
    }
}

- (IBAction)fieldOfView2Button:(UIButton *)sender {
    self.fieldOfViewDestinationLabel.text = self.fieldOfView2Label.text;
     [[CameraManager cameraManager] params:@"120" type:@"fleld_view_mode2"];
    for (UITableViewCell * cell in self.fieldOfViewCollection) {
        [self cell:cell setHidden:YES];
        [self reloadDataAnimated:YES];
        fieldOfViewCheck = YES;
    }
}

- (IBAction)fieldOfView3Button:(UIButton *)sender {
    self.fieldOfViewDestinationLabel.text = self.fieldOfView3Label.text;
     [[CameraManager cameraManager] params:@"90" type:@"fleld_view_mode2"];
    for (UITableViewCell * cell in self.fieldOfViewCollection) {
        [self cell:cell setHidden:YES];
        [self reloadDataAnimated:YES];
        fieldOfViewCheck = YES;
    }
}

- (IBAction)fieldOfView4Button:(UIButton *)sender {
    self.fieldOfViewDestinationLabel.text = self.fieldOfView4Label.text;
     [[CameraManager cameraManager] params:@"60" type:@"fleld_view_mode2"];
    for (UITableViewCell * cell in self.fieldOfViewCollection) {
        [self cell:cell setHidden:YES];
        [self reloadDataAnimated:YES];
        fieldOfViewCheck = YES;
    }
}
- (IBAction)timeLaps1Button:(UIButton *)sender {
    self.timeLapsDestinationLabel.text = self.timeLaps1Label.text;
    [self checkFieldOfView];
     [[CameraManager cameraManager] params:@"off" type:@"timelapse_video_mode2"];
    for (UITableViewCell * cell in self.timeLapseCollection) {
        [self cell:cell setHidden:YES];
        [self reloadDataAnimated:YES];
        timeLapseCheck = YES;
    }
}

- (IBAction)timeLaps2Button:(UIButton *)sender {
    self.timeLapsDestinationLabel.text = self.timeLaps2Label.text;
    [self checkFieldOfView];
      [[CameraManager cameraManager] params:@"1_sec" type:@"timelapse_video_mode2"];
    for (UITableViewCell * cell in self.timeLapseCollection) {
        [self cell:cell setHidden:YES];
        [self reloadDataAnimated:YES];
        timeLapseCheck = YES;
    }
}

- (IBAction)timeLaps3Button:(UIButton *)sender {
    self.timeLapsDestinationLabel.text = self.timeLaps3Label.text;
    [self checkFieldOfView];
     [[CameraManager cameraManager] params:@"5_sec" type:@"timelapse_video_mode2"];
    for (UITableViewCell * cell in self.timeLapseCollection) {
        [self cell:cell setHidden:YES];
        [self reloadDataAnimated:YES];
        timeLapseCheck = YES;
    }
}

- (IBAction)timeLaps4Button:(UIButton *)sender {
    self.timeLapsDestinationLabel.text = self.timeLaps4Label.text;
    [self checkFieldOfView];
      [[CameraManager cameraManager] params:@"10_sec" type:@"timelapse_video_mode2"];
    for (UITableViewCell * cell in self.timeLapseCollection) {
        [self cell:cell setHidden:YES];
        [self reloadDataAnimated:YES];
        timeLapseCheck = YES;
    }
}

- (IBAction)timeLaps5Button:(UIButton *)sender {
    self.timeLapsDestinationLabel.text = self.timeLaps5Label.text;
    [self checkFieldOfView];
      [[CameraManager cameraManager] params:@"30_sec" type:@"timelapse_video_mode2"];
    for (UITableViewCell * cell in self.timeLapseCollection) {
        [self cell:cell setHidden:YES];
        [self reloadDataAnimated:YES];
        timeLapseCheck = YES;
    }
}


- (IBAction)videoClip1Button:(UIButton *)sender {
    self.videoClipDestinationLabel.text = self.videoClip1Label.text;
    [[CameraManager cameraManager] params:@"1_min" type:@"video_length_mode2"];
    for (UITableViewCell * cell in self.videoClipCollection) {
        [self cell:cell setHidden:YES];
        [self reloadDataAnimated:YES];
        videoClipCheck = YES;
    }
    
}

- (IBAction)videoClip2Button:(UIButton *)sender {
    self.videoClipDestinationLabel.text = self.videoClip2Label.text;
       [[CameraManager cameraManager] params:@"2_min" type:@"video_length_mode2"];
    for (UITableViewCell * cell in self.videoClipCollection) {
        [self cell:cell setHidden:YES];
        [self reloadDataAnimated:YES];
        videoClipCheck = YES;
    }
    
}

- (IBAction)videoClip3Button:(UIButton *)sender {
    self.videoClipDestinationLabel.text = self.videoClip3Label.text;
    [[CameraManager cameraManager] params:@"3_min" type:@"video_length_mode2"];
    for (UITableViewCell * cell in self.videoClipCollection) {
        [self cell:cell setHidden:YES];
        [self reloadDataAnimated:YES];
        videoClipCheck = YES;
    }
    
}

- (IBAction)videoClip4Button:(UIButton *)sender {
    self.videoClipDestinationLabel.text = self.videoClip4Label.text;
    [[CameraManager cameraManager] params:@"5_min" type:@"video_length_mode2"];
    for (UITableViewCell * cell in self.videoClipCollection) {
        [self cell:cell setHidden:YES];
        [self reloadDataAnimated:YES];
        videoClipCheck = YES;
    }
    
}

- (IBAction)videoClip5Button:(UIButton *)sender {
    self.videoClipDestinationLabel.text = self.videoClip5Label.text;
    [[CameraManager cameraManager] params:@"10_min" type:@"video_length_mode2"];
    for (UITableViewCell * cell in self.videoClipCollection) {
        [self cell:cell setHidden:YES];
        [self reloadDataAnimated:YES];
        videoClipCheck = YES;
    }
    
}

- (IBAction)videoClip6Button:(UIButton *)sender {
    self.videoClipDestinationLabel.text = self.videoClip6Label.text;
     [[CameraManager cameraManager] params:@"continuous" type:@"video_length_mode2"];
    for (UITableViewCell * cell in self.videoClipCollection) {
        [self cell:cell setHidden:YES];
        [self reloadDataAnimated:YES];
        videoClipCheck = YES;
    }
    
}

- (IBAction)resetAllSettings:(UIButton *)sender {
    
    self.resetAllSettingsMode2Label.backgroundColor = [UIColor colorWithRed:166/256.0 green:166/256.0 blue:166/256.0 alpha:1];
    
    [self startIndicator];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        
        if ([self.appDelegate isConnected])
        {
//            [[CameraManager cameraManager] resetAllSettings];
        [[CameraManager cameraManager] resetAllSettings:@"2560x1080 30P 21:9" type:@"video_resolution_mode2"];
        [[CameraManager cameraManager] resetAllSettings:@"on" type:@"audio_mode2"];
        [[CameraManager cameraManager] resetAllSettings:@"on" type:@"video_timestamp_mode2"];
        [[CameraManager cameraManager] resetAllSettings:@"normal" type:@"rotate_video_mode2"];
        [[CameraManager cameraManager] resetAllSettings:@"on" type:@"loop_record_mode2"];
            
        [[CameraManager cameraManager] resetAllSettings:@"S.Fine" type:@"video_quality_mode2"];
        [[CameraManager cameraManager] resetAllSettings:@"on" type:@"wdr_mode2"];
        [[CameraManager cameraManager] resetAllSettings:@"155" type:@"fleld_view_mode2"];
        [[CameraManager cameraManager] resetAllSettings:@"off" type:@"timelapse_video_mode2"];
        [[CameraManager cameraManager] resetAllSettings:@"off" type:@"speed_stamp_mode2"];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            
            for (UITableViewCell * cell in self.videoResolutionCollection) {
                [self cell:cell setHidden:YES];
                videoResolutionCheck = YES;
            }
            self.resolutionDesctinationLabel.text = @"2560x1080 30P 21:9";
            
            audioCheck = YES;
            [self.audio setTitle:@"ON" forState:UIControlStateNormal];
            [self.audio setBackgroundColor:[UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1]];
            
            
            
            videoTimeStampCheck = YES;
            [self.videoTimeStamp setTitle:@"ON" forState:UIControlStateNormal];
            [self.videoTimeStamp setBackgroundColor:[UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1]];
            
            
            
            rotateDegreesCheck = YES;
            [self.rotateDegrees setTitle:@"ON" forState:UIControlStateNormal];
            [self.rotateDegrees setBackgroundColor:[UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1]];
            
            
            
            
            for (UITableViewCell * cell in self.videoClipCollection) {
                [self cell:cell setHidden:YES];
                videoClipCheck = YES;
            }
            loopRecordingCheck = NO;
            [self cell:self.VideoClipCell setHidden:NO];
            [self.loopRecording setTitle:@"ON" forState:UIControlStateNormal];
            [self.loopRecording setBackgroundColor:[UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1]];
            
            self.videoClipDestinationLabel.text = @"3_min";
            
            
            for (UITableViewCell * cell in self.videoBitRatesCollection) {
                [self cell:cell setHidden:YES];
                videoBitRatesCheck = YES;
            }
            self.videoBitDestinationLabel.text = @"High";
            
            
            wdrCheck = NO;
            [self.wdr setTitle:@"ON" forState:UIControlStateNormal];
            [self.wdr setBackgroundColor:[UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1]];
            
            
            
            for (UITableViewCell * cell in self.fieldOfViewCollection) {
                [self cell:cell setHidden:YES];
                fieldOfViewCheck = YES;
            }
            self.fieldOfViewDestinationLabel.text = @"155";
            
            
            
            for (UITableViewCell * cell in self.timeLapseCollection) {
                [self cell:cell setHidden:YES];
                timeLapseCheck = YES;
            }
            self.timeLapsDestinationLabel.text = @"off";
            
            
            displaySpeedCheck = YES;
            [self.displaySpeed setTitle:@"OFF" forState:UIControlStateNormal];
            [self.displaySpeed setBackgroundColor:[UIColor colorWithRed:166/256.0 green:166/256.0 blue:166/256.0 alpha:1]];
            
            [self.indicator stopAnimating];
            self.bgrdResetView.hidden = YES;
            self.tableView.scrollEnabled = YES;
            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
            [self reloadDataAnimated:YES];
            [self alertResetSettings];
        });
    });
}

-(void)resetSettingsMode2ButtonHighlight:(UIButton*) button {
    
    self.resetAllSettingsMode2Label.backgroundColor = [UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1];
}

-(void)resetSettingsMode2Button:(UIButton*) button {
    
    self.resetAllSettingsMode2Label.backgroundColor = [UIColor colorWithRed:166/256.0 green:166/256.0 blue:166/256.0 alpha:1];
}

-(void) startIndicator {
    
    self.tableView.scrollEnabled = NO;
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    self.bgrdResetView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
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


- (IBAction)imageRotationShowButton:(UIButton *)sender {
    if (imageRotationCheck) {
        for (UITableViewCell * cell in imageRotationCellArray) {
            [self cell:cell setHidden:NO];
            [self reloadDataAnimated:YES];
            imageRotationCheck = NO;
        }
    } else {
        
        for (UITableViewCell * cell in imageRotationCellArray) {
            [self cell:cell setHidden:YES];
            [self reloadDataAnimated:YES];
            imageRotationCheck = YES;
        }
    }
}
- (IBAction)imageRotationOneButton:(UIButton *)sender {
    imageRotationLabel.text = @"normal";
    
    [[CameraManager cameraManager] params:@"normal" type:@"rotate_video_mode2"];
    
    for (UITableViewCell * cell in imageRotationCellArray) {
        [self cell:cell setHidden:YES];
        [self reloadDataAnimated:YES];
        imageRotationCheck = YES;
    }
}
- (IBAction)imageRotationTwoButton:(UIButton *)sender {
    imageRotationLabel.text = @"180 degree";
    
    [[CameraManager cameraManager] params:@"180 degree" type:@"rotate_video_mode2"];
    
    for (UITableViewCell * cell in imageRotationCellArray) {
        [self cell:cell setHidden:YES];
        [self reloadDataAnimated:YES];
        imageRotationCheck = YES;
    }
}
- (IBAction)imageRotationThreeButton:(UIButton *)sender {
    imageRotationLabel.text = @"auto rotation";
    
    [[CameraManager cameraManager] params:@"auto rotation" type:@"rotate_video_mode2"];
    
    for (UITableViewCell * cell in imageRotationCellArray) {
        [self cell:cell setHidden:YES];
        [self reloadDataAnimated:YES];
        imageRotationCheck = YES;
    }
}

@end
