//
//  ModeSettings.h
//  JooVuuX
//
//  Created by Andrey on 19.06.15.
//  Copyright (c) 2015 lsoft. All rights reserved.
//

#import <Foundation/Foundation.h>




@interface ModeSettings : NSObject
{

}
@property (strong, nonatomic) NSMutableArray * videoResolutions;
@property (strong, nonatomic) NSMutableArray * videoBitRates;
@property (strong, nonatomic) NSMutableArray * videoClipLenght;
@property (strong, nonatomic) NSMutableArray * wdrData;
@property (strong, nonatomic) NSMutableArray * fieldOfView;
@property (strong, nonatomic) NSMutableArray * timeLapseVideo;
@property (strong, nonatomic) NSMutableArray * artificialLightFrequency;
@property (strong, nonatomic) NSMutableArray * modeTimeSpecific;
@property (strong, nonatomic) NSMutableArray * burstPhotoMode;
@property (strong, nonatomic) NSMutableArray * photoResolution;


@end
