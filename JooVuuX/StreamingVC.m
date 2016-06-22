//
//  StreamingViewController.m
//  JooVuuX
//
//  Created by Andrey on 22.05.15.
//  Copyright (c) 2015 lsoft. All rights reserved.
//

#import "StreamingVC.h"
#import "NSString+Utils.h"
#import <CoreGraphics/CoreGraphics.h>
#import "CameraManager.h"


static NSString * VIDEO_RESOLUTION              = @"videoResolutions";
static NSString * AUDIO                         = @"audio";
static NSString * ROTATE_180_DEGREES            = @"rotate180Degrees";
static NSString * VIDEO_BIT_RATES               = @"videoBitRates";
static NSString * VIDEO_CLIP_LENGHT             = @"videoClipLenght";
static NSString * WDR                           = @"wdr";
static NSString * FIELD_OF_VIEW                 = @"fieldOfView";

@interface StreamingVC ()
{
    NSString * videoResolutionString;
    NSString * audioString;
    NSString * rotate180String;
    NSString * videoBitRatesString;
    NSString * videoClipLenghtString;
    NSString * wdrString;
    NSString * fieldOfViewString;
}
@end

@implementation StreamingVC

//@synthesize streamingImage,video;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self backgroundAllView];
    [self initDropDownList];
    self.modeSettings =[[ModeSettings alloc] init];
    self.userDefaults = [NSUserDefaults standardUserDefaults];
    self.emergency = YES;
    
    
    [self setSettingsView];
    [self createArray];
    self.normalState = [UIImage imageNamed:@"record_ico"];
    self.clearState = [UIImage imageNamed:@"clear_ico"];
    self.emergencyState = [UIImage imageNamed:@"recording_ico"];
    
    [NSTimer scheduledTimerWithTimeInterval:0
                                     target:self
                                   selector:@selector(startSelector)
                                   userInfo:nil
                                    repeats:NO];
    [self loadSettingsMode:0];
    
}

-(void) viewDidAppear:(BOOL)animated
{

}


-(void)ping:(GBPing *)pinger didReceiveReplyWithSummary:(GBPingSummary *)summary {
    pingCount++;
    
    if (pingCount == 1) {
            [self.ping stop];
            self.ping = nil;
//            [[CameraManager cameraManager] setModeInStreamingVideoResolution:videoResolutionString audio:audioString rotate180:rotate180String videoBitRates:videoBitRatesString videoClipLenght:videoClipLenghtString WDR:wdrString fieldOfView:fieldOfViewString];
            [CameraManager cameraManager].strem = self;
            pingCount = 0;
            pingError = 0;
    }
}
    
    //NSLog(@"REPLY>  %@", summary);

-(void)ping:(GBPing *)pinger didReceiveUnexpectedReplyWithSummary:(GBPingSummary *)summary {
    
    pingError++;
    if (pingError >= 3) {
        [self alertNoInternetConnection];
        [self.ping stop];
        self.ping = nil;
        pingError = 0;
        pingCount = 0;
        [self.indicator stopAnimating];
    }
    
    NSLog(@"BREPLY> %@", summary);
}

-(void)ping:(GBPing *)pinger didSendPingWithSummary:(GBPingSummary *)summary {
    
    pingError++;
    if (pingError >= 4) {
        [self alertNoInternetConnection];
        [self.ping stop];
        self.ping = nil;
        pingCount = 0;
        pingError = 0;
        [self.indicator stopAnimating];
    }
    
    NSLog(@"SENT>   %@", summary);
}

-(void)ping:(GBPing *)pinger didTimeoutWithSummary:(GBPingSummary *)summary {
    pingError++;
    if (pingError >= 3) {
        [self alertNoInternetConnection];
        [self.ping stop];
        self.ping = nil;
        pingError = 0;
        pingCount = 0;
        [self.indicator stopAnimating];
    }
    ;
    NSLog(@"TIMOUT> %@", summary);
}

