//
//  StreamingViewController.h
//  JooVuuX
//
//  Created by Andrey on 22.05.15.
//  Copyright (c) 2015 lsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XDPopupListView.h"
#import <Foundation/Foundation.h>
#import "ModeSettings.h"
#import "KxMovieViewController.h"
#import <GBPing/GBPing.h>
static NSString * MODE = @"mode";

@interface StreamingVC : UIViewController <UITextFieldDelegate, XDPopupListViewDataSource, XDPopupListViewDelegate, GBPingDelegate>
{
    int pingCount;
    int pingError;
    //UIWindow *window;
    XDPopupListView *mDropDownListView;
}


-(void) startStreaming;

@property (strong, nonatomic) GBPing *ping;

//Streaming
@property (strong, nonatomic) UIActivityIndicatorView * indicator;
@property (nonatomic, strong) IBOutlet UIView *window;
@property (nonatomic, strong) IBOutlet UIImageView * streamingImage;

@property (strong, nonatomic) ModeSettings * modeSettings;

@property (strong, nonatomic) NSArray * contentDataArray;

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *backgroundAllView;

@property (strong, nonatomic) NSMutableDictionary * popupDialogs;

@property (strong, nonatomic) NSUserDefaults * userDefaults;

@property (weak, nonatomic) IBOutlet UIButton *modeDropDownTitle;
@property (weak, nonatomic) IBOutlet UIButton *modeDropDownButton;
- (IBAction)modePopup:(UIBarButtonItem *)sender;


//TakePhoto
- (IBAction)takePhoto:(UIButton *)sender;


//AnimationRecord
- (IBAction)recordButton:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *recordButton;

@property (strong, nonatomic) UIImage * normalState;

@property (strong, nonatomic) UIImage * clearState;
@property (strong, nonatomic) UIImage * emergencyState;

@property BOOL emergency;
//

@property (weak, nonatomic) IBOutlet UIView *informationView;


@property (weak, nonatomic) IBOutlet UILabel *videoResolution;
@property (weak, nonatomic) IBOutlet UILabel *audio;
@property (weak, nonatomic) IBOutlet UILabel *rotate180Degrees;
@property (weak, nonatomic) IBOutlet UILabel *videoBitRates;
@property (weak, nonatomic) IBOutlet UILabel *videoClipLenght;
@property (weak, nonatomic) IBOutlet UILabel *wdr;
@property (weak, nonatomic) IBOutlet UILabel *fieldOfView;

@end
