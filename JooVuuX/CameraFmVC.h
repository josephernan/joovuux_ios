//
//  CameraFmVC.h
//  JooVuuX
//
//  Created by Vladislav on 01.10.15.
//  Copyright (c) 2015 lsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CameraFmVC : UIViewController

- (IBAction)backButton:(UIBarButtonItem *)sender;

@property (weak, nonatomic) IBOutlet UIButton *whiteBalance;
- (IBAction)whiteBalanceButton:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *whiteBalanceLabel;




@property (weak, nonatomic) IBOutlet UILabel *formatSdCardLabel;
@property (weak, nonatomic) IBOutlet UIButton *formatSdCard;
- (IBAction)formatSdCardButton:(UIButton *)sender;



@end
