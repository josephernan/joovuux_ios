//
//  ImageDescriptionViewController.m
//  JooVuuX
//
//  Created by Andrey on 08.06.15.
//  Copyright (c) 2015 lsoft. All rights reserved.
//

#import "PhotoDescription.h"
#import "FBSDKShareKit.h"
//#import <TwitterKit/TwitterKit.h>
#import "AHKActionSheet.h"

@interface PhotoDescription ()



@end

@implementation PhotoDescription

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadShow];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) loadShow
{
    self.image = [UIImage imageWithData:[[NSFileManager defaultManager] contentsAtPath:self.url]];
    self.fullImage.image = self.image;
}



//- (IBAction)sharePhoto:(UIBarButtonItem *)sender {
//    AHKActionSheet *actionSheet = [[AHKActionSheet alloc] initWithTitle:NSLocalizedString(@"", nil)];
//    
//    [actionSheet addButtonWithTitle:NSLocalizedString(@"Facebook", nil)
//                              image:[UIImage imageNamed:@"facebook_menu"]
//                               type:AHKActionSheetButtonTypeDefault
//                            handler:^(AHKActionSheet *as) {
//                                [self shareFacebook];
//                            }];
//    
//    [actionSheet addButtonWithTitle:NSLocalizedString(@"Twitter", nil)
//                              image:[UIImage imageNamed:@"twitter_menu"]
//                               type:AHKActionSheetButtonTypeDefault
//                            handler:^(AHKActionSheet *as) {
//                                [self shareTwitter];
//                            }];
//    
//    [actionSheet show];
//
//    
//}



-(void) shareFacebook
{
    UIImage *image = self.image;
    
    FBSDKSharePhoto *photo = [[FBSDKSharePhoto alloc] init];
    photo.image = image;
    photo.userGenerated = YES;
    FBSDKSharePhotoContent *content = [[FBSDKSharePhotoContent alloc] init];
    content.photos = @[photo];
    
    
    [FBSDKShareDialog showFromViewController:self
                                 withContent:content
                                    delegate:nil];

}

/*
-(void) shareTwitter
{
    TWTRComposer *composer = [[TWTRComposer alloc] init];
    
    [composer setText:@""];
    [composer setImage:self.image];
    
    [composer showWithCompletion:^(TWTRComposerResult result) {
        if (result == TWTRComposerResultCancelled) {
            //NSLog(@"Tweet composition cancelled");
        }
      else {
    
           UIAlertView *alert;
            alert = [[UIAlertView alloc] initWithTitle:@"Tweet Send"
                                               message:nil
                                              delegate:nil
                                     cancelButtonTitle:@"OK"
                                     otherButtonTitles:nil];
            [alert show];

          
            //NSLog(@"Sending Tweet!");
          
        }
    }];
}

*/

@end
