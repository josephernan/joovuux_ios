//
//  CollectionViewController.m
//  JooVuuX
//
//  Created by Andrey on 05.06.15.
//  Copyright (c) 2015 lsoft. All rights reserved.
//
#import <ImageIO/ImageIO.h>
#import "CollectionViewController.h"
#import <FCFileManager.h>
#import "PhotoCell.h"
#import "VideoCell.h"
#import "CellObject.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "PhotoDescription.h"
#import "VideoDescription.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "GalleryItem.h"
#import "CameraManager.h"
@interface CollectionViewController ()

@property (strong,nonatomic) NSMutableArray * contentsArrayM;
@property (strong ,nonatomic) NSMutableDictionary *cachedImages;
@property (strong, nonatomic) NSMutableArray * itemArray;
@property (strong, nonatomic) NSMutableArray * tempItemArray;
@property (strong ,nonatomic) CellObject * temp;

@end

@implementation CollectionViewController

//static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setSettingsView];
//    [self createPhotoArray];
//    [self writePhoto];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


#pragma mark - setSettingsView
-(void) setSettingsView
{
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]]];
    NSDictionary *titleAttributes =@{NSFontAttributeName :[UIFont fontWithName:@"Helvetica-Bold" size:14.0],
                                     NSForegroundColorAttributeName : [UIColor whiteColor]};
    [[UINavigationBar appearance] setTitleTextAttributes:titleAttributes];
    
    
    
    [FCFileManager createDirectoriesForPath:[[FCFileManager pathForDocumentsDirectory] stringByAppendingString:@"/album"]];
    self.cachedImages = [[NSMutableDictionary alloc] init];
    self.itemArray = [[NSMutableArray alloc] init];
    self.tempItemArray = [[NSMutableArray alloc] init];
    [self listFileAtPath];
    [self.tempItemArray addObjectsFromArray:self.itemArray];
    [self sortedData];
    [self sortedAll];
    self.automaticallyAdjustsScrollViewInsets = NO;
}




//-(void) createPhotoArray
//{
//    
//        self.contentsArrayM = [[NSMutableArray alloc] init];
//        
//        PhotoCell * img1 = [[PhotoCell alloc] init];
//        img1.imageImage = [UIImage imageNamed:@"1.jpg"];
//        [self.contentsArrayM addObject:img1];
//        PhotoCell * img2 = [[PhotoCell alloc] init];
//        img2.imageImage = [UIImage imageNamed:@"2.jpg"];
//        [self.contentsArrayM addObject:img2];
//        PhotoCell * img3 = [[PhotoCell alloc] init];
//        img3.imageImage = [UIImage imageNamed:@"3.jpg"];
//        [self.contentsArrayM addObject:img3];
//        PhotoCell * img4 = [[PhotoCell alloc] init];
//        img4.imageImage = [UIImage imageNamed:@"4.jpg"];
//        [self.contentsArrayM addObject:img4];
//    
//}
//
//
//-(void) writePhoto
//{
//    //ЗАПИСЬ ФАЙЛОВ
//        for (PhotoCell * image in self.contentsArrayM) {
//
//            NSString *fileNamePath = image.photoImage;
//            
//
//                                 
//            NSString *testPathTemp = [FCFileManager pathForTemporaryDirectoryWithPath:fileNamePath];
//
//            [FCFileManager writeFileAtPath:testPathTemp content:[UIImage imageNamed:fileNamePath]];
//            
//            NSLog(@"%@", testPathTemp);
//            
//        }
//}

#pragma mark - create thumbnail

-(UIImage * )vidImage: (NSURL * ) url
{
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:url options:nil];
    AVAssetImageGenerator *generateImg = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    generateImg.appliesPreferredTrackTransform = YES;
    NSError *error = NULL;
    CMTime time = CMTimeMake(1, 1);
    CGImageRef refImg = [generateImg copyCGImageAtTime:time actualTime:NULL error:&error];
    UIImage *FrameImage= [[UIImage alloc] initWithCGImage:refImg];
    
    return FrameImage;

}

#pragma mark - получаем все элементы в папке

