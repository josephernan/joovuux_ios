//
//  ModeViewController.m
//  JooVuuX
//
//  Created by Andrey on 22.05.15.
//  Copyright (c) 2015 lsoft. All rights reserved.
//

#import "ModeInformationVC.h"

@interface ModeInformationVC ()

@end

@implementation ModeInformationVC



- (void)loadView
{
    [super loadView];
    [self setSettingsView];
    
    
   
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    buttonOneChecked = NO;
    buttonTwoChecked = NO;
    buttonThreeChecked = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - setSettingsView

-(void) setSettingsView
{
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]]];
    
    for (UIView * view in self.beckgroundAllView) {
        
        [view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"beckground-box"]]];
        
    }
    
}

#pragma mark - set Button presset

- (IBAction)modeOneButton:(UIButton *)sender
{
    
    if (!buttonOneChecked) {
        [self.modeOneButton setBackgroundImage: [UIImage imageNamed:@"mode_pressed"] forState:UIControlStateNormal];
        buttonOneChecked = YES;
        [self.modeOneButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        
        [self.modeTwoButton setBackgroundImage:[UIImage imageNamed:@"mode_not_pressed"] forState:UIControlStateNormal];
        buttonTwoChecked = NO;
        [self.modeTwoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [self.modeThreeButton setBackgroundImage:[UIImage imageNamed:@"mode_not_pressed"] forState:UIControlStateNormal];
        buttonThreeChecked = NO;
        [self.modeThreeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        
        
    }
    else if (buttonOneChecked)
    {
        [self.modeOneButton setBackgroundImage:[UIImage imageNamed:@"mode_not_pressed"] forState:UIControlStateNormal];
        buttonOneChecked = NO;
        [self.modeOneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }

    
}
- (IBAction)modeTwoButton:(UIButton *)sender
{
    if (!buttonTwoChecked) {
        [self.modeTwoButton setBackgroundImage: [UIImage imageNamed:@"mode_pressed"] forState:UIControlStateNormal];
        buttonTwoChecked = YES;
        [self.modeTwoButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        
        [self.modeThreeButton setBackgroundImage:[UIImage imageNamed:@"mode_not_pressed"] forState:UIControlStateNormal];
        buttonThreeChecked = NO;
        [self.modeThreeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [self.modeOneButton setBackgroundImage:[UIImage imageNamed:@"mode_not_pressed"] forState:UIControlStateNormal];
        buttonOneChecked = NO;
        [self.modeOneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
    }
    else if (buttonTwoChecked)
    {
        [self.modeTwoButton setBackgroundImage:[UIImage imageNamed:@"mode_not_pressed"] forState:UIControlStateNormal];
        buttonTwoChecked = NO;
        [self.modeTwoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }

}
- (IBAction)modeThreeButton:(UIButton *)sender
{
    if (!buttonThreeChecked) {
        [self.modeThreeButton setBackgroundImage: [UIImage imageNamed:@"mode_pressed"] forState:UIControlStateNormal];
        buttonThreeChecked = YES;
        [self.modeThreeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [self.modeOneButton setBackgroundImage:[UIImage imageNamed:@"mode_not_pressed"] forState:UIControlStateNormal];
        buttonOneChecked = NO;
        [self.modeOneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [self.modeTwoButton setBackgroundImage:[UIImage imageNamed:@"mode_not_pressed"] forState:UIControlStateNormal];
        buttonTwoChecked = NO;
        [self.modeTwoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
    }
    else if (buttonThreeChecked)
    {
        [self.modeThreeButton setBackgroundImage:[UIImage imageNamed:@"mode_not_pressed"] forState:UIControlStateNormal];
        buttonThreeChecked = NO;
        [self.modeThreeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }

}
@end
