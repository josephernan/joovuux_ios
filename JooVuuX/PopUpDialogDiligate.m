//
//  PopUpDialogDiligate.m
//  JooVuuX
//
//  Created by Andrey on 09.06.15.
//  Copyright (c) 2015 lsoft. All rights reserved.
//

#import "PopUpDialogDiligate.h"

@implementation PopUpDialogDiligate

#pragma mark - XDPopupListViewDataSource & XDPopupListViewDelegate


- (NSInteger)numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}
- (CGFloat)itemCellHeight:(NSIndexPath *)indexPath
{
    return 44.0f;
}
- (void)clickedListViewAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];

    [userDefaults setInteger:(NSInteger)indexPath.row forKey:self.key];
    [userDefaults synchronize];
    
    [self.button setTitle:[self getCurrentData] forState:UIControlStateNormal];
    
    
    NSLog(@"%ld: %@", (long)indexPath.row, [self getCurrentData]);
    
}
- (UITableViewCell *)itemCell:(NSIndexPath *)indexPath
{
    if (self.data.count == 0) {
        return nil;
    }
    static NSString *identifier = @"ddd";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] ;
    cell.textLabel.text = self.data[indexPath.row];
    return cell;
}

-(NSString *) getCurrentData
{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"%@", self.key);

    return [self.data objectAtIndex:[userDefaults integerForKey:self.key]];
    
    
    
}
@end
