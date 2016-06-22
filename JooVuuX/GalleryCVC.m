//
//  GalleryCVC.m
//  JooVuuX
//
//  Created by Andrey on 05.10.15.
//  Copyright (c) 2015 lsoft. All rights reserved.
//

#import "GalleryCVC.h"
#import "GalleryCell.h"
#import <FCFileManager.h>
#import <AVFoundation/AVFoundation.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "CameraManager.h"
#import <UAProgressView.h>
#import "PhotoVC.h"
#import "VideoVC.h"
#import "AppDelegate.h"


@interface GalleryCVC ()



@property (nonatomic,retain) AppDelegate *appDelegate;
@property (strong, nonatomic) UIActivityIndicatorView * indicator;
@property (nonatomic, assign) CGFloat localProgress;
@property (nonatomic, assign) CGFloat progress;
@property BOOL check;
@property (strong, nonatomic) UILabel *textLabel;
@property (strong, nonatomic) NSTimer * timer;
@property (strong, nonatomic) UICollectionView * collectionView;
@property (strong, nonatomic) NSMutableArray * itemArray;
@property (strong, nonatomic) NSMutableArray *tempItemArray;
@property (strong, nonatomic) NSMutableArray * cellsArray;
@property (strong, nonatomic) NSMutableArray *firstTitlesArray;
@property (strong, nonatomic) NSMutableArray *secondTitlesArray;



@end

@implementation GalleryCVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.appDelegate = [[UIApplication sharedApplication] delegate];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self setView];
    [self setDate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    //[self removePhotoFromGallary];
}

-(void) setView
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1];
    [self.navigationController.navigationBar setTitleTextAttributes: @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.indicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    self.indicator.layer.cornerRadius = 05;
    self.indicator.opaque = NO;
    self.indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    [self.indicator setColor:[UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1]];
    [self.view addSubview:self.indicator];
    [self.indicator setCenter:self.collectionView.center];
    [self.indicator startAnimating];
}


-(void) setDate
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadVideoCell:) name:@"reloadVideoCell" object:nil];
    [FCFileManager createDirectoriesForPath:[[FCFileManager pathForDocumentsDirectory] stringByAppendingString:@"/album"]];
    self.itemArray = [NSMutableArray new];
    self.tempItemArray = [NSMutableArray new];
    self.cellsArray = [[NSMutableArray alloc] init];
    [self performSelector:@selector(setGallery) withObject:nil afterDelay:0.3];
}

-(void)reloadVideoCell:(NSNotification *)userData
{
    NSMutableDictionary * dict = [userData valueForKey:@"userInfo"];
    NSMutableDictionary * removeDict = [dict valueForKey:@"removeObj"];
    NSMutableDictionary * addedDict = [dict valueForKey:@"saveObj"];
    
    if ([[dict valueForKey:@"save"] isEqualToNumber:[NSNumber numberWithBool:YES]]) {
        for (int i = 0; i < self.itemArray.count; i++) {
            NSMutableDictionary * curDict = [self.itemArray objectAtIndex:i];
            if ([[curDict valueForKey:@"fileName"] isEqualToString:[addedDict valueForKey:@"fileName"]]) {
                [self.itemArray replaceObjectAtIndex:i withObject:addedDict];
                [self.collectionView reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:i inSection:0]]];
                break;
            }
        }
        
        for (int i = 0; i < self.tempItemArray.count; i++) {
            NSMutableDictionary * curDict = [self.tempItemArray objectAtIndex:i];
            if ([[curDict valueForKey:@"fileName"] isEqualToString:[addedDict valueForKey:@"fileName"]]) {
                [self.tempItemArray replaceObjectAtIndex:i withObject:addedDict];
                break;
            }
        }
        
    }
    
    if ([[dict valueForKey:@"remove"] isEqualToNumber:[NSNumber numberWithBool:YES]]) {
        for (int i = 0; i < self.itemArray.count; i++) {
            NSMutableDictionary * curDict = [self.itemArray objectAtIndex:i];
            if ([[curDict valueForKey:@"fileName"] isEqualToString:[removeDict valueForKey:@"fileName"]]) {
                [self.itemArray removeObjectAtIndex:i];
                [self.collectionView deleteItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:i inSection:0]]];
                break;
            }
        }
        
        for (int i = 0; i < self.tempItemArray.count; i++) {
            NSMutableDictionary * curDict = [self.tempItemArray objectAtIndex:i];
            if ([[curDict valueForKey:@"fileName"] isEqualToString:[removeDict valueForKey:@"fileName"]]) {
                [self.tempItemArray removeObjectAtIndex:i];
                break;
            }
        }
    }
}


