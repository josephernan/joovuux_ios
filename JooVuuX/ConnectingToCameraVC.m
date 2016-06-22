//
//  ConnectingToCameraVC.m
//  JooVuuX
//
//  Created by Andrey on 14.07.15.
//  Copyright (c) 2015 lsoft. All rights reserved.
//

#import "ConnectingToCameraVC.h"
#import "CameraManager.h"

@interface ConnectingToCameraVC ()

@end

@implementation ConnectingToCameraVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setSettingsView];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) setSettingsView
{
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]]];

    [self.backgroundView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"beckground-box"]]];
    
}

-(void)ping:(GBPing *)pinger didReceiveReplyWithSummary:(GBPingSummary *)summary {
   pingCount++;
    if ([[[CameraManager cameraManager] socket]isConnected]) {
        
        [self.ping stop];
        self.ping = nil;
        pingCount = 0;
        pingError = 0;
        [self alreadyConnected];

    } else
    {
        if (pingCount == 1) {
            [self alertConnection];
            [self.ping stop];
            self.ping = nil;
            [[CameraManager cameraManager] getToken];
            pingCount = 0;
            pingError = 0;
        }
    }
    

    //NSLog(@"REPLY>  %@", summary);
}

-(void)ping:(GBPing *)pinger didReceiveUnexpectedReplyWithSummary:(GBPingSummary *)summary {
    
    pingError++;
    if (pingError >= 3) {
        [self alertNoInternetConnection];
        [self.ping stop];
        self.ping = nil;
        pingError = 0;
        pingCount = 0;
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
    }

    NSLog(@"FAIL>   %@", error);
}

-(void)ping:(GBPing *)pinger didFailToSendPingWithSummary:(GBPingSummary *)summary error:(NSError *)error {
    
        [self alertNoInternetConnection];
        [self.ping stop];
        self.ping = nil;
        pingCount = 0;
        pingError = 0;

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

-(void) alertConnection
{
    UIAlertView *subAlert = [[UIAlertView alloc] initWithTitle:@""
                                                       message:@"The connection was successful"
                                                      delegate:self
                                             cancelButtonTitle:@"Close"
                                             otherButtonTitles:nil];
    [subAlert show];
}

-(void) alreadyConnected
{
    UIAlertView *subAlert = [[UIAlertView alloc] initWithTitle:@""
                                                       message:@"Already connected"
                                                      delegate:self
                                             cancelButtonTitle:@"Close"
                                             otherButtonTitles:nil];
    [subAlert show];
}


- (IBAction)connectButton:(UIButton *)sender {
    
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


@end
