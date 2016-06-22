//
//  ConntectionVC.h
//  JooVuuX
//
//  Created by Vladislav on 02.10.15.
//  Copyright (c) 2015 lsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CFNetwork/CFNetwork.h>
#import <GBPing/GBPing.h>

@interface ConnectionVC : UIViewController <GBPingDelegate>
{
    int pingCount;
    int pingError;
}



@property (strong, nonatomic) GBPing *ping;
@property (weak, nonatomic) IBOutlet UIButton *connection;
- (IBAction)connectionButton:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *connectionLabel;

- (IBAction)backButton:(UIBarButtonItem*)sender;


@end
