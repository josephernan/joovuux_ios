//
//  PopUpDialogDiligate.h
//  JooVuuX
//
//  Created by Andrey on 09.06.15.
//  Copyright (c) 2015 lsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "XDPopupListView.h"

@interface PopUpDialogDiligate : UIViewController <XDPopupListViewDataSource, XDPopupListViewDelegate>

@property (strong, nonatomic) NSMutableArray *data;
@property (strong, nonatomic) NSString * key;
@property (strong, nonatomic) UIButton * button;

-(NSString *) getCurrentData;

@end