-(void)ping:(GBPing *)pinger didFailWithError:(NSError *)error {
    pingError++;
    if (pingError >= 3) {
        [self alertNoInternetConnection];
        [self.ping stop];
        self.ping = nil;
        pingError = 0;
        pingCount = 0;
        [self.indicator stopAnimating];
    }
    
    NSLog(@"FAIL>   %@", error);
}

-(void)ping:(GBPing *)pinger didFailToSendPingWithSummary:(GBPingSummary *)summary error:(NSError *)error {
    
    [self.ping stop];
    self.ping = nil;
    [self alertNoInternetConnection];
    pingCount = 0;
    pingError = 0;
    [self.indicator stopAnimating];
    NSLog(@"FSENT>  %@, %@", summary, error);
}


-(void) alertNoInternetConnection
{
    UIAlertView *subAlert = [[UIAlertView alloc] initWithTitle:@""
                                                       message:@"Connection fail. Check on WiFi settings and try to connect again."
                                                      delegate:self
                                             cancelButtonTitle:@"Close"
                                             otherButtonTitles:nil];
                                            //otherButtonTitles:@"Open settings WiFi", nil];
    [subAlert show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) startSelector
{
    self.indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.indicator.center = self.streamingImage.center;
    [self.window addSubview:self.indicator];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self.indicator startAnimating];

}

//-(void) startJson
//{
//    [[CameraManager cameraManager] startStreaming];
//    [CameraManager cameraManager].strem = self;
//}

-(void) startStreaming
{
    UIViewController *vc;
    vc = [KxMovieViewController movieViewControllerWithContentPath:@"rtsp://192.168.42.1/live" parameters:nil];
    [self addChildViewController:vc];
    [vc.view setFrame:CGRectMake(0, 0, self.window.frame.size.width, self.window.frame.size.height)];
    [self.window addSubview:vc.view];
}


-(void) imageFlash{
    
    CABasicAnimation *imageAnimation = [CABasicAnimation animationWithKeyPath:@"contents"];
    if(self.emergency ){
        [[CameraManager cameraManager] startRecording];
        imageAnimation.duration = 1.2f;
        imageAnimation.repeatCount = INFINITY;
        self.emergency = NO;
    }
    else{
        [[CameraManager cameraManager] stopRecording];
        imageAnimation.repeatCount = 0;
        self.emergency = YES;
    }
    imageAnimation.fromValue = (id)self.emergencyState.CGImage;
    imageAnimation.toValue = (id)self.clearState.CGImage;
    [self.recordButton.imageView.layer addAnimation:imageAnimation forKey:@"animateContents"];
    [self.recordButton setImage:self.normalState forState:UIControlStateNormal];
}



- (IBAction)recordButton:(UIButton *)sender
{
    [self imageFlash];
}

- (IBAction)takePhoto:(UIButton *)sender
{
    [[CameraManager cameraManager] takePhoto];
}

#pragma mark - setSettingsView

-(void) setSettingsView
{
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]]];
    
    for (UIView * view in self.backgroundAllView) {
        
        [view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"beckground-box"]]];
    }
    
    [self.informationView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background-mode"]]];
    
}

#pragma mark - initDropDownTableButtonsActions


- (IBAction)modePopup:(UIButton *)sender {
    [mDropDownListView show];
}

-(void) createArray
{
    self.contentDataArray = [NSArray arrayWithObjects:@"MODE 1", @"MODE 2", @"MODE 3", nil];
}

- (void)initDropDownList
{
    mDropDownListView = [[XDPopupListView alloc] initWithBoundView:self.modeDropDownButton dataSource:self delegate:self popupType:XDPopupListViewDropDown];
}

#pragma mark - XDPopupListViewDataSource & XDPopupListViewDelegate


