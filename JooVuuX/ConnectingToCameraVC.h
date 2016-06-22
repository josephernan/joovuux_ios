//
//  ConnectingToCameraVC.h
//  JooVuuX
//
//  Created by Andrey on 14.07.15.
//  Copyright (c) 2015 lsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CFNetwork/CFNetwork.h>
#import <GBPing/GBPing.h>
@interface ConnectingToCameraVC : UIViewController <GBPingDelegate>
{
    int pingCount;
    int pingError;
}
- (IBAction)connectButton:(UIButton *)sender;

@property (strong, nonatomic) GBPing *ping;
@property (weak, nonatomic) IBOutlet UIView *backgroundView;

@end
