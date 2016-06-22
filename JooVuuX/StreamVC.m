//
//  StreamVC.m
//  JooVuuX
//
//  Created by Vladislav on 01.10.15.
//  Copyright (c) 2015 lsoft. All rights reserved.
//

#import "StreamVC.h"
#import "WhiteBalanceVC.h"
#import "ModeSettingsVC.h"
#import "PopUpDialogDiligate.h"
#import "XDPopupListView.h"
#import <CoreGraphics/CoreGraphics.h>
#import "CameraManager.h"
#import "AppDelegate.h"
static NSString * checkWindow = @"checkWindows";

@interface StreamVC () <UIGestureRecognizerDelegate, UIScrollViewDelegate>
{
    __weak IBOutlet UIView *infoView;
    __weak IBOutlet UIScrollView *infoScrollView;
    
}

@property (nonatomic,retain) AppDelegate *appDelegate;
@property (weak, nonatomic) IBOutlet UIView *modeView;
@property BOOL emergency;
@property (strong, nonatomic) UIImage * normalState;
@property (strong, nonatomic) UIImage * clearState;
@property (strong, nonatomic) UIImage * emergencyState;
@property (strong, nonatomic) KxMovieViewController * vc;

@end

@implementation StreamVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    self.appDelegate = [[UIApplication sharedApplication] delegate];
    self.backgroundModeView.frame = self.view.frame;
    self.backgroundModeView.hidden = YES;
    [self.navigationController.view addSubview:self.backgroundModeView];

    UITapGestureRecognizer *singleTap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleFingerTap2:)];
    [singleTap2 setNumberOfTouchesRequired:1];
    [singleTap2 setDelegate:self];
    [self.backgroundModeView addGestureRecognizer:singleTap2];
    self.emergency = YES;
    self.modeView.hidden = YES;
    self.normalState = [UIImage imageNamed:@"video"];
    self.clearState = [UIImage imageNamed:@"video_press"];
    self.emergencyState = [UIImage imageNamed:@"video"];
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:72/255.0 green:216/255.0 blue:183/255.0 alpha:1];
    [self.navigationController.navigationBar setTitleTextAttributes: @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self interfaceOrient];
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkRecording) name:@"checkCameraRecording" object:nil];
    if ([self.appDelegate isConnected])
    {
        [self startIndicator];
        [self performSelector:@selector(startStream) withObject:nil afterDelay:0.5];
        
    }
    else
    {
        [self alertNoInternetConnection];
    }
    
    
    [self setInfoView];
}



-(void) checkRecording
{
    if ([[CameraManager cameraManager] record]) {
        if (self.emergency) {
            [self cameraRecording];
            [self.stream setEnabled:NO];
            [self.settings setEnabled:NO];
        }
    }
    else
    {
        if (!self.emergency) {
            [self cameraRecording];
            [self.stream setEnabled:YES];
            [self.settings setEnabled:YES];
        }
    }
}

- (void)singleFingerTap2:(UITapGestureRecognizer *)recognizer {
    self.backgroundModeView.hidden = YES;
    self.modeView.hidden = YES;
}

-(void) alertNoInternetConnection
{
    [[[UIAlertView alloc] initWithTitle:@"" message:@"Connection fail. Check on WiFi settings and try to connect again." delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil] show];
}

-(void) startIndicator
{
    self.indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.indicator.center = self.view.center;
    [self.view addSubview:self.indicator];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self.indicator startAnimating];
}

-(void) startStream
{
    [[CameraManager cameraManager] paramsInfoDefaultMode:@"default_mode"];
    if ([[[CameraManager cameraManager] defaultMode] isEqualToString:@"mode1"]) {
        [self.modes setTitle:@"Mode 1" forState:UIControlStateNormal];
    }
    else
    {
       [self.modes setTitle:@"Mode 2" forState:UIControlStateNormal];
    }
    
    [[CameraManager cameraManager] startStreaming];
    [CameraManager cameraManager].strem = self;
}

