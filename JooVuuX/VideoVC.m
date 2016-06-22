//
//  VideoVC.m
//  JooVuuX
//
//  Created by Vladislav on 14.10.15.
//  Copyright (c) 2015 lsoft. All rights reserved.
//

#import "VideoVC.h"
#import "FCFileManager.h"
#import "KxMovieViewController.h"
#import "CameraManager.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>

@interface VideoVC () <UIActionSheetDelegate>

@property (strong, nonatomic) KxMovieViewController * vc;
@property (strong, nonatomic) MPMoviePlayerController * mediaPlayer;
@property (strong, nonatomic) UIActivityIndicatorView * indicator;
@property (strong, nonatomic) NSMutableDictionary * saveObject;
@property (strong, nonatomic) NSMutableDictionary * removeObject;
@property (assign, nonatomic) BOOL save;
@property (assign, nonatomic) BOOL remove;

@end

@implementation VideoVC

-(void)viewDidLoad {
    [super viewDidLoad];
    self.indicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    self.indicator.layer.cornerRadius = 05;
    self.indicator.opaque = NO;
    self.indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    [self.indicator setColor:[UIColor whiteColor]];
    [self.indicator setCenter:self.view.center];
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1];
    [self.navigationController.navigationBar setTitleTextAttributes: @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    UIBarButtonItem *btnTrash = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(actionBtn)];
    btnTrash.tintColor = [UIColor whiteColor];
    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:btnTrash, nil]];
    [self startStream];
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

-(void) startStream
{
    if (self.localVideo) {
        NSString * path = [NSString stringWithFormat:@"%@%@", [[FCFileManager pathForDocumentsDirectory] stringByAppendingString:@"/album/"] , [self.curObject valueForKey:@"fileName"]];
        //NSString * path =  [self.curObject valueForKey:@"fileName"];
        self.vc = [KxMovieViewController movieViewControllerWithContentPath:path parameters:nil];
        [self addChildViewController:self.vc];
        [self.vc.view setFrame:self.view.frame];
        [self.view addSubview:self.vc.view];
        self.vc.view.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    } else
    {
        NSString * path = [NSString stringWithFormat:@"rtsp://192.168.42.1/tmp/fuse_d/DCIM/100MEDIA/%@", [self.curObject valueForKey:@"fileName"]];
        self.vc = [KxMovieViewController movieViewControllerWithContentPath:path parameters:nil];
        self.vc.isStreaming = YES;
        [self addChildViewController:self.vc];
        [self.vc.view setFrame:self.view.frame];
        [self.view addSubview:self.vc.view];
        self.vc.view.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    [self.vc.view addSubview:self.indicator];
}

#pragma mark - Actions

- (IBAction)backButton:(UIBarButtonItem *)sender {
    if (self.localVideo && self.saveObject) {
        [self notification];
    }
    [self.vc doneDidTouch:self];
}

-(void) notification
{
    NSMutableDictionary * dict = [NSMutableDictionary new];
    if (self.remove) {
        [dict setValue:[NSNumber numberWithBool:self.remove] forKey:@"remove"];
        [dict setValue:self.removeObject forKey:@"removeObj"];
    }
    else
    {
       [dict setValue:[NSNumber numberWithBool:self.remove] forKey:@"remove"];
    }
    if (self.save) {
        [dict setValue:[NSNumber numberWithBool:self.save] forKey:@"save"];
        [dict setValue:self.saveObject forKey:@"saveObj"];
    }
    else
    {
        [dict setValue:[NSNumber numberWithBool:self.save] forKey:@"save"];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadVideoCell" object:nil userInfo:dict];
}

-(void) actionBtn {
    if ([self.vc playing]) {
        [self.vc pause];
    }
    
    UIActionSheet *actSheet;
    if (self.localVideo) {
        actSheet = [[UIActionSheet alloc] initWithTitle:@"Action"
                                               delegate:self
                                      cancelButtonTitle:@"Cancel"
                                 destructiveButtonTitle:nil
                                      otherButtonTitles:@"Delete", nil];
    }
    else
    {
        actSheet = [[UIActionSheet alloc] initWithTitle:@"Action"
                                               delegate:self
                                      cancelButtonTitle:@"Cancel"
                                 destructiveButtonTitle:nil
                                      otherButtonTitles:@"Download", @"Delete", nil];
    }
    [actSheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (self.localVideo) {
        switch (buttonIndex) {
            case 0:
            {
                [self trashBtn];
                break;
            }
            default:
                break;
        }
    }
    else
    {
        switch (buttonIndex) {
            case 0:
            {
                [self saveBtn];
                break;
            }
            case 1:
            {
                [self trashBtn];
                break;
            }
            default:
                if (![self.vc playing]) {
                    [self.vc play];
                }
                break;
        }
    }
}

-(void) saveBtn {
    [self.indicator startAnimating];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        [[CameraManager cameraManager] downloadVideoFromName:[self.curObject valueForKey:@"fileName"]];
        [self getSaveFile];
        self.localVideo = YES;
        self.save = YES;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.indicator stopAnimating];
        });
    });
}

