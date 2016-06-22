//
//  ConnectionVC+ChangeColor.m
//  JooVuuX
//
//  Created by Vladislav on 02.10.15.
//  Copyright (c) 2015 lsoft. All rights reserved.
//

#import "ConnectionVC+ChangeColor.h"

@implementation ConnectionVC (ChangeColor)


-(void)viewDidLoad {

    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];

    
    [self.connection addTarget:self action:@selector(connectionsButtonHighlight:) forControlEvents:UIControlEventTouchDown];
    [self.connection addTarget:self action:@selector(connectionsButton:) forControlEvents:UIControlEventTouchDragOutside];

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


-(void)connectionsButtonHighlight:(UIButton*) button {
    
    self.connectionLabel.backgroundColor = [UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1];
}

-(void)connectionsButton:(UIButton*) button {
    
    self.connectionLabel.backgroundColor = [UIColor colorWithRed:149/256.0 green:149/256.0 blue:149/256.0 alpha:1];
}

@end