-(void) startStreaming
{
    self.vc = [KxMovieViewController movieViewControllerWithContentPath:@"rtsp://192.168.42.1/live" parameters:nil];
    self.vc.isStreaming = YES;
    [self addChildViewController:self.vc];
    [self.vc.view setFrame:self.streamImageView.frame];
    [self.view addSubview:self.vc.view];
    self.vc.view.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.indicator stopAnimating];
    [[CameraManager cameraManager] startTimerRecording];
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    [[CameraManager cameraManager] stopTimerRecording];
}


-(void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if (toInterfaceOrientation == UIInterfaceOrientationPortrait)
    {
        self.orientation = @"Portrait";
        
        [self interfaceOrient];
    }
    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight)
    {
        self.orientation = @"Landscape";
        
        [self interfaceOrient];
    }
}

-(void)interfaceOrient {
    if ([self.orientation isEqualToString:@"Landscape"]) {
        infoView.hidden = YES;
        
        self.navigationController.navigationBar.hidden = YES;
        self.streamImageView.frame = CGRectMake(self.view.frame.origin.x,self.view.frame.origin.y,self.view.frame.size.width,self.view.frame.size.height);
        
        self.streamView.frame = CGRectMake(self.streamView.frame.origin.x,self.view.frame.origin.y,self.streamView.frame.size.width,self.streamView.frame.size.height);
        self.photoVIew.frame = CGRectMake(self.photoVIew.frame.origin.x,self.view.frame.origin.y,self.photoVIew.frame.size.width,self.photoVIew.frame.size.height);
        self.videoView.frame = CGRectMake(self.videoView.frame.origin.x,self.view.frame.origin.y,self.videoView.frame.size.width,self.videoView.frame.size.height);
        self.settingsView.frame = CGRectMake(self.settingsView.frame.origin.x,self.view.frame.origin.y,self.settingsView.frame.size.width,self.settingsView.frame.size.height);
        self.infoVIew.frame = CGRectMake(self.infoVIew.frame.origin.x,self.view.frame.origin.y,self.infoVIew.frame.size.width,self.infoVIew.frame.size.height);
        
        [self.vc.view setFrame:self.streamImageView.frame];
        
        [self.view bringSubviewToFront:self.streamView];
        [self.view bringSubviewToFront:self.photoVIew];
        [self.view bringSubviewToFront:self.videoView];
        [self.view bringSubviewToFront:self.settingsView];
        [self.view bringSubviewToFront:self.infoVIew];
    }
    if ([self.orientation isEqualToString:@"Portrait"])
    {
        infoView.hidden = NO;
        
        self.navigationController.navigationBar.hidden = NO;
        self.streamView.frame = CGRectMake(self.streamView.frame.origin.x,self.view.frame.size.height - self.streamView.frame.size.height,self.streamView.frame.size.width,self.streamView.frame.size.height);
        self.photoVIew.frame = CGRectMake(self.photoVIew.frame.origin.x,self.view.frame.size.height - self.streamView.frame.size.height,self.photoVIew.frame.size.width,self.photoVIew.frame.size.height);
        self.videoView.frame = CGRectMake(self.videoView.frame.origin.x,self.view.frame.size.height - self.streamView.frame.size.height,self.videoView.frame.size.width,self.videoView.frame.size.height);
        self.settingsView.frame = CGRectMake(self.settingsView.frame.origin.x,self.view.frame.size.height - self.streamView.frame.size.height,self.settingsView.frame.size.width,self.settingsView.frame.size.height);
        self.infoVIew.frame = CGRectMake(self.infoVIew.frame.origin.x,self.view.frame.size.height - self.streamView.frame.size.height,self.infoVIew.frame.size.width,self.infoVIew.frame.size.height);
        self.streamImageView.frame = CGRectMake(3,self.navigationController.navigationBar.frame.size.height + 3,self.view.frame.size.width - 6,self.view.frame.size.height - self.streamView.frame.size.height - self.navigationController.navigationBar.frame.size.height - infoView.frame.size.height - 8);
        [self.vc.view setFrame:self.streamImageView.frame];
        
        [self.view bringSubviewToFront:self.streamView];
        [self.view bringSubviewToFront:self.photoVIew];
        [self.view bringSubviewToFront:self.videoView];
        [self.view bringSubviewToFront:self.settingsView];
        [self.view bringSubviewToFront:self.infoVIew];
    }
}