- (NSInteger)numberOfRowsInSection:(NSInteger)section
{
    return self.contentDataArray.count;
}
- (CGFloat)itemCellHeight:(NSIndexPath *)indexPath
{
    return 44.0f;
}
- (void)loadSettingsMode:(NSInteger)indexPathRow
{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    // videoresolution
    NSString * videoResolutionKey = [VIDEO_RESOLUTION stringByAppendingString:self.contentDataArray[indexPathRow]];
    self.videoResolution.text = [self.modeSettings.videoResolutions objectAtIndex:[userDefaults integerForKey:videoResolutionKey]];
    videoResolutionString = [self.modeSettings.videoResolutions objectAtIndex:[userDefaults integerForKey:videoResolutionKey]];
    //audio
    NSString * audioKey = [AUDIO stringByAppendingString:self.contentDataArray[indexPathRow]];
    self.audio.text = [userDefaults boolForKey: audioKey] ? @"YES" : @"NO";
    audioString = [userDefaults boolForKey: audioKey] ? @"on" : @"off";
    //rotate180
    NSString * rotate180Key = [ROTATE_180_DEGREES stringByAppendingString:self.contentDataArray[indexPathRow]];
    self.rotate180Degrees.text = [userDefaults boolForKey: rotate180Key] ? @"YES" : @"NO";
    rotate180String = [userDefaults boolForKey: rotate180Key] ? @"on" : @"off";
    // videobitrates
    NSString * videoBitRatesKey = [VIDEO_BIT_RATES stringByAppendingString:self.contentDataArray[indexPathRow]];
    self.videoBitRates.text = [self.modeSettings.videoBitRates objectAtIndex:[userDefaults integerForKey:videoBitRatesKey]];
    videoBitRatesString = [self.modeSettings.videoBitRates objectAtIndex:[userDefaults integerForKey:videoBitRatesKey]];
    // videoClipLenght
    NSString * videoClipLenghtKey = [VIDEO_CLIP_LENGHT stringByAppendingString:self.contentDataArray[indexPathRow]];
    self.videoClipLenght.text = [self.modeSettings.videoClipLenght objectAtIndex:[userDefaults integerForKey:videoClipLenghtKey]];
    videoClipLenghtString = [self.modeSettings.videoClipLenght objectAtIndex:[userDefaults integerForKey:videoClipLenghtKey]];
    // WDR
    NSString * wdrKey = [WDR stringByAppendingString:self.contentDataArray[indexPathRow]];
    self.wdr.text = [self.modeSettings.wdrData objectAtIndex:[userDefaults integerForKey:wdrKey]];
    wdrString = [self.modeSettings.wdrData objectAtIndex:[userDefaults integerForKey:wdrKey]];
    // fieldOfView
    NSString * fieldOfViewKey = [FIELD_OF_VIEW stringByAppendingString:self.contentDataArray[indexPathRow]];
    self.fieldOfView.text = [self.modeSettings.fieldOfView objectAtIndex:[userDefaults integerForKey:fieldOfViewKey]];
    fieldOfViewString = [self.modeSettings.fieldOfView objectAtIndex:[userDefaults integerForKey:fieldOfViewKey]];
    
    self.ping = [[GBPing alloc] init];
    self.ping.host = @"192.168.42.1";
    self.ping.delegate = self;
    
    [self.ping setupWithBlock:^(BOOL success, NSError *error) {
        if (success) {
            [self.ping startPinging];
        }
        else {
            NSLog(@"failed to start");
        }
    }];

}

- (void)clickedListViewAtIndexPath:(NSIndexPath *)indexPath
{
    [self loadSettingsMode:indexPath.row];
    [self.modeDropDownTitle setTitle:self.contentDataArray[indexPath.row] forState:UIControlStateNormal];
    
    NSLog(@"%ld: %@", (long)indexPath.row, self.contentDataArray[indexPath.row]);
    
}
- (UITableViewCell *)itemCell:(NSIndexPath *)indexPath
{
    if (self.contentDataArray.count == 0) {
        return nil;
    }
    static NSString *identifier = @"ddd";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    cell.textLabel.text = self.contentDataArray[indexPath.row];
    return cell;
}




@end
