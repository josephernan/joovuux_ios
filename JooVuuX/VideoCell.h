//
//  VideoCell.h
//  JooVuuX
//
//  Created by Andrey on 09.06.15.
//  Copyright (c) 2015 lsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellObject.h"

@interface VideoCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *videoImage;

@property (weak, nonatomic) IBOutlet UIImageView *iconType;

@property (strong, nonatomic) CellObject * imageCell;

-(void) loadShowCell;

@end