-(void)setInterfaceButtons {
    if ([self.orientation isEqualToString:@"Landscape"]) {
        self.streamView.frame = CGRectMake(self.streamView.frame.origin.x,self.view.frame.origin.y,self.streamView.frame.size.width,self.streamView.frame.size.height);
        self.photoVIew.frame = CGRectMake(self.photoVIew.frame.origin.x,self.view.frame.origin.y,self.photoVIew.frame.size.width,self.photoVIew.frame.size.height);
        self.videoView.frame = CGRectMake(self.videoView.frame.origin.x,self.view.frame.origin.y,self.videoView.frame.size.width,self.videoView.frame.size.height);
        self.settingsView.frame = CGRectMake(self.settingsView.frame.origin.x,self.view.frame.origin.y,self.settingsView.frame.size.width,self.settingsView.frame.size.height);
        self.infoVIew.frame = CGRectMake(self.infoVIew.frame.origin.x,self.view.frame.origin.y,self.infoVIew.frame.size.width,self.infoVIew.frame.size.height);
        
        [self.vc.view setFrame:self.streamImageView.frame];
        
        [self.view bringSubviewToFront:self.streamView];
        [self.view bringSubviewToFront:self.photoVIew];
        [self.view bringSubviewToFront:self.videoView];
        [self.view bringSubviewToFront:self.settingsView];
        [self.view bringSubviewToFront:self.infoVIew];
    }
    if ([self.orientation isEqualToString:@"Portrait"])
    {
        self.photoVIew.frame = CGRectMake(self.photoVIew.frame.origin.x,self.view.frame.size.height - self.streamView.frame.size.height,self.photoVIew.frame.size.width,self.photoVIew.frame.size.height);
        self.videoView.frame = CGRectMake(self.videoView.frame.origin.x,self.view.frame.size.height - self.streamView.frame.size.height,self.videoView.frame.size.width,self.videoView.frame.size.height);
        self.settingsView.frame = CGRectMake(self.settingsView.frame.origin.x,self.view.frame.size.height - self.streamView.frame.size.height,self.settingsView.frame.size.width,self.settingsView.frame.size.height);
        self.infoVIew.frame = CGRectMake(self.infoVIew.frame.origin.x,self.view.frame.size.height - self.streamView.frame.size.height,self.infoVIew.frame.size.width,self.infoVIew.frame.size.height);
        self.streamImageView.frame = CGRectMake(3,self.navigationController.navigationBar.frame.size.height + 3,self.view.frame.size.width - 6,self.view.frame.size.height - self.streamView.frame.size.height - self.navigationController.navigationBar.frame.size.height - infoView.frame.size.height - 8);
        [self.vc.view setFrame:self.streamImageView.frame];
        
        [self.view bringSubviewToFront:self.streamView];
        [self.view bringSubviewToFront:self.photoVIew];
        [self.view bringSubviewToFront:self.videoView];
        [self.view bringSubviewToFront:self.settingsView];
        [self.view bringSubviewToFront:self.infoVIew];
    }
}

- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [self setInterfaceButtons];
}


#pragma mark - Actions

- (IBAction)back:(UIBarButtonItem *)sender
{
    if ([self.appDelegate isConnected]) {
        [self startIndicator];
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
            [[CameraManager cameraManager] closeStream];
        });
        [self performSelector:@selector(dissmissStreamFromBack) withObject:nil afterDelay:1];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"getToken" object:nil];
}

-(void) dissmissStreamFromBack
{
    [self.vc doneDidTouch:self];
    [self.indicator stopAnimating];
}