-(void) setGallery
{
    if ([self.appDelegate isConnected]) {
        [[CameraManager cameraManager] getAllFileName];
        [[CameraManager cameraManager] getFileInCamera];
        [self listFileAtPath];
    }
    else
    {
        [self listFileAtPath];
    }
}

-(void)listFileAtPath {
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        int count;
        NSArray *directoryContent = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[[FCFileManager pathForDocumentsDirectory] stringByAppendingString:@"/album"] error:NULL];
        for (count = 0; count < (int)[directoryContent count]; count++)
        {
            NSString * fileName = [directoryContent objectAtIndex:count];
            NSDictionary *fileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:[[[FCFileManager pathForDocumentsDirectory] stringByAppendingString:@"/album/"] stringByAppendingString:fileName] error:nil];
            NSNumber * fileSize = [fileAttributes objectForKey:NSFileSize];
            NSDate *fileDate = [[[NSFileManager defaultManager] attributesOfItemAtPath:[[[FCFileManager pathForDocumentsDirectory] stringByAppendingString:@"/album/"] stringByAppendingString:fileName] error:nil] fileCreationDate];
            NSURL * fileURL = [NSURL fileURLWithPath:[[[FCFileManager pathForDocumentsDirectory] stringByAppendingString:@"/album/"] stringByAppendingString:fileName]];
            NSString *resourceName = [[[FCFileManager pathForDocumentsDirectory] stringByAppendingString:@"/album/"] stringByAppendingString:fileName];
            NSURL *URL = [NSURL fileURLWithPath:resourceName];
            AVURLAsset *avUrl = [AVURLAsset assetWithURL:URL];
            CMTime time = [avUrl duration];
            int fileTime = ceil(time.value/time.timescale);
            
            if ([fileName rangeOfString:@"jpg"].location != NSNotFound) {
                UIImage * originImage =  [UIImage imageWithData:[NSData dataWithContentsOfURL:fileURL]];
                UIImage * resizeImage;
                if ([originImage isKindOfClass:[UIImage class]]) {
                    resizeImage = [self resizeImage:originImage withMaxDimension:150];
                    NSMutableDictionary *curDict = [NSMutableDictionary dictionaryWithDictionary:@{@"fileName":fileName,@"image":@"YES", @"fileSize":fileSize, @"fileDate":fileDate, @"fileURL":fileURL ,@"fileImage":resizeImage}];
                    [self.itemArray addObject:curDict];
                    [self.tempItemArray addObject:curDict];
                }
            }
            if ([fileName rangeOfString:@"thm"].location != NSNotFound) {
                NSMutableDictionary * curDict = [NSMutableDictionary new];
                if (![fileSize isEqualToNumber:[NSNumber numberWithLong:0]]) {
                   UIImage * videoImage = [self vidImage:fileURL];
                    [curDict setValue:videoImage forKey:@"videoImage"];
                }
                [curDict setValue:fileName forKey:@"fileName"];
                [curDict setValue:fileSize forKey:@"fileSize"];
                [curDict setValue:fileDate forKey:@"fileDate"];
                [curDict setValue:fileURL forKey:@"fileURL"];
                [curDict setValue:[NSNumber numberWithInt:fileTime] forKey:@"fileTime"];
                [self.itemArray addObject:curDict];
                [self.tempItemArray addObject:curDict];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
            [self.indicator stopAnimating];
        });
    });
}


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