-(void) getSaveFile
{
    self.saveObject = [NSMutableDictionary new];
    
    NSString * fileName = [self.curObject valueForKey:@"fileName"];
    NSDictionary *fileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:[[[FCFileManager pathForDocumentsDirectory] stringByAppendingString:@"/album/"] stringByAppendingString:fileName] error:nil];
    NSNumber * fileSize = [fileAttributes objectForKey:NSFileSize];
    NSDate *fileDate = [[[NSFileManager defaultManager] attributesOfItemAtPath:[[[FCFileManager pathForDocumentsDirectory] stringByAppendingString:@"/album/"] stringByAppendingString:fileName] error:nil] fileCreationDate];
    NSURL * fileURL = [NSURL fileURLWithPath:[[[FCFileManager pathForDocumentsDirectory] stringByAppendingString:@"/album/"] stringByAppendingString:fileName]];
    NSString *resourceName = [[[FCFileManager pathForDocumentsDirectory] stringByAppendingString:@"/album/"] stringByAppendingString:fileName];
    NSURL *URL = [NSURL fileURLWithPath:resourceName];
    AVURLAsset *avUrl = [AVURLAsset assetWithURL:URL];
    CMTime time = [avUrl duration];
    int fileTime = ceil(time.value/time.timescale);

    
    if (![fileSize isEqualToNumber:[NSNumber numberWithLong:0]]) {
        UIImage * videoImage = [self vidImage:fileURL];
        [self.saveObject setValue:videoImage forKey:@"videoImage"];
    }
    [self.saveObject setValue:fileName forKey:@"fileName"];
    [self.saveObject setValue:fileSize forKey:@"fileSize"];
    [self.saveObject setValue:fileDate forKey:@"fileDate"];
    [self.saveObject setValue:fileURL forKey:@"fileURL"];
    [self.saveObject setValue:[NSNumber numberWithInt:fileTime] forKey:@"fileTime"];
}

-(UIImage * )vidImage: (NSURL * ) url
{
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:url options:nil];
    AVAssetImageGenerator *generateImg = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    generateImg.appliesPreferredTrackTransform = YES;
    NSError *error = NULL;
    CMTime time = CMTimeMake(1, 1);
    CGImageRef refImg = [generateImg copyCGImageAtTime:time actualTime:NULL error:&error];
    UIImage *FrameImage= [[UIImage alloc] initWithCGImage:refImg];
    
    return FrameImage;
}

-(void) trashBtn
{
    self.removeObject = [NSMutableDictionary new];
    NSString * fileName = [self.curObject valueForKey:@"fileName"];
    [self.removeObject setValue:fileName forKey:@"fileName"];
    self.remove = YES;
    NSString* pathCamera = [NSString stringWithFormat:@"tmp/fuse_d/DCIM/100MEDIA/%@", [self.curObject valueForKey:@"fileName"]];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        [[CameraManager cameraManager ] deleteFileFromCamera:pathCamera];
    });
    NSString * string = [NSString stringWithFormat:@"/album/%@", [self.curObject valueForKey:@"fileName"]];
    NSString* path = [[FCFileManager pathForDocumentsDirectory] stringByAppendingString:string];
    [FCFileManager removeItemAtPath:path];
    [self notification];
   [self.vc doneDidTouch:self];
}

@end
