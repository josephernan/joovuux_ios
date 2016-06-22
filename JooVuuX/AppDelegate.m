//
//  AppDelegate.m
//  JooVuuX
//
//  Created by Andrey on 08.07.15.
//  Copyright (c) 2015 lsoft. All rights reserved.
//

#import "AppDelegate.h"
#import "CameraManager.h"
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>
#import <GBPing/GBPing.h>
#import "ServerManager.h"
@interface AppDelegate () <GBPingDelegate>
{
    int pingError;
}
@property (strong, nonatomic) GBPing *ping;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self pingCamera];
    [NSTimer scheduledTimerWithTimeInterval:15 target:self selector:@selector(pingCamera) userInfo:nil repeats:YES];
//    [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(checkCameraRecording) userInfo:nil repeats:NO];
    [Fabric with:@[[Crashlytics class]]];
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        UIUserNotificationType userNotificationTypes = (UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:userNotificationTypes categories:nil];
        [application registerUserNotificationSettings:settings];
        [application registerForRemoteNotifications];
    } else
    {
        [application registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound)];
    }
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[CameraManager cameraManager] deleteToken];
    });
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [self performSelector:@selector(postNotificationGetToken) withObject:nil afterDelay:1];
}

-(void) postNotificationGetToken
{
     [[NSNotificationCenter defaultCenter] postNotificationName:@"getToken" object:nil];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//-(void) checkCameraRecording
//{
//    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
//        if (self.isConnected) {
//            if ([[CameraManager cameraManager] cameraRecording]) {
//                self.isRecording = YES;
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    [[NSNotificationCenter defaultCenter] postNotificationName:@"checkRecording" object:nil];
//                    [self performSelector:@selector(checkCameraRecording) withObject:nil afterDelay:5];
//                });
//            }
//            else
//            {
//                self.isRecording = NO;
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    [[NSNotificationCenter defaultCenter] postNotificationName:@"checkRecording" object:nil];
//                    [self performSelector:@selector(checkCameraRecording) withObject:nil afterDelay:5];
//                });
//                
//            }
//        }
//    });
//}

-(void) pingCamera
{
    if ([self.ping isPinging]) {
        return;
    }
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

-(void)ping:(GBPing *)pinger didReceiveReplyWithSummary:(GBPingSummary *)summary
{
    [self.ping stop];
    self.ping = nil;
    pingError = 0;
    self.isConnected = YES;
}

-(void)ping:(GBPing *)pinger didSendPingWithSummary:(GBPingSummary *)summary
{
    pingError++;
    if (pingError >= 2) {
        [self.ping stop];
        self.ping = nil;
        pingError = 0;
        self.isConnected = NO;
    }
}


-(void) application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"%@", error);
}

-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    
    NSString *udid = [[UIDevice currentDevice] identifierForVendor];
    
    NSString * uuid;
    NSUUID *oNSUUID = [[UIDevice currentDevice] identifierForVendor];
    uuid = [oNSUUID UUIDString];
    NSString * token = [deviceToken description];
    NSLog(@"token = %@",token);
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    token = [token stringByReplacingOccurrencesOfString:@"<" withString:@""];
    token = [token stringByReplacingOccurrencesOfString:@">" withString:@""];
    [[ServerManager sharedManager] registrationToken:token uuid:uuid  onSuccess:^(NSMutableArray *array) {
        NSLog(@"%@", array);
    } onFailure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"registerToken" object:nil userInfo:@{@"token":[deviceToken description]}];
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Notification" message:[[userInfo valueForKey:@"aps"] valueForKey:@"alert"] delegate:self cancelButtonTitle:@"Close"otherButtonTitles:@"Open site", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        NSString * myurl = @"https://www.joovuu-x.com/news/";
        NSURL *url = [NSURL URLWithString:myurl];
        [[UIApplication sharedApplication] openURL:url];
    }
}

@end
