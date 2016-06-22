//
//  WhiteBalanceVC.h
//  JooVuuX
//
//  Created by Andrey on 01.10.15.
//  Copyright (c) 2015 lsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WhiteBalanceVC : UIViewController <UIScrollViewDelegate>


@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *sharpnessLabelCollection;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *contrastLabelCollection;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *whiteBalanceCollection;


@property (weak, nonatomic) IBOutlet UIButton *resetSettings;
@property (weak, nonatomic) IBOutlet UILabel *resetAllSettingsLabel;

- (IBAction)resetAllSettings:(UIButton *)sender;




@end