//-(void)listFileAtPath;
//{
//    int count;
//    
//    NSArray *directoryContent = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[[FCFileManager pathForDocumentsDirectory] stringByAppendingString:@"/album"] error:NULL];
//    for (count = 0; count < (int)[directoryContent count]; count++)
//    {
//
//        NSDictionary *fileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:[[[FCFileManager pathForDocumentsDirectory] stringByAppendingString:@"/album/"] stringByAppendingString:[directoryContent objectAtIndex:count]] error:nil];
//
//        NSNumber * fileSize = [fileAttributes objectForKey:NSFileSize];
//        
//        NSDate *fileDate = [[[NSFileManager defaultManager] attributesOfItemAtPath:[[[FCFileManager pathForDocumentsDirectory] stringByAppendingString:@"/album/"] stringByAppendingString:[directoryContent objectAtIndex:count]] error:nil] fileCreationDate];
//        
//        NSString * fileName = [directoryContent objectAtIndex:count];
//        
//        NSURL * fileURL = [NSURL fileURLWithPath:[[[FCFileManager pathForDocumentsDirectory] stringByAppendingString:@"/album/"] stringByAppendingString:fileName]];
//        
//        NSString *resourceName = [[[FCFileManager pathForDocumentsDirectory] stringByAppendingString:@"/album/"] stringByAppendingString:fileName];
//        
//        NSURL *URL = [NSURL fileURLWithPath:resourceName];
//        
//        AVURLAsset *avUrl = [AVURLAsset assetWithURL:URL];
//        CMTime time = [avUrl duration];
//        int fileTime = ceil(time.value/time.timescale);
//        
//        GalleryItem * item = [[GalleryItem alloc] init];
//        
//        item.fileName = fileName;
//        item.fileSize = fileSize;
//        item.fileDate = fileDate;
//        item.fileURL = fileURL;
//        item.fileTime = fileTime;
//
//        [self.itemArray addObject:item];
//        
//    }
//}


-(void)listFileAtPath;
{
    NSFileManager * fileMan = [[NSFileManager alloc] init];
    NSArray * files = [fileMan contentsOfDirectoryAtPath:@"http://192.168.42.1/DCMA" error:nil];
    
    if (files)
    {
        for(int index=0;index<files.count;index++)
        {
            NSString * file = [files objectAtIndex:index];
            
            if( [[file pathExtension] compare: @"mov"] == NSOrderedSame )
            {
                // do something with files that end with .jpg
            }
        }
    }
    
    NSLog(@"%@", [files objectAtIndex:1]);
    //[[CameraManager cameraManager] getFiles];
}




#pragma mark <UICollectionViewDataSource>


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.itemArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoCell * cellPhoto = [collectionView dequeueReusableCellWithReuseIdentifier:@"CellPhoto" forIndexPath:indexPath];
    VideoCell * cellVideo = [collectionView dequeueReusableCellWithReuseIdentifier:@"CellVideo" forIndexPath:indexPath];
    
    self.temp = [[CellObject alloc] init];


    NSURL * fileUrl = [[self.itemArray objectAtIndex:indexPath.row] fileURL];
    NSString * url = [fileUrl path];
    NSString * fileName = [[self.itemArray objectAtIndex:indexPath.row] fileName];

    if ([[fileName pathExtension] isEqualToString:@"jpg"] || [[fileName pathExtension] isEqualToString:@"JPG"]) {
        self.temp.url = url;
        cellPhoto.imageCell = self.temp;
        [cellPhoto.photoImage sd_setImageWithURL:fileUrl];
        return cellPhoto;
    }
    else
    {
        self.temp.url =  url;
        cellVideo.imageCell = self.temp;
        if([self.cachedImages objectForKey:[@"CellVideo" stringByAppendingString:fileName]] != nil){
            cellVideo.videoImage.image = [self.cachedImages valueForKey:[@"CellVideo" stringByAppendingString:fileName]];
            
        }else{
            char const * s = [@"CellVideo"  UTF8String];
            dispatch_queue_t queue = dispatch_queue_create(s, 0);
            dispatch_async(queue, ^{
                UIImage *img = [self vidImage:fileUrl];
                dispatch_async(dispatch_get_main_queue(), ^{
                    if ([collectionView indexPathForCell:cellVideo].row == indexPath.row) {
                        [self.cachedImages setValue:img forKey:[@"CellVideo" stringByAppendingString:fileName]];
                        cellVideo.videoImage.image = [self.cachedImages valueForKey:[@"CellVideo" stringByAppendingString:fileName]];
                    }
                });
            });
        }
        [cellVideo loadShowCell];
        return cellVideo;
    }
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [super prepareForSegue:segue sender:sender];

    if ([sender isKindOfClass:[PhotoCell class]])
    {
        PhotoDescription *destViewController = segue.destinationViewController;
        PhotoCell * cellPhoto = sender;
        destViewController.url = cellPhoto.imageCell.url;
    }
    else if ([sender isKindOfClass:[VideoCell class]])
    {
        VideoDescription *destViewController = segue.destinationViewController;
        VideoCell * cellVideo = sender;
        destViewController.url = cellVideo.imageCell.url;
        destViewController.image = cellVideo.imageCell.fullImage;
    }

}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(147, 120);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(8, 8, 8, 8);
}


