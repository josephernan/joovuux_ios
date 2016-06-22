//
//  ViewController.m
//  JooVuuX
//
//  Created by Andrey on 09.06.15.
//  Copyright (c) 2015 lsoft. All rights reserved.
//

#import "ViewController.h"
#import "CameraManager.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setSettingsView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - setSettingsView

-(void) setSettingsView
{
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]]];
    
    for (UIView * view in self.backgroundAllView) {
        
        [view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"beckground-box"]]];
        
    }
    
}
- (IBAction)facebookButton:(UIButton *)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.facebook.com/joovuu"]];
}

- (IBAction)twitterButton:(UIButton *)sender
{
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.twitter.com/joovuu"]];
}

- (IBAction)youTubeButton:(UIButton *)sender
{
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.youtube.com/joovuu"]];
}


- (IBAction)connectToCamera:(UIButton *)sender {
  

    
}



- (IBAction)takePhoto:(UIButton *)sender {
    
    
}

@end