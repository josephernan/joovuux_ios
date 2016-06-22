//
//  VideoUploadViewController.m
//  YouTube Direct Lite for iOS
//
//  Created by Ibrahim Ulukaya on 11/13/13.
//  Copyright (c) 2013 Google. All rights reserved.
//

#import "VideoUploadViewController.h"
#import "Utils.h"
#import "GTMOAuth2ViewControllerTouch.h"

UITextField *titleField;
UITextField *descField;
UIButton *btn;

@interface VideoUploadViewController ()

@end

@implementation VideoUploadViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  _uploadVideo = [[YouTubeUploadVideo alloc] init];
  _uploadVideo.delegate = self;
  _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 350, 520)];
  if (self) {

  }
  return self;
}




- (void)viewDidLoad {
  [super viewDidLoad];

    
    self.youtubeService = [[GTLServiceYouTube alloc] init];
    self.youtubeService.authorizer =
    [GTMOAuth2ViewControllerTouch authForGoogleFromKeychainForName:kKeychainItemName
                                                          clientID:kClientID
                                                      clientSecret:kClientSecret];
    if (![self isAuthorized]) {

        [[self navigationController] pushViewController:[self createAuthController] animated:YES];
    }

    
    [self setSettingsView];
    

  
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

- (IBAction)btnClicked:(id)sender {
  NSData *fileData = [NSData dataWithContentsOfURL:_videoUrl];
  NSString *title = titleField.text;
  NSString *description = descField.text;

  if ([title isEqualToString:@""]) {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"'Direct Lite Uploaded File ('EEEE MMMM d, YYYY h:mm a, zzz')"];
    title = [dateFormat stringFromDate:[NSDate date]];
  }
  if ([description isEqualToString:@""]) {
    description = @"Uploaded from YouTube Direct Lite iOS";
  }

  [self.uploadVideo uploadYouTubeVideoWithService:_youtubeService
                                         fileData:fileData
                                            title:title
                                      description:description];
}



#pragma mark - setSettingsView

-(void) setSettingsView
{
    self.player = [[MPMoviePlayerController alloc] initWithContentURL:_videoUrl];
    self.player.view.frame = CGRectMake(0, 0, 350, 350);
    [self.scrollView addSubview:self.player.view];
    [self.player play];
    
    titleField = [[UITextField alloc] initWithFrame:CGRectMake(0, 360, 200, 30)];
    titleField.borderStyle = UITextBorderStyleRoundedRect;
    titleField.placeholder = @"Title";
    titleField.autocorrectionType = UITextAutocorrectionTypeYes;
    titleField.keyboardType = UIKeyboardTypeDefault;
    titleField.clearButtonMode = UITextFieldViewModeWhileEditing;
    titleField.delegate = self;
    [titleField setReturnKeyType:UIReturnKeyDone];
    
    descField = [[UITextField alloc] initWithFrame:CGRectMake(0, 400, 310, 30)];
    descField.borderStyle = UITextBorderStyleRoundedRect;
    descField.placeholder = @"Description";
    descField.autocorrectionType = UITextAutocorrectionTypeYes;
    descField.keyboardType = UIKeyboardTypeDefault;
    descField.clearButtonMode = UITextFieldViewModeWhileEditing;
    descField.delegate = self;
    [descField setReturnKeyType:UIReturnKeyDone];
    [descField resignFirstResponder];
    
    [self.scrollView addSubview:titleField];
    [self.scrollView addSubview:descField];
    
    btn=[[UIButton alloc]initWithFrame:CGRectMake(50, 20, 300, 40)];
    [btn setBackgroundColor:[UIColor orangeColor]];
    //adding action programatically
    [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:btn];
    
    self.scrollView.backgroundColor = [UIColor whiteColor];
    
    self.view = self.scrollView;
  
}



#pragma mark - Autorization

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


#pragma mark - uploadYouTubeVideo

- (void)uploadYouTubeVideo:(YouTubeUploadVideo *)uploadVideo
      didFinishWithResults:(GTLYouTubeVideo *)video {
  [Utils showAlert:@"Video Uploaded" message:video.identifier];
}

// Call this method somewhere in your view controller setup code.
- (void)registerForKeyboardNotifications {
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(keyboardWasShown:)
                                               name:UIKeyboardDidShowNotification
                                             object:nil];

  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(keyboardWillBeHidden:)
                                               name:UIKeyboardWillHideNotification
                                             object:nil];

}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification {
      UIEdgeInsets contentInsets = UIEdgeInsetsZero;
      _scrollView.contentInset = contentInsets;
      _scrollView.scrollIndicatorInsets = contentInsets;
  [self.scrollView setContentOffset:CGPointMake(0.0, 0.0) animated:YES];
}


- (void)textFieldDidBeginEditing:(UITextField *)textField {
  self.activeField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
  self.activeField = nil;
}

- (void)keyboardWasShown:(NSNotification *)aNotification {
  NSDictionary *info = [aNotification userInfo];
  CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
  CGRect bkgndRect = self.activeField.superview.frame;
  bkgndRect.size.height += kbSize.height;
  [self.activeField.superview setFrame:bkgndRect];
  [self.scrollView
      setContentOffset:CGPointMake(0.0, self.activeField.frame.origin.y - kbSize.height)
              animated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  [textField resignFirstResponder];
  return YES;
}

@end
