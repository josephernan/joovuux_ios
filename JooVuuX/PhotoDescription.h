//
//  ImageDescriptionViewController.h
//  JooVuuX
//
//  Created by Andrey on 08.06.15.
//  Copyright (c) 2015 lsoft. All rights reserved.
//

#import "CellObject.h"
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreMedia/CoreMedia.h>

@interface PhotoDescription : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *fullImage;

@property (strong, nonatomic) UIImage * image;

@property (strong, nonatomic) NSString * url;

- (IBAction)sharePhoto:(UIBarButtonItem *)sender;
@end