- (UIImage *)resizeImage:(UIImage *)image
        withMaxDimension:(CGFloat)maxDimension
{
    if (fmax(image.size.width, image.size.height) <= maxDimension) {
        return image;
    }
    CGFloat aspect = image.size.width / image.size.height;
    CGSize newSize;
    if (image.size.width > image.size.height) {
        newSize = CGSizeMake(maxDimension, maxDimension / aspect);
    } else {
        newSize = CGSizeMake(maxDimension * aspect, maxDimension);
    }
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 1.0);
    CGRect newImageRect = CGRectMake(0.0, 0.0, newSize.width, newSize.height);
    [image drawInRect:newImageRect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

-(void) removePhotoFromGallary
{
    NSMutableArray* array = [NSMutableArray new];
    for (NSMutableArray * obj in self.itemArray)
    {
        NSString * string = [NSString stringWithFormat:@"/album/%@", [obj valueForKey:@"fileName"]];
        NSString* path = [[FCFileManager pathForDocumentsDirectory] stringByAppendingString:string];
        if ([FCFileManager existsItemAtPath:path]) {
            [array addObject:obj];
        }
    }
    [self.itemArray removeAllObjects];
    [self.itemArray addObjectsFromArray:array];
    [self.collectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.itemArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary * curImage = [self.itemArray objectAtIndex:indexPath.row];
    GalleryCell * cell;
    if ([[curImage valueForKey:@"image"] isEqualToString:@"YES"]) {
        cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"CellPhoto" forIndexPath:indexPath];
        cell.imageViewCell.image = [curImage valueForKey:@"fileImage"];
    }
    else
    {
        cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"CellVideo" forIndexPath:indexPath];
        cell.videoName.text = [curImage valueForKey:@"fileName"];
        if ([[curImage valueForKey:@"videoImage"] isKindOfClass:[UIImage class]]) {
            cell.imageViewCell.image = [curImage valueForKey:@"videoImage"];
        }
        else
        {
            cell.imageViewCell.image = nil;
            [cell.imageViewCell setBackgroundColor:[UIColor colorWithRed:72.0/255.0 green:216.0/255.0 blue:183.0/255.0 alpha:1]];
        }
    }
    cell.layer.shouldRasterize = YES;
    cell.layer.rasterizationScale = [UIScreen mainScreen].scale;
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary * curObject = [self.itemArray objectAtIndex:indexPath.row];
    
    if ([[curObject valueForKey:@"image"] isEqualToString:@"YES"]) {
        PhotoVC* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"PhotoVC"];
        NSString* string = [curObject valueForKey:@"fileName"];
        vc.namePhoto = string;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        VideoVC* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"VideoVC"];
        if (![[curObject valueForKey:@"fileSize"] isEqualToNumber:[NSNumber numberWithLong:0]]) {
            vc.curObject = curObject;
            vc.localVideo = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
        else
        {
            if ([self.appDelegate isConnected]) {
                vc.curObject = curObject;
                vc.localVideo = NO;
                [self.navigationController pushViewController:vc animated:YES];
            }
            else
            {
                [self alertNoInternetConnection];
            }
        }
    }
}

-(void) alertNoInternetConnection
{
    UIAlertView *subAlert = [[UIAlertView alloc] initWithTitle:@""
                                                       message:@"Connection fail. Check on WiFi settings and try to connect again."
                                                      delegate:self
                                             cancelButtonTitle:@"Close"
                                             otherButtonTitles:nil];
    [subAlert show];
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(106, 106);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (IBAction)back:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"getToken" object:nil];
}

#pragma mark - SortData

-(NSMutableArray*) sortedArrayByDate:(NSMutableArray*)array
{
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"fileDate" ascending:NO];
    NSMutableArray *descriptors = [NSMutableArray arrayWithObject:descriptor];
    NSArray *reverseOrder = [array sortedArrayUsingDescriptors:descriptors];
    [self.itemArray removeAllObjects];
    [self.itemArray addObjectsFromArray:reverseOrder];
    return self.itemArray;
}