-(void) dissmissStreamFromW
{
    WhiteBalanceVC * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"WhiteBalanceVC"];
    [self.navigationController dismissViewControllerAnimated:NO completion:nil];
    [self.navigationController pushViewController:vc animated:YES];
    [self.indicator stopAnimating];
}

-(void) dissmissStreamFromSettings
{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:checkWindow];
    ModeSettingsVC * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ModeSettingsVC"];
    vc.orientation = self.orientation;
    [self.navigationController dismissViewControllerAnimated:NO completion:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)streamWButton:(UIButton *)sender {
    if ([self.appDelegate isConnected]) {
        [self startIndicator];
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
            [[CameraManager cameraManager] closeStream];
        });
        [self performSelector:@selector(dissmissStreamFromW) withObject:nil afterDelay:1];
    }
    else
    {
        WhiteBalanceVC * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"WhiteBalanceVC"];
        [self.navigationController dismissViewControllerAnimated:NO completion:nil];
        [self.navigationController pushViewController:vc animated:YES];
    }
    self.streamView.backgroundColor = [UIColor whiteColor];

}

- (IBAction)photoButton:(UIButton *)sender {
    if ([self.appDelegate isConnected]) {
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
            [[CameraManager cameraManager] takePhoto];
        });
    }
    self.photoVIew.backgroundColor = [UIColor whiteColor];
}

- (IBAction)videoButton:(UIButton *)sender {
    if ([self.appDelegate isConnected]) {
        [self imageFlash];
    }
    self.videoView.backgroundColor = [UIColor whiteColor];
}

- (IBAction)settingsButton:(UIButton *)sender {
    
    if ([self.appDelegate isConnected]) {
        [self startIndicator];
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
            [[CameraManager cameraManager] closeStream];
        });
        [self performSelector:@selector(dissmissStreamFromSettings) withObject:nil afterDelay:1];
    }
    else
    {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:checkWindow];
        ModeSettingsVC * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ModeSettingsVC"];
        vc.orientation = self.orientation;
        [self.navigationController dismissViewControllerAnimated:NO completion:nil];
        [self.navigationController pushViewController:vc animated:YES];
    }
    self.settingsView.backgroundColor = [UIColor whiteColor];
}

