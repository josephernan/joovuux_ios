//
//  CameraFmVC+ChangeColor.m
//  JooVuuX
//
//  Created by Vladislav on 02.10.15.
//  Copyright (c) 2015 lsoft. All rights reserved.
//

#import "CameraFmVC+ChangeColor.h"

@implementation CameraFmVC (ChangeColor)

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [self.whiteBalance addTarget:self action:@selector(whiteButtonHighlight:) forControlEvents:UIControlEventTouchDown];
    [self.whiteBalance addTarget:self action:@selector(whiteButton:) forControlEvents:UIControlEventTouchDragOutside];
    
    [self.formatSdCard addTarget:self action:@selector(formatButtonHighlight:) forControlEvents:UIControlEventTouchDown];
    [self.formatSdCard addTarget:self action:@selector(formatButton:) forControlEvents:UIControlEventTouchDragOutside];
    
}

-(UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


-(void)whiteButtonHighlight:(UIButton*) button {
    
    self.whiteBalanceLabel.backgroundColor = [UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1];
}

-(void)whiteButton:(UIButton*) button {
    
    self.whiteBalanceLabel.backgroundColor = [UIColor colorWithRed:149/256.0 green:149/256.0 blue:149/256.0 alpha:1];
}

-(void)formatButtonHighlight:(UIButton*) button {
    
    self.formatSdCardLabel.backgroundColor = [UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1];
}

-(void)formatButton:(UIButton*) button {
    
    self.formatSdCardLabel.backgroundColor = [UIColor colorWithRed:149/256.0 green:149/256.0 blue:149/256.0 alpha:1];
}

@end