-(NSMutableArray*)sortedArrayBySize:(NSMutableArray*)array
{
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"fileSize" ascending:YES];
    NSMutableArray *descriptors = [NSMutableArray arrayWithObject:descriptor];
    NSArray *reverseOrder = [array sortedArrayUsingDescriptors:descriptors];
    [self.itemArray removeAllObjects];
    [self.itemArray addObjectsFromArray:reverseOrder];
    return self.itemArray;
}

-(NSMutableArray*)sortedArrayByPhoto
{
    NSMutableArray* temp = [NSMutableArray new];
    [temp addObjectsFromArray:self.tempItemArray];
    [self.itemArray removeAllObjects];
    for (NSMutableArray* obj in temp) {
        if ([[obj valueForKey:@"image"] isEqualToString:@"YES"]){
            [self.itemArray addObject:obj];
        }
    }
    return self.itemArray;
}

-(NSMutableArray*)sortedArrayByVideo
{
    NSMutableArray* temp = [NSMutableArray new];
    [temp addObjectsFromArray:self.tempItemArray];
    [self.itemArray removeAllObjects];
    for (NSMutableArray* obj in temp) {
        if (![[obj valueForKey:@"image"] isEqualToString:@"YES"]){
            [self.itemArray addObject:obj];
        }
    }
    return self.itemArray;
}


#pragma mark - Actions

- (IBAction)backFirstButton:(UIButton *)sender {
    
    if ([self.firstGallaryLabel.text isEqualToString:@"All"]) {
        self.firstGallaryLabel.text = @"Photo";
        
        [self sortedArrayByPhoto];
        
    }else if ([self.firstGallaryLabel.text isEqualToString:@"Photo"]){
        self.firstGallaryLabel.text = @"Video";
        
        [self sortedArrayByVideo];
        
        
    }else if ([self.firstGallaryLabel.text isEqualToString:@"Video"]) {
        self.firstGallaryLabel.text = @"All";
        
        [self.itemArray removeAllObjects];
        [self.itemArray addObjectsFromArray:self.tempItemArray];
    }
    [self.collectionView reloadData];
}

- (IBAction)forwardFirstButton:(UIButton *)sender {
    
    if ([self.firstGallaryLabel.text isEqualToString:@"All"]) {
        self.firstGallaryLabel.text = @"Video";
        
         [self sortedArrayByVideo];
        
    }else if ([self.firstGallaryLabel.text isEqualToString:@"Video"]){
        self.firstGallaryLabel.text = @"Photo";
        
         [self sortedArrayByPhoto];
        
    }else if ([self.firstGallaryLabel.text isEqualToString:@"Photo"]) {
        self.firstGallaryLabel.text = @"All";
        
        [self.itemArray removeAllObjects];
        [self.itemArray addObjectsFromArray:self.tempItemArray];
    }
  [self.collectionView reloadData];
}

- (IBAction)backSecondButton:(UIButton *)sender {
    
    if ([self.secondGallaryLabel.text isEqualToString:@"By Date"]) {
        self.secondGallaryLabel.text = @"By Size";
        
         [self sortedArrayBySize:self.itemArray];
       
    }else if ([self.secondGallaryLabel.text isEqualToString:@"By Size"]) {
        self.secondGallaryLabel.text = @"By Date";
        
        [self sortedArrayByDate:self.itemArray];
    }
    
    [self.collectionView reloadData];
}

- (IBAction)forwardSecondButton:(UIButton *)sender {
   
    if ([self.secondGallaryLabel.text isEqualToString:@"By Date"]) {
        self.secondGallaryLabel.text = @"By Size";
        
         [self sortedArrayBySize:self.itemArray];
        
    }else if ([self.secondGallaryLabel.text isEqualToString:@"By Size"]){
        self.secondGallaryLabel.text = @"By Date";
        
        [self sortedArrayByDate:self.itemArray];
    }
    
    [self.collectionView reloadData];
}
@end
