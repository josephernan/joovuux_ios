//
//  MainScreenVC.m
//  JooVuuX
//
//  Created by Vladislav on 25.09.15.
//  Copyright (c) 2015 lsoft. All rights reserved.
//

#import "MainScreenVC.h"
#import "ModeSettingsVC.h"
#import "MainSettingsVC.h"
#import "CameraFmVC.h"
#import "StreamVC.h"
#import "ConnectionVC.h"
#import "CameraManager.h"
#import "GalleryCVC.h"
#import "AppDelegate.h"
@interface MainScreenVC ()
{
    BOOL cameraRecording;
    BOOL checkWindow;
    BOOL takePhoto;
}
@property (strong, nonatomic) NSString * orientation;
@property (assign, nonatomic) BOOL checkWifiConnection;
@property (weak, nonatomic) IBOutlet UILabel *alertLabel;
@property (nonatomic,retain) AppDelegate *appDelegate;
@property (strong, nonatomic) NSTimer * timer;
@end

@implementation MainScreenVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
}
-(void) viewWillDisappear:(BOOL)animated
{
    [[CameraManager cameraManager] stopTimerRecording];
    [super viewWillDisappear:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void) viewDidAppear:(BOOL)animated
{
}

-(void) dealloc
{
    
   // [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    
    checkWindow = NO;
    [[NSUserDefaults standardUserDefaults] setBool:checkWindow forKey:@"checkWindows"];
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showAlertLabel) name:@"CameraDisconnected" object:nil];
    
    self.orientation = nil;
    self.navigationController.navigationBar.hidden = YES;
    self.emergency = YES;
    self.normalState = [UIImage imageNamed:@"video"];
    self.clearState = [UIImage imageNamed:@"video_press"];
    self.emergencyState = [UIImage imageNamed:@"video"];
    self.appDelegate = [[UIApplication sharedApplication] delegate];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getToken) name:@"getToken" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkRecording) name:@"checkCameraRecording" object:nil];
}

-(void) checkRecording
{
    if ([[CameraManager cameraManager] record]) {
        if (self.emergency) {
            [self cameraRecording];
        }
        [self.mainSettings setEnabled:NO];
        [self.modeSettings setEnabled:NO];
    }
    else
    {
        if (!self.emergency) {
            [self cameraRecording];
        }
        [self.mainSettings setEnabled:YES];
        [self.modeSettings setEnabled:YES];
    }
}


-(void) getToken
{
    if (![[CameraManager cameraManager] checkToken]) {
        if ([self.appDelegate isConnected])
        {
            [self startConnectedToCamera];
            [self connectCamera:@"Connecting, please wait" interval:2];
            [self connectCamera:@"Connecting please wait" interval:3];
            [self connectCamera:@"Connecting, please wait" interval:4];
            [self connectCamera:@"Reconnecting..." interval:5];
            [self connectCamera:@"Reconnecting..." interval:6];
            [self performSelector:@selector(getAllInfo) withObject:nil afterDelay:4];
            [self performSelector:@selector(getAllInfo) withObject:nil afterDelay:5];
            [self performSelector:@selector(noConnectionToCamera) withObject:nil afterDelay:9];
        }
        else
        {
            [self noInternetConnection];
        }
    }
    else
    {
        [[CameraManager cameraManager] startTimerRecording];
        [self performSelector:@selector(showAlertLabel) withObject:nil afterDelay:0.8];
    }
}
-(void) startConnectedToCamera
{
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [self.alertLabel setAlpha:0];
    [self.alertLabel setHidden:NO];
    [self.alertLabel setText:@"Connecting, please wait"];
    [UIView animateWithDuration:0.4 animations:^{
        [self.alertLabel setAlpha:0.7];
    }];
}
-(void) connectCamera:(NSString *)text interval:(int)interval
{
    if (![[CameraManager cameraManager] checkToken]) {
        dispatch_queue_t myBackgroundQ = dispatch_queue_create("com.romanHouse.backgroundDelay", NULL);
        // Could also get a global queue; in this case, don't release it below.
        //dispatch_time_t delay = dispatch_time(DISPATCH_TIME_NOW, interval * NSEC_PER_SEC);
        dispatch_time_t delay = dispatch_time(DISPATCH_TIME_NOW, interval * NSEC_PER_SEC);
        dispatch_after(delay, myBackgroundQ, ^(void){
            [[CameraManager cameraManager] getToken];
            if (![[CameraManager cameraManager] checkToken]) {
                dispatch_async(dispatch_get_main_queue(), ^(){
                    [self.alertLabel setText:text];
                });
            }
        });
    }
}
-(void) getAllInfo
{
    if ([[CameraManager cameraManager] checkToken]) {
        [self.alertLabel setText:@"Get all settings"];
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
            [[CameraManager cameraManager] getSettingsFromCamera];
            [[CameraManager cameraManager] getCameraFW];
            dispatch_async(dispatch_get_main_queue(), ^(){
                [[CameraManager cameraManager] startTimerRecording];
                [self showAlertLabel];
                if ([[UIApplication sharedApplication] isIgnoringInteractionEvents]) {
                    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
                }
            });
        });
    }
}
-(void) noConnectionToCamera
{
    if (![[CameraManager cameraManager] checkToken]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Token Error" message:@"Connection fail. Please check on WiFi settings and try to connect again." preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            self.emergency = YES;
            if (&UIApplicationOpenSettingsURLString != NULL) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=WIFI"]];
            }
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
    if ([[UIApplication sharedApplication] isIgnoringInteractionEvents]) {
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    }
}
-(void) noInternetConnection
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Connection Error" message:@"No connect. Please check if JooVuuX is connected in Wifi Settings." preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        self.emergency = YES;
        if (&UIApplicationOpenSettingsURLString != NULL) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=WIFI"]];
        }
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
    
    if ([[UIApplication sharedApplication] isIgnoringInteractionEvents]) {
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    }
}

