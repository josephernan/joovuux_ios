//
//  InfoJooVuuXVC.m
//  JooVuuX
//
//  Created by Andrey on 18.06.15.
//  Copyright (c) 2015 lsoft. All rights reserved.
//

#import "InfoJooVuuXVC.h"

@interface InfoJooVuuXVC ()

@end

@implementation InfoJooVuuXVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setSettingsView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) setSettingsView
{
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]]];
    
    for (UIView * view in self.backgroundAllView) {
        
        [view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"beckground-box"]]];
        
    }
    
}

@end
