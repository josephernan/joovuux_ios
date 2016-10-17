//
//  VideoDescription.h
//  JooVuuX
//
//  Created by Andrey on 09.06.15.
//  Copyright (c) 2015 lsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellObject.h"

#import "FBSDKShareKit.h"
#import "FBSDKShareVideoContent.h"

#import "VideoData.h"
#import "YouTubeUploadVideo.h"

@interface VideoDescription : UIViewController < UITextFieldDelegate>


@property BOOL facebookPresed;
@property BOOL twitterPresed;
@property (strong, nonatomic) NSString * url;
@property (strong, nonatomic) NSString * urlVideoInYouTube;
@property (strong, nonatomic) UIImage * image;


- (IBAction)shareVideo:(UIBarButtonItem *)sender;

//@property(nonatomic, retain) GTLServiceYouTube *youtubeService;
@property(nonatomic, strong) YouTubeUploadVideo *uploadVideo;

@property (strong, nonatomic) NSString * titleVideo;
@property (strong, nonatomic) NSString * descriptionVideo;

@end
