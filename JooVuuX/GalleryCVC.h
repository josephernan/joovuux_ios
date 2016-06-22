//
//  GalleryCVC.h
//  JooVuuX
//
//  Created by Andrey on 05.10.15.
//  Copyright (c) 2015 lsoft. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface GalleryCVC : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>


@property (weak, nonatomic) IBOutlet UILabel *firstGallaryLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondGallaryLabel;
@property (weak, nonatomic) IBOutlet UIView *firstGalleryView;
@property (weak, nonatomic) IBOutlet UIView *secondGalleryView;
@property (strong, nonatomic) NSString * orientation;


- (IBAction)backFirstButton:(UIButton *)sender;
- (IBAction)forwardFirstButton:(UIButton *)sender;


- (IBAction)backSecondButton:(UIButton *)sender;
- (IBAction)forwardSecondButton:(UIButton *)sender;




@end