-(void) hideAlertLabel
{
    [UIView animateWithDuration:0.4 animations:^{
        [self.alertLabel setAlpha:0];
    } completion:^(BOOL finished) {
        [self.alertLabel setHidden:YES];
        [self.alertLabel setText:@""];
    }];
}



-(void) showAlertLabel
{
    if ([self.appDelegate isConnected])
    {
        [self.alertLabel setAlpha:0];
        [self.alertLabel setHidden:NO];
        [self.alertLabel setText:@"Camera connected"];
        [UIView animateWithDuration:0.4 animations:^{
            [self.alertLabel setAlpha:0.7];
        } completion:^(BOOL finished) {
            self.emergency = YES;
            [NSTimer scheduledTimerWithTimeInterval:0.8 target:self selector:@selector(hideAlertLabel) userInfo:nil repeats:NO];
        }];
    }
    else
    {
        [self.alertLabel setHidden:NO];
        [self.alertLabel setText:@"Camera disconnected"];
        [self.alertLabel setAlpha:0];
        [UIView animateWithDuration:0.4 animations:^{
            [self.alertLabel setAlpha:0.7];
        } completion:^(BOOL finished) {
            [NSTimer scheduledTimerWithTimeInterval:0.8 target:self selector:@selector(hideAlertLabel) userInfo:nil repeats:NO];
        }];
    }
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

-(void) imageFlashStartRecording{
    CABasicAnimation *imageAnimation = [CABasicAnimation animationWithKeyPath:@"contents"];
    CABasicAnimation *theAnimation=[CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    if(self.emergency){
       // dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
            [[CameraManager cameraManager] startRecording];
       // });
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

#pragma mark - Actions

- (IBAction)mainSettingsAction:(UIButton *)sender {
    
     self.mainSettingsView.backgroundColor = [UIColor whiteColor];
    MainSettingsVC * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"MainSettingsVC"];
    
    if (self.interfaceOrientation == UIInterfaceOrientationPortrait)
    {
        self.orientation = @"Portrait";
    }
    
    if (self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft || self.interfaceOrientation == UIInterfaceOrientationLandscapeRight)
    {
        self.orientation = @"Landscape";
    }
    vc.orientation = self.orientation;
    [self.navigationController pushViewController:vc animated:YES];
}


- (IBAction)modeSettinsAction:(UIButton *)sender {
    self.modeSettingsView.backgroundColor = [UIColor whiteColor];
    ModeSettingsVC * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ModeSettingsVC"];
    
    if (self.interfaceOrientation == UIInterfaceOrientationPortrait)
    {
        self.orientation = @"Portrait";
    }
    
    if (self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft || self.interfaceOrientation == UIInterfaceOrientationLandscapeRight)
    {
        self.orientation = @"Landscape";
    }
    vc.orientation = self.orientation;
    [self.navigationController pushViewController:vc animated:YES];
}


- (IBAction)galaryButton:(UIButton *)sender {
    self.galeryView.backgroundColor = [UIColor whiteColor];
    GalleryCVC* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"GalleryCVC"];
    [self.navigationController pushViewController:vc animated:YES];
    
}


- (IBAction)streamingButton:(UIButton *)sender {
      self.streamingView.backgroundColor = [UIColor whiteColor];
    StreamVC * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"StreamVC"];

    if (self.interfaceOrientation == UIInterfaceOrientationPortrait)
    {
        self.orientation = @"Portrait";
    }
    
    if (self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft || self.interfaceOrientation == UIInterfaceOrientationLandscapeRight)
    {
        self.orientation = @"Landscape";
    }
    vc.orientation = self.orientation;
    [self.navigationController pushViewController:vc animated:YES];

}


- (IBAction)photoButton:(UIButton *)sender {
    if ([self.appDelegate isConnected]) {
         [[CameraManager cameraManager] takePhoto];
    }
     self.photoView.backgroundColor = [UIColor whiteColor];
    
}


- (IBAction)videoButton:(UIButton *)sender {
     if ([self.appDelegate isConnected]) {
         [self imageFlashStartRecording];
     }
    self.videoView.backgroundColor = [UIColor whiteColor];
    
}


- (IBAction)connectiongButton:(UIButton *)sender {
    self.connectingView.backgroundColor = [UIColor whiteColor];
    ConnectionVC* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ConnectionVC"];
    [self.navigationController pushViewController:vc animated:YES];
}


- (IBAction)cameraButton:(UIButton *)sender {
    
    self.cameraView.backgroundColor = [UIColor whiteColor];
    CameraFmVC * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"CameraFmVC"];
    [self.navigationController pushViewController:vc animated:YES];

}
@end
