//
//  CollectionViewController.h
//  JooVuuX
//
//  Created by Andrey on 05.06.15.
//  Copyright (c) 2015 lsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoDescription.h"
#import "GalleryItem.h"

@interface CollectionViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UIButton *onlyVideoButton;
- (IBAction)onlyVideoButton:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *onlyPictureButton;
- (IBAction)onlyPictureButton:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *allButton;
- (IBAction)allButton:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *byDateButton;
- (IBAction)byDateButton:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *bySizeButton;
- (IBAction)bySizeButton:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *byLenghtButton;
- (IBAction)byLenghtButton:(UIButton *)sender;

@end
