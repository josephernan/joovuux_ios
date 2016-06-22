//
//  ModeViewController.h
//  JooVuuX
//
//  Created by Andrey on 22.05.15.
//  Copyright (c) 2015 lsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ModeInformationVC : UIViewController
{
    BOOL buttonOneChecked;
    BOOL buttonTwoChecked;
    BOOL buttonThreeChecked;
}

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *beckgroundAllView;

@property (weak, nonatomic) IBOutlet UIButton *modeOneButton;
- (IBAction)modeOneButton:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *modeTwoButton;
- (IBAction)modeTwoButton:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *modeThreeButton;
- (IBAction)modeThreeButton:(UIButton *)sender;

@end
