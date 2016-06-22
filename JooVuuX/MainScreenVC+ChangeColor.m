//
//  MainScreenVC+ChangeColor.m
//  JooVuuX
//
//  Created by Vladislav on 01.10.15.
//  Copyright (c) 2015 lsoft. All rights reserved.
//

#import "MainScreenVC+ChangeColor.h"
#import "CameraManager.h"
@implementation MainScreenVC (ChangeColor)

-(void)viewDidLoad {
    [super viewDidLoad];
    
//    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, -20,[UIScreen mainScreen].bounds.size.width, 20)];
//    view.backgroundColor=[UIColor whiteColor];
//    view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//    [self.navigationController.navigationBar addSubview:view];
    


    
    [self.mainSettings addTarget:self action:@selector(settinsButtonHighlight:) forControlEvents:UIControlEventTouchDown];
    [self.mainSettings addTarget:self action:@selector(settinsButton:) forControlEvents:UIControlEventTouchDragOutside];
    
    [self.modeSettings addTarget:self action:@selector(modeButtonHighlight:) forControlEvents:UIControlEventTouchDown];
    [self.modeSettings addTarget:self action:@selector(modeButton:) forControlEvents:UIControlEventTouchDragOutside];
    
    
    [self.galery addTarget:self action:@selector(galeryButtonHighlight:) forControlEvents:UIControlEventTouchDown];
    [self.galery addTarget:self action:@selector(galeryButton:) forControlEvents:UIControlEventTouchDragOutside];
    
    [self.streaming addTarget:self action:@selector(streamButtonHighlight:) forControlEvents:UIControlEventTouchDown];
    [self.streaming addTarget:self action:@selector(streamButton:) forControlEvents:UIControlEventTouchDragOutside];
    
    [self.photo addTarget:self action:@selector(photosButtonHighlight:) forControlEvents:UIControlEventTouchDown];
    [self.photo addTarget:self action:@selector(photosButton:) forControlEvents:UIControlEventTouchDragOutside];
    
    [self.video addTarget:self action:@selector(videosButtonHighlight:) forControlEvents:UIControlEventTouchDown];
    [self.video addTarget:self action:@selector(videosButton:) forControlEvents:UIControlEventTouchDragOutside];

    [self.conntecting addTarget:self action:@selector(connectButtonHighlight:) forControlEvents:UIControlEventTouchDown];
    [self.conntecting addTarget:self action:@selector(connectButton:) forControlEvents:UIControlEventTouchDragOutside];
    
    [self.camera addTarget:self action:@selector(camButtonHighlight:) forControlEvents:UIControlEventTouchDown];
    [self.camera addTarget:self action:@selector(camButton:) forControlEvents:UIControlEventTouchDragOutside];
    
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


-(void)settinsButtonHighlight:(UIButton*) button {

 [self.mainSettings setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1]] forState:UIControlStateHighlighted];
 [self.mainSettingsView setBackgroundColor:[UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1]];


}

-(void)settinsButton:(UIButton*) button {
    
    [self.mainSettings setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1]] forState:UIControlStateHighlighted];
    [self.mainSettingsView setBackgroundColor:[UIColor whiteColor]];
}


-(void)modeButtonHighlight:(UIButton*) button {
    
    [self.modeSettings setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1]] forState:UIControlStateHighlighted];
    [self.modeSettingsView setBackgroundColor:[UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1]];
}

-(void)modeButton:(UIButton*) button {
    
    [self.modeSettings setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1]] forState:UIControlStateHighlighted];
    [self.modeSettingsView setBackgroundColor:[UIColor whiteColor]];
    
    
}



-(void)galeryButtonHighlight:(UIButton*) button {
    
    [self.galery setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1]] forState:UIControlStateHighlighted];
    [self.galeryView setBackgroundColor:[UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1]];
    
    
}

-(void)galeryButton:(UIButton*) button {
    
    [self.galery setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1]] forState:UIControlStateHighlighted];
    [self.galeryView setBackgroundColor:[UIColor whiteColor]];
    
    
}

-(void)streamButtonHighlight:(UIButton*) button {
    
    [self.streaming setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1]] forState:UIControlStateHighlighted];
    [self.streamingView setBackgroundColor:[UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1]];
    
    
}

-(void)streamButton:(UIButton*) button {
    
    [self.streaming setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1]] forState:UIControlStateHighlighted];
    [self.streamingView setBackgroundColor:[UIColor whiteColor]];
    
    
}


-(void)photosButtonHighlight:(UIButton*) button {
    
    [self.photo setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1]] forState:UIControlStateHighlighted];
    [self.photoView setBackgroundColor:[UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1]];
    
    
}

-(void)photosButton:(UIButton*) button {
    
    [self.photo setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1]] forState:UIControlStateHighlighted];
    [self.photoView setBackgroundColor:[UIColor whiteColor]];
    
    
}

-(void)videosButtonHighlight:(UIButton*) button {
    
    [self.video setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1]] forState:UIControlStateHighlighted];
    [self.videoView setBackgroundColor:[UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1]];
    
    
}

-(void)videosButton:(UIButton*) button {
    
    [self.video setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1]] forState:UIControlStateHighlighted];
    [self.videoView setBackgroundColor:[UIColor whiteColor]];
    
    
}


-(void)connectButtonHighlight:(UIButton*) button {
    
    [self.conntecting setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1]] forState:UIControlStateHighlighted];
    [self.connectingView setBackgroundColor:[UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1]];
    
    
}

-(void)connectButton:(UIButton*) button {
    
    [self.conntecting setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1]] forState:UIControlStateHighlighted];
    [self.connectingView setBackgroundColor:[UIColor whiteColor]];
    
}


-(void)camButtonHighlight:(UIButton*) button {
    
    [self.camera setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1]] forState:UIControlStateHighlighted];
    [self.cameraView setBackgroundColor:[UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1]];
    
    
}

-(void)camButton:(UIButton*) button {
    
    [self.camera setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1]] forState:UIControlStateHighlighted];
    [self.cameraView setBackgroundColor:[UIColor whiteColor]];
    
}




@end