-(void) setInfoView {
    
    for (UIView * view in [infoScrollView subviews]) {
        [view removeFromSuperview];
    }    
    infoScrollView.delegate = self;
    NSMutableDictionary * allSetting = [[CameraManager cameraManager] allSettingsDict];
    NSArray * array = [NSArray new];
    
    if ([self.modes.titleLabel.text isEqualToString:@"Mode 1"]) {
        array = [allSetting valueForKey:@"modeOne"];
    } else {
        array = [allSetting valueForKey:@"modeTwo"];
    }
    
    float x = 0;
    
    UILabel * mode = [[UILabel alloc] initWithFrame:CGRectMake(8, x, infoView.frame.size.width - 16, 20)];
    mode.text = [NSString stringWithFormat:@"Mode Settings"];
    mode.textColor = [UIColor lightGrayColor];
    [mode setTextAlignment:NSTextAlignmentCenter];
    [infoScrollView addSubview:mode];
    
    x += 40;
    
    for (NSDictionary * dict in array) {
        
        int index = [array indexOfObject:dict];
        if (index == 3 || index == 9) {
            continue;
        }
        
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(8, x, 180, 20)];
        label.textColor = [UIColor lightGrayColor];
        [label setFont:[UIFont systemFontOfSize:13]];
        [infoScrollView addSubview:label];
        
        UILabel * label2 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(infoView.frame) - 120 - 8, x, 120, 20)];
        label2.textColor = [UIColor whiteColor];
        [label2 setTextAlignment:NSTextAlignmentRight];
        [label2 setFont:[UIFont systemFontOfSize:13]];
        label2.text = [dict valueForKey:[[dict allKeys] firstObject]];
        [infoScrollView addSubview:label2];
        
        switch (index) {
            case 0:
                label2.frame = CGRectMake(CGRectGetMaxX(infoView.frame) - 170 - 8, x, 170, 20);
                label.text = @"Video Resolutions:";
                break;
            case 1:
                label.text = @"Audio:";
                break;
            case 2:
                label.text = @"Video Time Stamp:";
                break;
            case 4:
                label.text = @"Loop Recording:";
                break;
            case 5:
                label.text = @"Video Bit Rates:";
                break;
            case 6:
                label.text = @"WDR:";
                break;
            case 7:
                label.text = @"Field of View:";
                break;
            case 8:
                label.text = @"Time Lapse Video:";
                break;
            default:
                break;
        }
        x += 40;
    }
    
    
    array = [allSetting valueForKey:@"mainSettings"];
    UILabel * main = [[UILabel alloc] initWithFrame:CGRectMake(8, x + 20, infoView.frame.size.width - 16, 20)];
    main.text = [NSString stringWithFormat:@"Main Settings"];
    main.textColor = [UIColor lightGrayColor];
    [main setTextAlignment:NSTextAlignmentCenter];
    [infoScrollView addSubview:main];
    
    x += 60;
    
    for (NSDictionary * dict in array) {
        
        int index = [array indexOfObject:dict];
        if (index == 5 || index == 18 || index == 19) {
            continue;
        }
        
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(8, x, 180, 20)];
        label.textColor = [UIColor lightGrayColor];
        [label setFont:[UIFont systemFontOfSize:13]];
        [infoScrollView addSubview:label];
        
        UILabel * label2 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(infoView.frame) - 120 - 8, x, 120, 20)];
        label2.textColor = [UIColor whiteColor];
        [label2 setTextAlignment:NSTextAlignmentRight];
        [label2 setFont:[UIFont systemFontOfSize:13]];
        label2.text = [dict valueForKey:[[dict allKeys] firstObject]];
        [infoScrollView addSubview:label2];
        
        switch (index) {
            case 0:
                label.text = @"Data Format:";
                break;
            case 1:
                label.text = @"Beep Noises:";
                break;
            case 2:
                label.text = @"Recording LED indicator:";
                break;
            case 3:
                label.text = @"Default Mode Caerma Starts:";
                break;
            case 4:
                label.text = @"StandBy Time:";
                break;
            case 6:
                label.text = @"Motio Detection:";
                break;
            case 7:
                label.text = @"Motion Detection Sensitivity:";
                break;
            case 8:
                label.text = @"Motion Turn Off:";
                break;
            case 9:
                label.text = @"G-Sensor Sensivity:";
                break;
            case 10:
                label.text = @"Car Plate Stamp:";
                break;
            case 11:
                label.text = @"Car Number:";
                break;
            case 12:
                label.text = @"WiFi Password:";
                break;
            case 13:
                label.text = @"Speed Stamp:";
                break;
            case 14:
                label.text = @"Speed Unit:";
                break;
            case 15:
                label.text = @"Timed Mode:";
                break;
            case 16:
                label.text = @"From Time:";
                break;
            case 17:
                label.text = @"To Time:";
                break;
            default:
                break;
        }
        x += 40;
    }
    
    infoScrollView.contentSize = CGSizeMake(infoScrollView.frame.size.width, x);
}


- (IBAction)infoButton:(UIButton *)sender
{
    
    
    
    self.infoVIew.backgroundColor = [UIColor whiteColor];
}


-(IBAction)modeList:(UIButton *)sender
{
    if ([self.appDelegate isConnected]) {
        self.modeView.hidden = NO;
        [self.navigationController.view addSubview:self.modeView];
        self.backgroundModeView.hidden = NO;
    }
    self.modes.backgroundColor = [UIColor colorWithRed:214/256.0 green:214/256.0 blue:214/256.0 alpha:1];
}