- (void)sortButtonCellSelected:(UIButton *)selectBtn btn2:(UIButton *)btn2 btn3:(UIButton *)btn3
{
    [selectBtn setBackgroundImage: [UIImage imageNamed:@"mode_pressed"] forState:UIControlStateNormal];
    [selectBtn setSelected:YES];
    [selectBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [btn2 setBackgroundImage:[UIImage imageNamed:@"mode_not_pressed"] forState:UIControlStateNormal];
    [btn2 setSelected:NO];
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [btn3 setBackgroundImage:[UIImage imageNamed:@"mode_not_pressed"] forState:UIControlStateNormal];
    [btn3 setSelected:NO];
    [btn3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
}

- (void)sortButtonSelected:(UIButton *)selectBtn btn2:(UIButton *)btn2 btn3:(UIButton *)btn3
{
    [selectBtn setBackgroundImage: [UIImage imageNamed:@"mode_pressed"] forState:UIControlStateNormal];
    [selectBtn setSelected:YES];
    [selectBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [btn2 setBackgroundImage:[UIImage imageNamed:@"mode_not_pressed"] forState:UIControlStateNormal];
    [btn2 setSelected:NO];
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [btn3 setBackgroundImage:[UIImage imageNamed:@"mode_not_pressed"] forState:UIControlStateNormal];
    [btn3 setSelected:NO];
    [btn3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
}

-(void) sortedVideo
{
    [self.itemArray removeAllObjects];
    [self.itemArray addObjectsFromArray:self.tempItemArray];
    
    for (int i = 0; i < self.itemArray.count; i++) {
        
        NSString * fileName = [[self.itemArray objectAtIndex:i] fileName];
        
        if (![[fileName pathExtension] isEqualToString:@"MOV"] || [[fileName pathExtension] isEqualToString:@"mov"]) {
            
            [self.itemArray removeObjectAtIndex:i];
            i--;
        }
    }
    
    [self.collectionView reloadData];
    [self sortButtonSelected:_onlyVideoButton btn2:_onlyPictureButton btn3:_allButton];
}

-(void) sortedPicture
{
    [self.itemArray removeAllObjects];
    [self.itemArray addObjectsFromArray:self.tempItemArray];
    
    for (int i = 0; i < self.itemArray.count; i++) {
        
        NSString * fileName = [[self.itemArray objectAtIndex:i] fileName];
        
        if (![[fileName pathExtension] isEqualToString:@"JPG"] || [[fileName pathExtension] isEqualToString:@"jpg"]) {
            
            [self.itemArray removeObjectAtIndex:i];
            i--;
        }
        
    }
    
    [self.collectionView reloadData];
    [self sortButtonSelected:_onlyPictureButton btn2:_onlyVideoButton btn3:_allButton];
}

-(void) sortedAll
{
    [self.itemArray removeAllObjects];
    [self.itemArray addObjectsFromArray:self.tempItemArray];
    [self.collectionView reloadData];
    
    [self sortButtonSelected:_allButton btn2:_onlyVideoButton btn3:_onlyPictureButton];
}

-(void) sortedData
{
    [self sortButtonCellSelected:_byDateButton btn2:_bySizeButton btn3:_byLenghtButton];
    NSSortDescriptor *dateSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"fileDate" ascending:YES];
    [self.itemArray sortUsingDescriptors:@[dateSortDescriptor]];
    [self.collectionView reloadData];
}

-(void) sortedSize
{
    [self sortButtonCellSelected:_bySizeButton btn2:_byDateButton btn3:_byLenghtButton];
    NSSortDescriptor *sizeSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"fileSize" ascending:YES];
    [self.itemArray sortUsingDescriptors:@[sizeSortDescriptor]];
    [self.collectionView reloadData];
}

-(void) sortedLenght
{
    [self sortButtonCellSelected:_byLenghtButton btn2:_bySizeButton btn3:_byDateButton];
    NSSortDescriptor *timeSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"fileTime" ascending:YES];
    [self.itemArray sortUsingDescriptors:@[timeSortDescriptor]];
    [self.collectionView reloadData];
}

- (IBAction)onlyVideoButton:(UIButton *)sender
{
    [self sortedVideo];
}

- (IBAction)onlyPictureButton:(UIButton *)sender
{
    [self sortedPicture];
}

- (IBAction)allButton:(UIButton *)sender
{
    [self sortedAll];
}

- (IBAction)byDateButton:(UIButton *)sender {
    [self sortedData];
}
- (IBAction)bySizeButton:(UIButton *)sender {
    [self sortedSize];
}
- (IBAction)byLenghtButton:(UIButton *)sender {
    [self sortedLenght];
}

@end
