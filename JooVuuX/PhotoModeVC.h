//
//  PhotoModeVC.h
//  JooVuuX
//
//  Created by Vladislav on 29.09.15.
//  Copyright (c) 2015 lsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StaticDataTableViewController.h"


@interface PhotoModeVC : StaticDataTableViewController


- (IBAction)dateTimestampButton:(UIButton *)sender;
- (IBAction)photoResolutionButton:(UIButton *)sender;
- (IBAction)rotatePhotosButton:(UIButton *)sender;
- (IBAction)timeLapsePhotoButton:(UIButton *)sender;
- (IBAction)timeLapseVideoButton:(UIButton *)sender;
- (IBAction)burstPhotoModeButton:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *rotatePhotos;
@property (weak, nonatomic) IBOutlet UIButton *dateTimestamp;
@property (weak, nonatomic) IBOutlet UIButton *timeLapsePhoto;
@property (weak, nonatomic) IBOutlet UIButton *timeLapseVideo;

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *photoResolutionCollection;
@property (strong, nonatomic) IBOutletCollection(UITableViewCell) NSArray *burstPhotoModeCollection;

//////////////////////////////

@property (weak, nonatomic) IBOutlet UILabel *photoResolutionDestinationLabel;
@property (weak, nonatomic) IBOutlet UILabel *photoResolution1Label;
@property (weak, nonatomic) IBOutlet UILabel *photoResolution2Label;
@property (weak, nonatomic) IBOutlet UILabel *photoResolution3Label;


- (IBAction)photoResolution1Button:(UIButton *)sender;
- (IBAction)photoResolution2Button:(UIButton *)sender;
- (IBAction)photoResolution3Button:(UIButton *)sender;
////////////////////////////////////

@property (weak, nonatomic) IBOutlet UILabel *burstPhotoDestinationLabel;
@property (weak, nonatomic) IBOutlet UILabel *burstPhoto1Label;
@property (weak, nonatomic) IBOutlet UILabel *burstPhoto2Label;
@property (weak, nonatomic) IBOutlet UILabel *burstPhoto3Label;

- (IBAction)burstPhoto1Button:(UIButton *)sender;
- (IBAction)burstPhoto2Button:(UIButton *)sender;
- (IBAction)burstPhoto3Button:(UIButton *)sender;

@property (strong, nonatomic) NSString * orientation;


@end
