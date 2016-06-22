//
//  CollectionViewCell.h
//  JooVuuX
//
//  Created by Andrey on 05.06.15.
//  Copyright (c) 2015 lsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellObject.h"
@interface PhotoCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *photoImage;

@property (strong, nonatomic) UIImage * imageImage;

@property (strong, nonatomic) CellObject * imageCell;

@end
