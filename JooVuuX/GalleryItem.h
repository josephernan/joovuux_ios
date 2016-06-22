//
//  GalleryItem.h
//  JooVuuX
//
//  Created by Andrey on 23.06.15.
//  Copyright (c) 2015 lsoft. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GalleryItem : NSObject

@property (nonatomic) NSInteger fileTime;
@property (strong, nonatomic) NSNumber * fileSize;
@property (strong, nonatomic) NSString * fileName;
@property (strong, nonatomic) NSDate *fileDate;
@property (strong, nonatomic) NSURL *fileURL;

@end
