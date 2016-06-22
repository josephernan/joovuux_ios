//
//  NavigationVC.m
//  JooVuuX
//
//  Created by Vladislav on 02.10.15.
//  Copyright (c) 2015 lsoft. All rights reserved.
//

#import "NavigationVC.h"
#import "CameraFmVC.h"
#import "ConnectionVC.h"
#import "MainSettingsVC.h"
#import "WhiteBalanceVC.h"
#import "GalleryCVC.h"
@implementation NavigationVC


- (NSUInteger)supportedInterfaceOrientations {
    if ([self.topViewController isMemberOfClass:[CameraFmVC class]]){
        return UIInterfaceOrientationMaskPortrait;
    } else if([self.topViewController isMemberOfClass:[ConnectionVC class]]){
        return UIInterfaceOrientationMaskPortrait;
    }else if([self.topViewController isMemberOfClass:[WhiteBalanceVC class]]){
        return UIInterfaceOrientationMaskPortrait;
    }
    else if([self.topViewController isMemberOfClass:[GalleryCVC class]]){
        return UIInterfaceOrientationMaskPortrait;
    }else{
        return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight;
    }
}


@end
