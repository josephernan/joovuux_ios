//
//  PhotoVC.h
//  JooVuuX
//
//  Created by Vladislav on 13.10.15.
//  Copyright (c) 2015 lsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoVC : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (strong, nonatomic)NSString* namePhoto;


- (IBAction)backButton:(UIBarButtonItem *)sender;



@end
