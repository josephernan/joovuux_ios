//
//  Utils.h
//  YouTube Direct Lite for iOS
//
//  Created by Ibrahim Ulukaya on 11/6/13.
//  Copyright (c) 2013 Google. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


static NSString *const DEFAULT_KEYWORD = @"ytdl";
static NSString *const UPLOAD_PLAYLIST = @"Replace me with the playlist ID you want to upload into";

static NSString *const kClientID = @"537595862761-q0quv5f5v1u760p06r6mhfqpv7rudrtj.apps.googleusercontent.com";
static NSString *const kClientSecret = @"YGIwnWaDyfPH5HN79zMOCBGk";

static NSString *const kKeychainItemName = @"JooVuuX";

@interface Utils : NSObject

+ (UIAlertView*)showWaitIndicator:(NSString *)title;
+ (void)showAlert:(NSString *)title message:(NSString *)message;
+ (NSString *)humanReadableFromYouTubeTime:(NSString *)youTubeTimeFormat;

@end