- (IBAction)modeOneButton:(UIButton *)sender {
    [self startIndicator];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        [[CameraManager cameraManager] setStreamParams:@"mode1" type:@"default_mode"];
    });
    [self.indicator stopAnimating];
    [self startStreaming];
    self.modeOneLabel.backgroundColor = [UIColor whiteColor];
    [self.modes setTitle:@"Mode 1" forState:UIControlStateNormal];
    self.modeView.hidden = YES;
    self.backgroundModeView.hidden = YES;
    
    [self setInfoView];
}


- (IBAction)modeTwoButton:(UIButton *)sender {
    [self startIndicator];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        [[CameraManager cameraManager] setStreamParams:@"mode2" type:@"default_mode"];
    });
    [self.indicator stopAnimating];
    [self startStreaming];
    self.modeTwoLabel.backgroundColor = [UIColor whiteColor];
    [self.modes setTitle:@"Mode 2" forState:UIControlStateNormal];
    self.modeView.hidden = YES;
    self.backgroundModeView.hidden = YES;
    
    [self setInfoView];
}


-(void) imageFlash{
    CABasicAnimation *imageAnimation = [CABasicAnimation animationWithKeyPath:@"contents"];
    CABasicAnimation *theAnimation=[CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    
    if(self.emergency ){
         dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        [[CameraManager cameraManager] startRecording];
         });
        imageAnimation.duration = 1.2f;
        theAnimation.duration=1.2f;
        imageAnimation.repeatCount = INFINITY;
        theAnimation.repeatCount=HUGE_VALF;
        theAnimation.autoreverses=YES;
        imageAnimation.autoreverses=YES;
        self.emergency = NO;
    }
    else{
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
            [[CameraManager cameraManager] stopRecording];
        });
        imageAnimation.repeatCount = 0;
        theAnimation.repeatCount = 0;
        self.emergency = YES;
    }
    imageAnimation.fromValue = (id)self.emergencyState.CGImage;
    imageAnimation.toValue = (id)self.clearState.CGImage;
    [self.video.imageView.layer addAnimation:imageAnimation forKey:@"animateContents"];
    [self.video setImage:self.normalState forState:UIControlStateNormal];
    theAnimation.fromValue= (id)[[UIColor whiteColor] CGColor];
    theAnimation.toValue= (id)[[UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1] CGColor];
    [self.video.layer addAnimation:theAnimation forKey:@"ColorPulseVideo"];
    [self.videoView.layer addAnimation:theAnimation forKey:@"ColorPulseVideoView"];
    [self.video.imageView.layer addAnimation:theAnimation forKey:@"ColorPulseVideoViewImage"];
}

-(void) cameraRecording
{
    CABasicAnimation *imageAnimation = [CABasicAnimation animationWithKeyPath:@"contents"];
    CABasicAnimation *theAnimation=[CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    if(self.emergency){
        imageAnimation.duration = 1.2f;
        theAnimation.duration=1.2f;
        imageAnimation.repeatCount = INFINITY;
        theAnimation.repeatCount=HUGE_VALF;
        theAnimation.autoreverses=YES;
        imageAnimation.autoreverses=YES;
        self.emergency = NO;
    }
    else{
        imageAnimation.repeatCount = 0;
        theAnimation.repeatCount = 0;
        self.emergency = YES;
    }
    imageAnimation.fromValue = (id)self.emergencyState.CGImage;
    imageAnimation.toValue = (id)self.clearState.CGImage;
    [self.video.imageView.layer addAnimation:imageAnimation forKey:@"animateContents"];
    [self.video setImage:self.normalState forState:UIControlStateNormal];
    theAnimation.fromValue= (id)[[UIColor whiteColor] CGColor];
    theAnimation.toValue= (id)[[UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1] CGColor];
    [self.video.layer addAnimation:theAnimation forKey:@"ColorPulseVideo"];
    [self.videoView.layer addAnimation:theAnimation forKey:@"ColorPulseVideoView"];
    [self.video.imageView.layer addAnimation:theAnimation forKey:@"ColorPulseVideoViewImage"];
}

@end
