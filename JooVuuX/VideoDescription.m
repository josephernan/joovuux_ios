////
////  VideoDescription.m
////  JooVuuX
////
////  Created by Andrey on 09.06.15.
////  Copyright (c) 2015 lsoft. All rights reserved.
////
//
#import "VideoDescription.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import "AHKActionSheet.h"
#import "Utils.h"
#import "GTMOAuth2ViewControllerTouch.h"

#import <FBSDKShareKit.h>
//#import <TwitterKit/TwitterKit.h>

#import "MKInputBoxView.h"

@interface VideoDescription ()

@property (nonatomic, retain) AVPlayerViewController *avPlayerViewcontroller;

@end

@implementation VideoDescription


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _uploadVideo = [[YouTubeUploadVideo alloc] init];
    _uploadVideo.delegate = self;
    
    self.facebookPresed = NO;
    self.twitterPresed = NO;
    
    [self initPlayer];
   
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void) resizePlayerToViewSize
{
    CGRect frame = self.view.frame;
    
    NSLog(@"frame size %d, %d", (int)frame.size.width, (int)frame.size.height);
    
    self.avPlayerViewcontroller.view.frame = frame;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}




- (IBAction)shareVideo:(UIBarButtonItem *)sender
{
   
        AHKActionSheet *actionSheet = [[AHKActionSheet alloc] initWithTitle:NSLocalizedString(@"", nil)];
        
        [actionSheet addButtonWithTitle:NSLocalizedString(@"Facebook", nil)
                                  image:[UIImage imageNamed:@"facebook_menu"]
                                   type:AHKActionSheetButtonTypeDefault
                                handler:^(AHKActionSheet *as) {
                                    [self shareFacebook];
                                }];
        
        [actionSheet addButtonWithTitle:NSLocalizedString(@"Twitter", nil)
                                  image:[UIImage imageNamed:@"twitter_menu"]
                                   type:AHKActionSheetButtonTypeDefault
                                handler:^(AHKActionSheet *as) {
                                    [self shareTwitter];
                                }];
        [actionSheet addButtonWithTitle:NSLocalizedString(@"YouTube", nil)
                                  image:[UIImage imageNamed:@"youtube_menu"]
                                   type:AHKActionSheetButtonTypeDefault
                                handler:^(AHKActionSheet *as) {
                                    [self showAlertYouTube];
                                }];
    
    
        [actionSheet show];
    
}


-(void) shareFacebook
{
    self.facebookPresed = YES;
    [self showAlertYouTube];
    
}

-(void) shareTwitter
{
    
    self.twitterPresed = YES;
    [self showAlertYouTube];
    
}




-(void)shareYouTube
{
    
    NSString *resourceName = self.url;
    NSURL *fileURL = [NSURL fileURLWithPath:resourceName];

    NSData *fileData = [NSData dataWithContentsOfURL:fileURL];

    
    if (self.titleVideo == nil || [self.titleVideo isEqualToString:@""]) {
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"'Direct Lite Uploaded File ('EEEE MMMM d, YYYY h:mm a, zzz')"];
        self.titleVideo = [dateFormat stringFromDate:[NSDate date]];
    }
    if (self.descriptionVideo == nil || [self.descriptionVideo isEqualToString:@""]) {
        self.descriptionVideo = @"Uploaded from YouTube Direct Lite iOS";
    }
    [self isAutorizated];
    
    [self.uploadVideo uploadYouTubeVideoWithService:_youtubeService
                                           fileData:fileData
                                              title:self.titleVideo
                                        description:self.descriptionVideo];
}




#pragma mark - showAlertYouTube

/*
-(void) showAlertYouTube
{


    NSString *alertTitle = NSLocalizedString(@"Share YouTube", @"Share YouTube");


    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:alertTitle
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleAlert];

    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField)
     {
         textField.placeholder = NSLocalizedString(@"Title", @"Title");
         UIView *container = textField.superview;
         ///container.backgroundColor = [UIColor clearColor];

         [container setFrame:CGRectMake(20, 20, 20, 20)];
         [((UIVisualEffectView *)((UIView *)container.superview).subviews[0]) removeFromSuperview];



     }];

    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField)
     {
         textField.placeholder = NSLocalizedString(@"Discription", @"Discription");
         UIView *container = textField.superview;
         ///container.backgroundColor = [UIColor clearColor];
         [container setFrame:CGRectMake(20, 20, 20, 20)];
         [((UIVisualEffectView *)((UIView *)container.superview).subviews[0]) removeFromSuperview];


     }];



    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel action")
                                                           style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction *action)
                                   {
                                       NSLog(@"Cancel action");
                                   }];

    UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Share", @"OK action")
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction *action)
                              {



                                   UITextField *title = alertController.textFields.firstObject;
                                   UITextField *description = alertController.textFields.lastObject;

                                   self.titleVideo = title.text;
                                   self.descriptionVideo = description.text;

                                   [self shareYouTube];


                               }];

    [alertController addAction:cancelAction];
    [alertController addAction:okAction];

    [self presentViewController:alertController animated:YES completion:nil];



}
*/

