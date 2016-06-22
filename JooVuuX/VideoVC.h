//
//  VideoVC.h
//  JooVuuX
//
//  Created by Vladislav on 14.10.15.
//  Copyright (c) 2015 lsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoVC : UIViewController




@property (weak, nonatomic) IBOutlet UIImageView *videoImageView;

@property (assign, nonatomic) BOOL localVideo;
@property (strong, nonatomic) NSMutableDictionary * curObject;

- (IBAction)backButton:(UIBarButtonItem *)sender;




@end
