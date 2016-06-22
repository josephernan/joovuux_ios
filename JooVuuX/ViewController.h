//
//  ViewController.h
//  JooVuuX
//
//  Created by Andrey on 09.06.15.
//  Copyright (c) 2015 lsoft. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

- (IBAction)facebookButton:(UIButton *)sender;
- (IBAction)twitterButton:(UIButton *)sender;
- (IBAction)youTubeButton:(UIButton *)sender;

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *backgroundAllView;

- (IBAction)connectToCamera:(UIButton *)sender;

- (IBAction)takePhoto:(UIButton *)sender;

@property (strong, nonatomic) NSString * token;

@end