-(void) showAlertYouTube
{
    MKInputBoxView *inputBoxView = [MKInputBoxView boxOfType:LoginAndPasswordInput];
    [inputBoxView setTitle:@"Share YouTube"];
    [inputBoxView setMessage:nil];
    [inputBoxView setBlurEffectStyle:UIBlurEffectStyleExtraLight];
    
    
    [inputBoxView setCancelButtonText:@"Cancel"];
    inputBoxView.customise = ^(UITextField *textField) {
        textField.placeholder = @"Title";
        
        if ([textField isMultipleTouchEnabled]) {
            textField.placeholder = @"Description";
            CGRect frameRect = textField.frame;
            frameRect.size.height = 65;
            textField.frame = frameRect;
            

            
            
        }
        textField.textColor = [UIColor whiteColor];
        textField.layer.cornerRadius = 2.0f;
        return textField;
    };

    inputBoxView.onSubmit = ^(NSString *value1, NSString *value2) {
        
        self.titleVideo = value1;
        self.descriptionVideo = value2;

        [self shareYouTube];
        
        //NSLog(@"user: %@", value1);
        //NSLog(@"pass: %@", value2);
    };
    
    inputBoxView.onCancel = ^{
        //NSLog(@"Cancel!");
    };
    
    [inputBoxView show];
}


#pragma mark - AutorizationYOuTube

-(void) isAutorizated
{
    self.youtubeService = [[GTLServiceYouTube alloc] init];
    self.youtubeService.authorizer =
    [GTMOAuth2ViewControllerTouch authForGoogleFromKeychainForName:kKeychainItemName
                                                          clientID:kClientID
                                                      clientSecret:kClientSecret];
    if (![self isAuthorized]) {
        [[self navigationController] pushViewController:[self createAuthController] animated:YES];
    }

}

- (IBAction)startOAuthFlow:(id)sender {
    GTMOAuth2ViewControllerTouch *viewController;
    
    viewController = [[GTMOAuth2ViewControllerTouch alloc]
                      initWithScope:kGTLAuthScopeYouTube
                      clientID:kClientID
                      clientSecret:kClientSecret
                      keychainItemName:kKeychainItemName
                      delegate:self
                      finishedSelector:@selector(viewController:finishedWithAuth:error:)];
    
    [[self navigationController] pushViewController:viewController animated:YES];
}

- (BOOL)isAuthorized {
    return [((GTMOAuth2Authentication *)self.youtubeService.authorizer) canAuthorize];
}

- (GTMOAuth2ViewControllerTouch *)createAuthController
{
    GTMOAuth2ViewControllerTouch *authController;
    
    authController = [[GTMOAuth2ViewControllerTouch alloc] initWithScope:kGTLAuthScopeYouTube
                                                                clientID:kClientID
                                                            clientSecret:kClientSecret
                                                        keychainItemName:kKeychainItemName
                                                                delegate:self
                                                        finishedSelector:@selector(viewController:finishedWithAuth:error:)];
    return authController;
}

- (void)viewController:(GTMOAuth2ViewControllerTouch *)viewController
      finishedWithAuth:(GTMOAuth2Authentication *)authResult
                 error:(NSError *)error {
    if (error != nil) {
        [Utils showAlert:@"Authentication Error" message:error.localizedDescription];
        self.youtubeService.authorizer = nil;
    } else {
        self.youtubeService.authorizer = authResult;
    }
}

#pragma mark - initPlayer

-(void) initPlayer
{
    UIView *view = self.view;
    
    NSString *resourceName = self.url;
    
    NSURL *fileURL = [NSURL fileURLWithPath:resourceName];
    
    AVPlayerViewController *playerViewController = [[AVPlayerViewController alloc] init];
    
    playerViewController.player = [AVPlayer playerWithURL:fileURL];
    
    self.avPlayerViewcontroller = playerViewController;
    
    [self resizePlayerToViewSize];
    
    [view addSubview:playerViewController.view];
    
    view.autoresizesSubviews = TRUE;
}


//#pragma mark - uploadYouTubeVideo
//
//- (void)uploadYouTubeVideo:(YouTubeUploadVideo *)uploadVideo
//      didFinishWithResults:(GTLYouTubeVideo *)video {
//    
//    self.urlVideoInYouTube = [@"http://www.youtube.com/watch?v=" stringByAppendingString:video.identifier];
//   // NSLog(@"Login value: %@",self.titleVideo);
//   // NSLog(@"Password value: %@",self.descriptionVideo);
//    if (self.facebookPresed)
//    {
//        FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];
//        content.contentTitle = self.titleVideo;
//        content.contentDescription = self.descriptionVideo;
//        content.contentURL = [NSURL URLWithString:self.urlVideoInYouTube];
//        [FBSDKShareDialog showFromViewController:self
//                                     withContent:content
//                                        delegate:nil];
//        
//        self.facebookPresed = NO;
//        
//        [Utils showAlert:@"Facebook Posted" message:nil];
//    }
//        
//    else if (self.twitterPresed)
//    {
//        TWTRComposer *composer = [[TWTRComposer alloc] init];
//        
//        [composer setText:[NSString stringWithFormat:@"%@\n%@\n%@", self.titleVideo, self.descriptionVideo, self.urlVideoInYouTube]];
//        //[composer setImage:[UIImage imageNamed:@"fabric"]];
//        
//        [composer showWithCompletion:^(TWTRComposerResult result) {
//            if (result == TWTRComposerResultCancelled) {
//               // NSLog(@"Tweet composition cancelled");
//            }
//            else {
//               // NSLog(@"Sending Tweet!");
//            }
//        }];
//        
//        
//        self.twitterPresed = NO;
//        
//        [Utils showAlert:@"Twitter Posted" message:nil];
//        
//    } else
//    {
//        
//        [Utils showAlert:@"Video Uploaded" message:self.urlVideoInYouTube];
//        
//    }
//    
//}


@end
