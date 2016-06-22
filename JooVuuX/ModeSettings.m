//
//  ModeSettings.m
//  JooVuuX
//
//  Created by Andrey on 19.06.15.
//  Copyright (c) 2015 lsoft. All rights reserved.
//

#import "ModeSettings.h"


@implementation ModeSettings

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initPopupTables];
        
    }
    return self;
}

-(void) initPopupTables
{
    self.videoResolutions = [NSMutableArray arrayWithObjects:@"2304x1296P30", @"1920x1080P60", @"1920x1080P45",  @"1920x1080P30HDR",  @"1920X1080P30",  @"1280x720P60",  @"1280x720P30", nil];
    
    self.videoBitRates = [NSMutableArray arrayWithObjects:@"30", @"24", @"15", @"10", @"5", nil];
    
    self.videoClipLenght = [NSMutableArray arrayWithObjects:@"1", @"2", @"3", @"5", @"10", @"Off", nil];
    
    self.wdrData = [NSMutableArray arrayWithObjects:@"On", @"Off", @"Low Light", nil];
    
    self.fieldOfView = [NSMutableArray arrayWithObjects:@"155", @"140", @"125", @"110", @"90", @"60", nil];
    

}



@end
