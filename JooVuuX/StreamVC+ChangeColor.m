//
//  StreamVC+ChangeColor.m
//  JooVuuX
//
//  Created by Vladislav on 01.10.15.
//  Copyright (c) 2015 lsoft. All rights reserved.
//

#import "StreamVC+ChangeColor.h"



@implementation StreamVC (ChangeColor)


-(void)viewDidLoad {
    
    
 
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];

    [self.stream addTarget:self action:@selector(streamButtonHighlight:) forControlEvents:UIControlEventTouchDown];
    [self.stream addTarget:self action:@selector(streamButton:) forControlEvents:UIControlEventTouchDragOutside];
    
    [self.photo addTarget:self action:@selector(photosButtonHighlight:) forControlEvents:UIControlEventTouchDown];
    [self.photo addTarget:self action:@selector(photosButton:) forControlEvents:UIControlEventTouchDragOutside];
    
    [self.video addTarget:self action:@selector(videosButtonHighlight:) forControlEvents:UIControlEventTouchDown];
    [self.video addTarget:self action:@selector(videosButton:) forControlEvents:UIControlEventTouchDragOutside];
    
    [self.settings addTarget:self action:@selector(settingssButtonHighlight:) forControlEvents:UIControlEventTouchDown];
    [self.settings addTarget:self action:@selector(settingssButton:) forControlEvents:UIControlEventTouchDragOutside];
    
    [self.info addTarget:self action:@selector(infosButtonHighlight:) forControlEvents:UIControlEventTouchDown];
    [self.info addTarget:self action:@selector(infosButton:) forControlEvents:UIControlEventTouchDragOutside];
    
    [self.modes addTarget:self action:@selector(modessButtonHighlight:) forControlEvents:UIControlEventTouchDown];
    [self.modes addTarget:self action:@selector(modessButton:) forControlEvents:UIControlEventTouchDragOutside];
    
    [self.modeOneButton addTarget:self action:@selector(modesOneButtonHighlight:) forControlEvents:UIControlEventTouchDown];
    [self.modeOneButton addTarget:self action:@selector(modesOneButton:) forControlEvents:UIControlEventTouchDragOutside];
    
    [self.modeTwoButton addTarget:self action:@selector(modesTwoButtonHighlight:) forControlEvents:UIControlEventTouchDown];
    [self.modeTwoButton addTarget:self action:@selector(modesTwoButton:) forControlEvents:UIControlEventTouchDragOutside];
    
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


-(void)streamButtonHighlight:(UIButton*) button {
    
    [self.stream setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1]] forState:UIControlStateHighlighted];
    [self.streamView setBackgroundColor:[UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1]];
  
}

-(void)streamButton:(UIButton*) button {
    
    [self.stream setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1]] forState:UIControlStateHighlighted];
    [self.streamView setBackgroundColor:[UIColor whiteColor]];
    
    
}

-(void)photosButtonHighlight:(UIButton*) button {
    
    [self.photo setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1]] forState:UIControlStateHighlighted];
    [self.photoVIew setBackgroundColor:[UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1]];
    
}

-(void)photosButton:(UIButton*) button {
    
    [self.photo setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1]] forState:UIControlStateHighlighted];
    [self.photoVIew setBackgroundColor:[UIColor whiteColor]];
    
    
}

-(void)videosButtonHighlight:(UIButton*) button {
    
    [self.video setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1]] forState:UIControlStateHighlighted];
    [self.videoView setBackgroundColor:[UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1]];
    
}

-(void)videosButton:(UIButton*) button {
    
    [self.video setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1]] forState:UIControlStateHighlighted];
    [self.videoView setBackgroundColor:[UIColor whiteColor]];
}


-(void)settingssButtonHighlight:(UIButton*) button {
    
    [self.settings setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1]] forState:UIControlStateHighlighted];
    [self.settingsView setBackgroundColor:[UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1]];
    
}

-(void)settingssButton:(UIButton*) button {
    
    [self.settings setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1]] forState:UIControlStateHighlighted];
    [self.settingsView setBackgroundColor:[UIColor whiteColor]];
}


-(void)infosButtonHighlight:(UIButton*) button {
    
    [self.info setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1]] forState:UIControlStateHighlighted];
    [self.infoVIew setBackgroundColor:[UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1]];
    
}

-(void)infosButton:(UIButton*) button {
    
    [self.info setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1]] forState:UIControlStateHighlighted];
    [self.infoVIew setBackgroundColor:[UIColor whiteColor]];
}

-(void)modessButtonHighlight:(UIButton*) button {
    [self.modes setBackgroundColor:[UIColor colorWithRed:255/256.0 green:149/256.0 blue:17/256.0 alpha:1]];
    
}

-(void)modessButton:(UIButton*) button {
    [self.modes setBackgroundColor:[UIColor colorWithRed:218/256.0 green:216/256.0 blue:216/256.0 alpha:1]];
    
}

-(void)modesOneButton:(UIButton*) button {
    self.modeOneLabel.backgroundColor = [UIColor whiteColor];
}

-(void)modesOneButtonHighlight:(UIButton*) button {
    self.modeOneLabel.backgroundColor = [UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1];
}

-(void)modesTwoButton:(UIButton*) button {
    self.modeTwoLabel.backgroundColor = [UIColor whiteColor];
}


-(void)modesTwoButtonHighlight:(UIButton*) button {
    self.modeTwoLabel.backgroundColor = [UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1];

}


@end
