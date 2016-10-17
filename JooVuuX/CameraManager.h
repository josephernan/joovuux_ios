//
//  CameraManager.h
//  JooVuuX
//
//  Created by Andrey on 08.07.15.
//  Copyright (c) 2015 lsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FastSocket.h"
#import "StreamVC.h"

//NSString *CAMERA_IP_ADDR = @"192.168.42.1";

@interface CameraManager : NSObject 
{
    long count;

}

@property (strong, nonatomic) NSTimer * timer;

@property BOOL checkToken;
@property BOOL checkFirstToken;
@property BOOL record;
@property (nonatomic) int progress;
@property (nonatomic) int imageCount;
@property BOOL newFile;
@property (strong, nonatomic) FastSocket * socket;
@property (strong, nonatomic) FastSocket * fileSocket;
@property (strong, nonatomic) NSString * token;
@property (strong, nonatomic) StreamVC * strem;
@property (strong, nonatomic)  NSMutableArray * imageName;
@property (strong, nonatomic)  NSMutableArray * movieName;
@property (strong, nonatomic) NSMutableDictionary * dict;
@property (nonatomic) int byteCount;
@property (strong, nonatomic) NSString * videoResolution;
@property (strong, nonatomic) NSString * audio;
@property (strong, nonatomic) NSString * rotate;
@property (strong, nonatomic) NSString * videoBit;
@property (strong, nonatomic) NSString * videoClip;
@property (strong, nonatomic) NSString * WDR;
@property (strong, nonatomic) NSString * fieldOfView;
@property (strong, nonatomic) NSString * defaultMode;

@property (strong, nonatomic) NSMutableDictionary * allSettingsDict;
@property (strong, nonatomic) NSString * cameraFW;

+(CameraManager *) cameraManager;
-(FastSocket *) createSocket;
-(NSString *)getToken;
-(void) getCameraFW;
-(void) startStreaming;
-(void) startRecording;
-(void) stopRecording;
-(void) takePhoto;
-(void) getAllFileName;
-(int) getInCameraFile:(NSString *)fileName;
-(void) params:(NSString *)param type:(NSString*)type;
-(void) paramsNoGlobal:(NSString *)param type:(NSString*)type;
-(void) setStreamParams:(NSString*)param type:(NSString*)type;
-(void) getFileInCamera;

-(void) downloadVideoFromName:(NSString *)name;
-(void) closeStream;

-(void) getSettingsFromCamera;

-(void) formatSD:(NSString *)param;

-(NSString*) getCameraTime;
-(NSString*) paramsInfoVideoResolution:(NSString*)type;
-(NSString*) paramsInfoAudio:(NSString*)type;
-(NSString*) paramsInfoRotate:(NSString*)type;
-(NSString*) paramsInfoBitRate:(NSString*)type;
-(NSString*) paramsInfoVideoClip:(NSString*)type;
-(NSString*) paramsInfoWDR:(NSString*)type;
-(NSString*) paramsInfoFieldOfView:(NSString*)type;
-(NSString*)paramsInfoDefaultMode:(NSString*)type;


-(void) resetAllSettings:(NSString *)param type:(NSString*)type;

-(void) deleteFileFromCamera:(NSString *)param;

-(void) deleteToken;

-(void) getNewToken;

-(void) resetAllSettings;
-(void) cameraRecording;
-(void) startTimerRecording;
-(void) stopTimerRecording;
@end
