    
//  CameraManager.m
//  JooVuuX
//
//  Created by Andrey on 08.07.15.
//  Copyright (c) 2015 lsoft. All rights reserved.
//

#import "CameraManager.h"
#import "VideoGalleryObject.h"
#import <FCFileManager.h>
@implementation CameraManager

+(CameraManager *) cameraManager
{
    static CameraManager * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
         manager = [[CameraManager alloc] init];
    });
    return manager;
}

-(FastSocket *)createSocket
{

    if ([self.socket isConnected])
    {
       return self.socket;
    }
    else
    {
        self.socket = [[FastSocket alloc] initWithHost:@"192.168.42.1" andPort:@"7878"];
        [self.socket connect:1];
        return self.socket;
    }
}

-(FastSocket *)createSocketFromReciveFile
{
    if ([self.fileSocket isConnected])
    {
        return self.fileSocket;
    }
    else
    {
        self.fileSocket = [[FastSocket alloc] initWithHost:@"192.168.42.1" andPort:@"8787"];
        [self.fileSocket connect];
        return self.fileSocket;
    }
}

-(NSString *) getToken {
    self.checkFirstToken = YES;
    if (!self.token)
    {
        NSString * message = @"{\"token\":0,\"msg_id\":257}";
        NSData *data = [message dataUsingEncoding:NSUTF8StringEncoding];
        NSLog(@"Get token -  %@\n", message);
        [self.socket setTimeout:1];
        [[self createSocket] sendBytes:[data bytes] count:[data length]];
        char bytes[1024];
        count = [[self createSocket] receiveBytes:bytes count:1024];
        NSString *received = [[NSString alloc] initWithBytes:bytes length:count encoding:NSUTF8StringEncoding];
        NSLog(@"Get token recive  -  %@\n", received);
        
        NSData *jsonData = [received dataUsingEncoding:NSUTF8StringEncoding];
        if (jsonData) {
            id json = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
            if (![json objectForKey:@"param"]) {
                self.checkToken = NO;
                return nil;
            }
            else
            {
                self.token = [json objectForKey:@"param"];
                self.checkToken = YES;
                NSLog(@"TOKEN = %@\n", [json objectForKey:@"param"]);
                return self.token;
            }
        }
        else
        {
            self.checkToken = NO;
           return nil;
        }
    }
    else
    {
        return self.token;
    }
    
}

-(void)getSettingsFromCamera
{
    NSMutableArray * settingsArray = [NSMutableArray new];
    self.allSettingsDict = [NSMutableDictionary new];
    NSString * set1 = [NSString stringWithFormat:@"{\"token\":%@,\"msg_id\":1794}" , [self getToken]];
    NSData *data1 = [set1 dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"get settings  -  %@\n", set1);
    [[self createSocket] sendBytes:[data1 bytes] count:[data1 length]];
    char bytes1[1024];
    count = [[self createSocket] receiveBytes:bytes1 count:1024];
    NSArray *jsonObject1 = [NSJSONSerialization JSONObjectWithData:[NSData dataWithBytes:bytes1 length:count] options:0 error:NULL];
    NSLog(@"recive settings  -  %@\n",jsonObject1);
    [settingsArray addObjectsFromArray:[jsonObject1 valueForKey:@"param"]];

    NSString * set2 = [NSString stringWithFormat:@"{\"token\":%@,\"msg_id\":1795}" , [self getToken]];
    NSData *data2 = [set2 dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"get settings  -  %@\n", set2);
    [[self createSocket] sendBytes:[data2 bytes] count:[data2 length]];
    char bytes2[1024];
    count = [[self createSocket] receiveBytes:bytes2 count:1024];
    NSArray *jsonObject2 = [NSJSONSerialization JSONObjectWithData:[NSData dataWithBytes:bytes2 length:count] options:0 error:NULL];
    NSLog(@"recive settings  -  %@\n",jsonObject2);
    [settingsArray addObjectsFromArray:[jsonObject2 valueForKey:@"param"]];
    [self.allSettingsDict setValue:settingsArray forKey:@"mainSettings"];
    
    NSString * set3 = [NSString stringWithFormat:@"{\"token\":%@,\"msg_id\":1796}" , [self getToken]];
    NSData *data3 = [set3 dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"get settings  -  %@\n", set3);
    [[self createSocket] sendBytes:[data3 bytes] count:[data3 length]];
    char bytes3[1024];
    count = [[self createSocket] receiveBytes:bytes3 count:1024];
    NSArray *jsonObject3 = [NSJSONSerialization JSONObjectWithData:[NSData dataWithBytes:bytes3 length:count] options:0 error:NULL];
    NSLog(@"recive settings  -  %@\n",jsonObject3);
    NSArray * jsonDict3 = [jsonObject3 valueForKey:@"param"];
    [self.allSettingsDict setValue:jsonDict3 forKey:@"modeOne"];
    
    NSString * set4 = [NSString stringWithFormat:@"{\"token\":%@,\"msg_id\":1797}" , [self getToken]];
    NSData *data4 = [set4 dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"get settings  -  %@\n", set4);
    [[self createSocket] sendBytes:[data4 bytes] count:[data4 length]];
    char bytes4[1024];
    count = [[self createSocket] receiveBytes:bytes4 count:1024];
    NSArray *jsonObject4 = [NSJSONSerialization JSONObjectWithData:[NSData dataWithBytes:bytes4 length:count] options:0 error:NULL];
    NSLog(@"recive settings  -  %@\n",jsonObject4);
    NSArray * jsonDict4 = [jsonObject4 valueForKey:@"param"];
    [self.allSettingsDict setValue:jsonDict4 forKey:@"modeTwo"];
}


-(void)getNewToken {
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        [self.socket setTimeout:2];
        NSString * message = @"{\"token\":0,\"msg_id\":257}";
        NSData *data = [message dataUsingEncoding:NSUTF8StringEncoding];
        NSLog(@"Запрос на получение токена  -  %@\n", message);
        [[self createSocket] sendBytes:[data bytes] count:[data length]];
        char bytes[1024];
        count = [[self createSocket] receiveBytes:bytes count:1024];
        NSString *received = [[NSString alloc] initWithBytes:bytes length:count encoding:NSUTF8StringEncoding];
        NSLog(@"Ответ на получение токена  -  %@\n", received);
        
        NSData *jsonData = [received dataUsingEncoding:NSUTF8StringEncoding];
        
        id json = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
        self.token = [json objectForKey:@"param"];
        NSLog(@"TOKEN = %@\n", [json objectForKey:@"param"]);
        
    });
}


-(void) getCameraFW
{
    NSString * message = [NSString stringWithFormat:@"{\"msg_id\":1,\"token\":%@,\"type\":\"fw_version\"}", [self getToken]];
    NSData *data = [message dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"Запрос на получение токена  -  %@\n", message);
    [[self createSocket] sendBytes:[data bytes] count:[data length]];
    char bytes[1024];
    count = [[self createSocket] receiveBytes:bytes count:1024];
    
    NSArray *jsonObject = [NSJSONSerialization JSONObjectWithData:[NSData dataWithBytes:bytes length:count] options:0 error:NULL];
    NSLog(@"Ответ 6  -  %@\n",jsonObject);
    NSString *received = [jsonObject valueForKey:@"param"];
    self.cameraFW = received;
}


-(void) startStreaming
{
    NSString * messageOne = [NSString stringWithFormat:@"{\"msg_id\":260,\"token\":%@}", [self getToken]];
    NSLog(@"Запрос на отключение стрима  -  %@\n", messageOne);
    NSData *dataOne = [messageOne dataUsingEncoding:NSUTF8StringEncoding];
    [[self createSocket] sendBytes:[dataOne bytes] count:[dataOne length]];
    char bytesOne[1024];
    count = [[self createSocket] receiveBytes:bytesOne count:1024];
    NSString *receivedOne = [[NSString alloc] initWithBytes:bytesOne length:count encoding:NSUTF8StringEncoding];
    NSLog(@"Ответ на отключение стрима  -  %@\n", receivedOne);
    
    NSString * messageTwo = [NSString stringWithFormat:@"{\"token\":%@,\"msg_id\":2,\"type\":\"save_low_resolution_clip\",\"param\":\"on\"}", [self getToken]];
    NSLog(@"Запрос Save-low-resolution-clip  -  %@\n", messageTwo);
    NSData *dataTwo = [messageTwo dataUsingEncoding:NSUTF8StringEncoding];
    [[self createSocket] sendBytes:[dataTwo bytes] count:[dataTwo length]];
    char bytesTwo[1024];
    count = [[self createSocket] receiveBytes:bytesTwo count:1024];
    NSString *receivedTwo = [[NSString alloc] initWithBytes:bytesTwo length:count encoding:NSUTF8StringEncoding];
    NSLog(@"Ответ Save-low-resolution-clip  -  %@\n", receivedTwo);
    
    NSString * messageThree = [NSString stringWithFormat:@"{\"token\":%@,\"msg_id\":2,\"type\":\"stream_out_type\",\"param\":\"rtsp\"}" , [self getToken]];
    NSLog(@"Запрос на включение стрима  -  %@\n", messageThree);
    NSData *dataThree = [messageThree dataUsingEncoding:NSUTF8StringEncoding];
    [[self createSocket] sendBytes:[dataThree bytes] count:[dataThree length]];
    char bytesThree[1024];
    count = [[self createSocket] receiveBytes:bytesThree count:1024];
    NSString *receivedThree = [[NSString alloc] initWithBytes:bytesThree length:count encoding:NSUTF8StringEncoding];
    NSLog(@"Ответ на запрос включение стрима  -  %@\n", receivedThree);
    
    NSString * messageFour = [NSString stringWithFormat:@"{\"token\":%@,\"msg_id\":259}" , [self getToken]];
    NSLog(@"Запрос на перезагрузку стрима  -  %@\n", messageFour);
    NSData *dataFour = [messageFour dataUsingEncoding:NSUTF8StringEncoding];
    [[self createSocket] sendBytes:[dataFour bytes] count:[dataFour length]];
    char bytesFour[1024];
    count = [[self createSocket] receiveBytes:bytesFour count:1024];
    NSString *receivedFour = [[NSString alloc] initWithBytes:bytesFour length:count encoding:NSUTF8StringEncoding];
    NSLog(@"Ответ на запрос перезагрузки стрима  -  %@\n", receivedFour);
    
    [NSTimer scheduledTimerWithTimeInterval:0.1
                                     target:self
                                   selector:@selector(startStream)
                                   userInfo:nil
                                    repeats:NO];
}

-(void) startStream {
    [self.strem startStreaming];
}



-(void) startRecording
{
    NSString * message = [NSString stringWithFormat:@"{\"token\":%@,\"msg_id\":513}" , [self getToken]];
    NSLog(@"Запрос на старт записи видео  -  %@\n", message);
    NSData *data = [message dataUsingEncoding:NSUTF8StringEncoding];
    [[self createSocket] sendBytes:[data bytes] count:[data length]];
    char bytes[1024];
    count = [[self createSocket] receiveBytes:bytes count:1024];
    NSString *received = [[NSString alloc] initWithBytes:bytes length:count encoding:NSUTF8StringEncoding];
    NSLog(@"Ответ на старт записи видео  -  %@\n", received);
    
    NSString * message1 = [NSString stringWithFormat:@"{\"token\":%@,\"msg_id\":515}" , [self getToken]];
    NSLog(@"Запрос на получение времени -  %@\n", message1);
    NSData *data1 = [message1 dataUsingEncoding:NSUTF8StringEncoding];
    [[self createSocket] sendBytes:[data1 bytes] count:[data1 length]];
    char bytes1[1024];
    count = [[self createSocket] receiveBytes:bytes1 count:1024];
    NSString *received1 = [[NSString alloc] initWithBytes:bytes1 length:count encoding:NSUTF8StringEncoding];
    NSLog(@"Ответ на получение времени  -  %@\n", received1);

}

-(void) stopRecording
{
    NSString * messageFour = [NSString stringWithFormat:@"{\"token\":%@,\"msg_id\":514}" , [self getToken]];
    NSLog(@"Запрос на стоп записи видео  -  %@\n", messageFour);
    NSData *dataFour = [messageFour dataUsingEncoding:NSUTF8StringEncoding];
    [[self createSocket] sendBytes:[dataFour bytes] count:[dataFour length]];
    char bytesFour[1024];
    count = [[self createSocket] receiveBytes:bytesFour count:1024];
    NSString *receivedFour = [[NSString alloc] initWithBytes:bytesFour length:count encoding:NSUTF8StringEncoding];
    NSLog(@"Ответ на стоп записи видео  -  %@\n", receivedFour);
}

-(void) takePhoto
{
    NSString * messageFour = [NSString stringWithFormat:@"{\"token\":%@,\"msg_id\":769}" , [self getToken]];
    NSLog(@"Запрос на takePhoto  -  %@\n", messageFour);
    NSData *dataFour = [messageFour dataUsingEncoding:NSUTF8StringEncoding];
    [[self createSocket] sendBytes:[dataFour bytes] count:[dataFour length]];
    char bytesFour[1024];
    count = [[self createSocket] receiveBytes:bytesFour count:1024];
    NSString *receivedFour = [[NSString alloc] initWithBytes:bytesFour length:count encoding:NSUTF8StringEncoding];
    NSLog(@"Ответ на takePhoto  -  %@\n", receivedFour);

}

-(void) getAllFileName
{
     NSString * message = [NSString stringWithFormat:@"{\"token\":%@,\"msg_id\":1284}" , [self getToken]];
     NSData *data = [message dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"Запрос 1  -  %@\n", message);
    [[self createSocket] sendBytes:[data bytes] count:[data length]];
    char bytes[1024];
    count = [[self createSocket] receiveBytes:bytes count:1024];
    NSString *received = [[NSString alloc] initWithBytes:bytes length:count encoding:NSUTF8StringEncoding];
    NSLog(@"Ответ 1  -  %@\n", received);
    
    
    
    NSString * message1 = [NSString stringWithFormat:@"{\"token\":%@,\"msg_id\":1283, \"param\":\"/tmp/fuse_d/DCIM/\"}" , [self getToken]];
    NSData *data1 = [message1 dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"Запрос 2  -  %@\n", message1);
    [[self createSocket] sendBytes:[data1 bytes] count:[data1 length]];
    char bytes1[1024];
    count = [[self createSocket] receiveBytes:bytes1 count:1024];
    NSString *received1 = [[NSString alloc] initWithBytes:bytes1 length:count encoding:NSUTF8StringEncoding];
    NSLog(@"Ответ 2  -  %@\n", received1);
    
    
    NSString * message2 = [NSString stringWithFormat:@"{\"token\":%@,\"msg_id\":1282, \"param\":\"-D -S\"}" , [self getToken]];
    NSData *data2 = [message2 dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"Запрос 3  -  %@\n", message2);
    [[self createSocket] sendBytes:[data2 bytes] count:[data2 length]];
    char bytes2[1024];
    count = [[self createSocket] receiveBytes:bytes2 count:1024];
    NSString *received2 = [[NSString alloc] initWithBytes:bytes2 length:count encoding:NSUTF8StringEncoding];
    NSLog(@"Ответ 3  -  %@\n", received2);
    
    
    NSString * message3 = [NSString stringWithFormat:@"{\"token\":%@,\"msg_id\":1284}" , [self getToken]];
    NSData *data3 = [message3 dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"Запрос 4  -  %@\n", message3);
    [[self createSocket] sendBytes:[data3 bytes] count:[data3 length]];
    char bytes3[1024];
    count = [[self createSocket] receiveBytes:bytes3 count:1024];
    NSString *received3 = [[NSString alloc] initWithBytes:bytes3 length:count encoding:NSUTF8StringEncoding];
    NSLog(@"Ответ 4  -  %@\n", received3);
    
    
    NSString * message4 = [NSString stringWithFormat:@"{\"token\":%@,\"msg_id\":1283, \"param\":\"/tmp/fuse_d/DCIM/100MEDIA/\"}" , [self getToken]];
    NSData *data4 = [message4 dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"Запрос 5  -  %@\n", message4);
    [[self createSocket] sendBytes:[data4 bytes] count:[data4 length]];
    char bytes4[1024];
    count = [[self createSocket] receiveBytes:bytes4 count:1024];
    NSString *received4 = [[NSString alloc] initWithBytes:bytes4 length:count encoding:NSUTF8StringEncoding];
    NSLog(@"Ответ 5  -  %@\n", received4);
    
    
    NSString * message5 = [NSString stringWithFormat:@"{\"token\":%@,\"msg_id\":1282, \"param\":\"-D -S\"}" , [self getToken]];
    NSData *data5 = [message5 dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"Запрос 6  -  %@\n", message5);
    [self.socket setTimeout:5];
    [[self createSocket] sendBytes:[data5 bytes] count:[data5 length]];
    char bytes5[1024];
    count = [[self createSocket] receiveBytes:bytes5 count:400000000];

    NSArray *jsonObject = [NSJSONSerialization JSONObjectWithData:[NSData dataWithBytes:bytes5 length:count] options:0 error:NULL];
    NSLog(@"Ответ 6  -  %@\n",jsonObject);
    NSArray *jsonDict = [jsonObject valueForKey:@"listing"];
    NSLog(@"Ответ 6  -  %@\n",jsonDict);
    self.dict = [NSMutableDictionary new];
    for (int i = 0; i < jsonDict.count; i++) {
        [self.dict addEntriesFromDictionary:[jsonDict objectAtIndex:i]];
    }
    
    NSArray * allName = [self.dict allKeys];
    
    self.imageName = [NSMutableArray new];
    self.movieName = [NSMutableArray new];
    for (int i = 0; i < allName.count; i++)
    {
        NSString * string = [allName objectAtIndex:i];

        if ([string rangeOfString:@"jpg"].location != NSNotFound) {
            [self.imageName addObject:string];
        }
        if ([string rangeOfString:@"thm"].location != NSNotFound) {
            [self.movieName addObject:string];
        }
    }
    
    NSLog(@"%@", self.imageName);
    NSLog(@"%@", self.movieName);
    
    
    
    NSLog(@"Ответ 6  -  %@\n",self.dict);

    
}

-(void) params:(NSString *)param type:(NSString*)type
{
    if (self.checkToken) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"startActivity" object:nil];
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
            NSString * messageOne = [NSString stringWithFormat:@"{\"msg_id\":260,\"token\":%@}", [self getToken]];
            NSLog(@"Запрос на отключение стрима  -  %@\n", messageOne);
            NSData *dataOne = [messageOne dataUsingEncoding:NSUTF8StringEncoding];
            [[self createSocket] sendBytes:[dataOne bytes] count:[dataOne length]];
            char bytesOne[1024];
            count = [[self createSocket] receiveBytes:bytesOne count:1024];
            NSString *receivedOne = [[NSString alloc] initWithBytes:bytesOne length:count encoding:NSUTF8StringEncoding];
            NSLog(@"Ответ на отключение стрима  -  %@\n", receivedOne);
            
            NSString * message = [NSString stringWithFormat:@"{\"token\":%@,\"msg_id\":2, \"param\":\"%@\", \"type\":\"%@\"}" ,[self getToken] , param, type];
            NSData *data = [message dataUsingEncoding:NSUTF8StringEncoding];
            NSLog(@"Запрос 5  -  %@\n", message);
            [[self createSocket] sendBytes:[data bytes] count:[data length]];
            char bytes[1024];
            count = [[self createSocket] receiveBytes:bytes count:1024];
            NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:[NSData dataWithBytes:bytes length:count] options:0 error:NULL];
            
            NSString * str = [[jsonObject valueForKey:@"rval"] stringValue];
            dispatch_async(dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:@"stopActivity" object:nil];
                if (str.length > 0) {
                    if ([str isEqualToString:@"-21"]) {
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"camera21" object:nil];
                    }
                }
                else
                {
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"camera21" object:nil];
                }
                
            });
            
        });
    }
}

-(void) paramsNoGlobal:(NSString *)param type:(NSString*)type
{
    NSString * messageOne = [NSString stringWithFormat:@"{\"msg_id\":260,\"token\":%@}", [self getToken]];
    NSLog(@"Запрос 260  -  %@\n", messageOne);
    NSData *dataOne = [messageOne dataUsingEncoding:NSUTF8StringEncoding];
    [[self createSocket] sendBytes:[dataOne bytes] count:[dataOne length]];
    char bytesOne[1024];
    count = [[self createSocket] receiveBytes:bytesOne count:1024];
    NSString *receivedOne = [[NSString alloc] initWithBytes:bytesOne length:count encoding:NSUTF8StringEncoding];
    NSLog(@"Ответ 260  -  %@\n", receivedOne);
    
    NSString * message = [NSString stringWithFormat:@"{\"token\":%@,\"msg_id\":2, \"param\":\"%@\", \"type\":\"%@\"}" ,[self getToken] , param, type];
    NSData *data = [message dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"Запрос 2    -   %@\n", message);
    [[self createSocket] sendBytes:[data bytes] count:[data length]];
    char bytes[1024];
    count = [[self createSocket] receiveBytes:bytes count:1024];
    NSString *received = [[NSString alloc] initWithBytes:bytes length:count encoding:NSUTF8StringEncoding];
    NSLog(@"Ответ 2    -   %@\n",  received);
}

-(void) resetAllSettings:(NSString *)param type:(NSString*)type {
    
        NSString * message = [NSString stringWithFormat:@"{\"token\":%@,\"msg_id\":2, \"param\":\"%@\", \"type\":\"%@\"}" ,[self getToken] , param, type];
        NSData *data = [message dataUsingEncoding:NSUTF8StringEncoding];
        NSLog(@"Запрос 5  -  %@\n", message);
        [[self createSocket] sendBytes:[data bytes] count:[data length]];
        char bytes[1024];
        count = [[self createSocket] receiveBytes:bytes count:1024];
        NSString *received = [[NSString alloc] initWithBytes:bytes length:count encoding:NSUTF8StringEncoding];
        NSLog(@"Ответ 5  -  %@\n", received);
}

-(void) resetAllSettings
{
    NSString * message = [NSString stringWithFormat:@"{\"token\":%@,\"msg_id\":2, \"param\":\"YES\", \"type\":\"Reset all settings\"}" ,[self getToken]];
    NSData *data = [message dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"Запрос 5  -  %@\n", message);
    [[self createSocket] sendBytes:[data bytes] count:[data length]];
    char bytes[1024];
    count = [[self createSocket] receiveBytes:bytes count:1024];
    NSString *received = [[NSString alloc] initWithBytes:bytes length:count encoding:NSUTF8StringEncoding];
    NSLog(@"Ответ 5  -  %@\n", received);
}

-(void) setStreamParams:(NSString*)param type:(NSString*)type
{
    NSString * messageOne = [NSString stringWithFormat:@"{\"msg_id\":260,\"token\":%@}", [self getToken]];
    NSLog(@"Запрос на отключение стрима  -  %@\n", messageOne);
    NSData *dataOne = [messageOne dataUsingEncoding:NSUTF8StringEncoding];
    [[self createSocket] sendBytes:[dataOne bytes] count:[dataOne length]];
    char bytesOne[1024];
    count = [[self createSocket] receiveBytes:bytesOne count:1024];
    NSString *receivedOne = [[NSString alloc] initWithBytes:bytesOne length:count encoding:NSUTF8StringEncoding];
    NSLog(@"Ответ на отключение стрима  -  %@\n", receivedOne);
    
    NSString * message = [NSString stringWithFormat:@"{\"token\":%@,\"msg_id\":2, \"param\":\"%@\", \"type\":\"%@\"}" ,[self getToken] , param, type];
    NSData *data = [message dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"Запрос 5  -  %@\n", message);
    [[self createSocket] sendBytes:[data bytes] count:[data length]];
    char bytes[1024];
    count = [[self createSocket] receiveBytes:bytes count:1024];
    NSString *received = [[NSString alloc] initWithBytes:bytes length:count encoding:NSUTF8StringEncoding];
    NSLog(@"Ответ 5  -  %@\n", received);
    
    NSString * messageTwo = [NSString stringWithFormat:@"{\"token\":%@,\"msg_id\":2,\"type\":\"save_low_resolution_clip\",\"param\":\"on\"}", [self getToken]];
    NSLog(@"Запрос Save-low-resolution-clip  -  %@\n", messageTwo);
    NSData *dataTwo = [messageTwo dataUsingEncoding:NSUTF8StringEncoding];
    [[self createSocket] sendBytes:[dataTwo bytes] count:[dataTwo length]];
    char bytesTwo[1024];
    count = [[self createSocket] receiveBytes:bytesTwo count:1024];
    NSString *receivedTwo = [[NSString alloc] initWithBytes:bytesTwo length:count encoding:NSUTF8StringEncoding];
    NSLog(@"Ответ Save-low-resolution-clip  -  %@\n", receivedTwo);
    
    NSString * messageThree = [NSString stringWithFormat:@"{\"token\":%@,\"msg_id\":2,\"type\":\"stream_out_type\",\"param\":\"rtsp\"}" , [self getToken]];
    NSLog(@"Запрос на включение стрима  -  %@\n", messageThree);
    NSData *dataThree = [messageThree dataUsingEncoding:NSUTF8StringEncoding];
    [[self createSocket] sendBytes:[dataThree bytes] count:[dataThree length]];
    char bytesThree[1024];
    count = [[self createSocket] receiveBytes:bytesThree count:1024];
    NSString *receivedThree = [[NSString alloc] initWithBytes:bytesThree length:count encoding:NSUTF8StringEncoding];
    NSLog(@"Ответ на запрос включение стрима  -  %@\n", receivedThree);
    
    NSString * messageFour = [NSString stringWithFormat:@"{\"token\":%@,\"msg_id\":259}" , [self getToken]];
    NSLog(@"Запрос на перезагрузку стрима  -  %@\n", messageFour);
    NSData *dataFour = [messageFour dataUsingEncoding:NSUTF8StringEncoding];
    [[self createSocket] sendBytes:[dataFour bytes] count:[dataFour length]];
    char bytesFour[1024];
    count = [[self createSocket] receiveBytes:bytesFour count:1024];
    NSString *receivedFour = [[NSString alloc] initWithBytes:bytesFour length:count encoding:NSUTF8StringEncoding];
    NSLog(@"Ответ на запрос перезагрузки стрима  -  %@\n", receivedFour);
}



-(int) getInCameraFile:(NSString *)fileName
{
    NSString * message1 = [NSString stringWithFormat:@"{\"token\":%@,\"msg_id\":1285,\"param\":\"%@\", \"offset\":0,\"fetch_size\":0}" , [self getToken],fileName];
    NSData *data1 = [message1 dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"Запрос 2  -  %@\n", message1);    [[self createSocket] sendBytes:[data1 bytes] count:[data1 length]];
    char bytes[1024];
    count = [[self createSocket] receiveBytes:bytes count:1024];
    NSString *received = [[NSString alloc] initWithBytes:bytes length:count encoding:NSUTF8StringEncoding];
    NSLog(@"Ответ 5  -  %@\n", received);
    
    NSArray *jsonObject = [NSJSONSerialization JSONObjectWithData:[NSData dataWithBytes:bytes length:count] options:0 error:NULL];
    NSLog(@"Ответ 6  -  %@\n",jsonObject);
    NSArray * jsonDict = [jsonObject valueForKey:@"rem_size"];
    NSLog(@"Ответ 6  -  %@\n",jsonDict);
    return [[jsonObject valueForKey:@"rem_size"] intValue];
}


-(void) closeStream
{
    NSString * messageOne = [NSString stringWithFormat:@"{\"msg_id\":260,\"token\":%@}", [self getToken]];
    NSLog(@"Запрос на отключение стрима  -  %@\n", messageOne);
    NSData *dataOne = [messageOne dataUsingEncoding:NSUTF8StringEncoding];
    [[self createSocket] sendBytes:[dataOne bytes] count:[dataOne length]];
    char bytesOne[1024];
    count = [[self createSocket] receiveBytes:bytesOne count:1024];
    NSString *receivedOne = [[NSString alloc] initWithBytes:bytesOne length:count encoding:NSUTF8StringEncoding];
    NSLog(@"Ответ на отключение стрима  -  %@\n", receivedOne);
}

-(void) getFileInCamera
{
    self.imageCount = self.imageName.count;
    self.progress = 0;
    
    for (int i = 0 ; i < self.movieName.count; i++) {
        NSString * movieName = [self.movieName objectAtIndex:i];
        [FCFileManager createDirectoriesForPath:[[FCFileManager pathForDocumentsDirectory] stringByAppendingString:@"/album"]];
        NSString *path = [[[FCFileManager pathForDocumentsDirectory] stringByAppendingString:@"/album/"] stringByAppendingString:movieName];
        BOOL testFileExists = [FCFileManager existsItemAtPath:path];
        NSLog(@"%@", path);
        if (!testFileExists)
        {
            [FCFileManager createFileAtPath:path];
        }
        _progress++;
    }

    
    
    for (int i = 0 ; i < self.imageName.count; i++) {
        NSString * imageName = [self.imageName objectAtIndex:i];
        [FCFileManager createDirectoriesForPath:[[FCFileManager pathForDocumentsDirectory] stringByAppendingString:@"/album"]];
        NSString *path = [[[FCFileManager pathForDocumentsDirectory] stringByAppendingString:@"/album/"] stringByAppendingString:imageName];
        BOOL testFileExists = [FCFileManager existsItemAtPath:path];
        NSLog(@"%@", path);
        if (!testFileExists)
        {
            self.byteCount = [self getInCameraFile:imageName];
            if (self.byteCount == 0) {
                char bytes[self.byteCount];
                count = [[self createSocketFromReciveFile] receiveBytes:bytes count:self.byteCount];
            }
            else
            {
                [[self createSocketFromReciveFile] receiveFile:path length:self.byteCount];
                char bytes[1024];
                count = [[self createSocket] receiveBytes:bytes count:1024];
                NSString *received = [[NSString alloc] initWithBytes:bytes length:count encoding:NSUTF8StringEncoding];
                NSLog(@"Ответ 5  -  %@\n", received);
            }
        }
        _progress++;
    }
    
    self.imageCount = 0;
    self.progress = 0;
}


-(void) formatSD:(NSString *)param
{
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        NSString * message = [NSString stringWithFormat:@"{\"token\":%@,\"msg_id\":4,\"param\":\"%@\"}" ,[self getToken] , param];
        NSData *data = [message dataUsingEncoding:NSUTF8StringEncoding];
        NSLog(@"Запрос 5  -  %@\n", message);
        [[self createSocket] sendBytes:[data bytes] count:[data length]];
        char bytes[1024];
        count = [[self createSocket] receiveBytes:bytes count:1024];
        NSString *received = [[NSString alloc] initWithBytes:bytes length:count encoding:NSUTF8StringEncoding];
        NSLog(@"Ответ 5  -  %@\n", received);
    });
}


-(NSString*)paramsInfoVideoResolution:(NSString*)type
{
        NSString * message = [NSString stringWithFormat:@"{\"token\":%@,\"msg_id\":1,\"type\":\"%@\"}" ,[self getToken] , type];
        NSData *data = [message dataUsingEncoding:NSUTF8StringEncoding];
        NSLog(@"Запрос 5  -  %@\n", message);
        [[self createSocket] sendBytes:[data bytes] count:[data length]];
        char bytes[1024];
        count = [[self createSocket] receiveBytes:bytes count:1024];
    
        NSString *received = [[NSString alloc] initWithBytes:bytes length:count encoding:NSUTF8StringEncoding];
    
        NSLog(@"Ответ 5  -  %@\n", received);
    
    NSArray *jsonObject = [NSJSONSerialization JSONObjectWithData:[NSData dataWithBytes:bytes length:count] options:0 error:NULL];

    
    self.videoResolution = [jsonObject valueForKey:@"param"];
    
    return self.videoResolution;
}

-(NSString*) paramsInfoAudio:(NSString*)type {

    NSString * message = [NSString stringWithFormat:@"{\"token\":%@,\"msg_id\":1,\"type\":\"%@\"}" ,[self getToken] , type];
    NSData *data = [message dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"Запрос 5  -  %@\n", message);
    [[self createSocket] sendBytes:[data bytes] count:[data length]];
    char bytes[1024];
    count = [[self createSocket] receiveBytes:bytes count:1024];
    
    NSString *received = [[NSString alloc] initWithBytes:bytes length:count encoding:NSUTF8StringEncoding];
    
    NSLog(@"Ответ 5  -  %@\n", received);
    
    NSArray *jsonObject = [NSJSONSerialization JSONObjectWithData:[NSData dataWithBytes:bytes length:count] options:0 error:NULL];
    
    
    self.audio = [jsonObject valueForKey:@"param"];
    
    return self.audio;


}

-(NSString*) paramsInfoRotate:(NSString*)type {
    
    NSString * message = [NSString stringWithFormat:@"{\"token\":%@,\"msg_id\":1,\"type\":\"%@\"}" ,[self getToken] , type];
    NSData *data = [message dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"Запрос 5  -  %@\n", message);
    [[self createSocket] sendBytes:[data bytes] count:[data length]];
    char bytes[1024];
    count = [[self createSocket] receiveBytes:bytes count:1024];
    
    NSString *received = [[NSString alloc] initWithBytes:bytes length:count encoding:NSUTF8StringEncoding];
    
    NSLog(@"Ответ 5  -  %@\n", received);
    
    NSArray *jsonObject = [NSJSONSerialization JSONObjectWithData:[NSData dataWithBytes:bytes length:count] options:0 error:NULL];
    
    
    self.rotate = [jsonObject valueForKey:@"param"];
    
    return self.rotate;
    
}

-(NSString*) paramsInfoBitRate:(NSString*)type {
    
    NSString * message = [NSString stringWithFormat:@"{\"token\":%@,\"msg_id\":1,\"type\":\"%@\"}" ,[self getToken] , type];
    NSData *data = [message dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"Запрос 5  -  %@\n", message);
    [[self createSocket] sendBytes:[data bytes] count:[data length]];
    char bytes[1024];
    count = [[self createSocket] receiveBytes:bytes count:1024];
    
    NSString *received = [[NSString alloc] initWithBytes:bytes length:count encoding:NSUTF8StringEncoding];
    
    NSLog(@"Ответ 5  -  %@\n", received);
    
    NSArray *jsonObject = [NSJSONSerialization JSONObjectWithData:[NSData dataWithBytes:bytes length:count] options:0 error:NULL];
    
    
    self.videoBit = [jsonObject valueForKey:@"param"];
    
    return self.videoBit;
    
}

-(NSString*) paramsInfoVideoClip:(NSString*)type {
    
    NSString * message = [NSString stringWithFormat:@"{\"token\":%@,\"msg_id\":1,\"type\":\"%@\"}" ,[self getToken] , type];
    NSData *data = [message dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"Запрос 5  -  %@\n", message);
    [[self createSocket] sendBytes:[data bytes] count:[data length]];
    char bytes[1024];
    count = [[self createSocket] receiveBytes:bytes count:1024];
    
    NSString *received = [[NSString alloc] initWithBytes:bytes length:count encoding:NSUTF8StringEncoding];
    
    NSLog(@"Ответ 5  -  %@\n", received);
    
    NSArray *jsonObject = [NSJSONSerialization JSONObjectWithData:[NSData dataWithBytes:bytes length:count] options:0 error:NULL];
    
    
    self.videoClip = [jsonObject valueForKey:@"param"];
    
    return self.videoClip;
    
}

-(NSString*) paramsInfoWDR:(NSString*)type {
    
    NSString * message = [NSString stringWithFormat:@"{\"token\":%@,\"msg_id\":1,\"type\":\"%@\"}" ,[self getToken] , type];
    NSData *data = [message dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"Запрос 5  -  %@\n", message);
    [[self createSocket] sendBytes:[data bytes] count:[data length]];
    char bytes[1024];
    count = [[self createSocket] receiveBytes:bytes count:1024];
    
    NSString *received = [[NSString alloc] initWithBytes:bytes length:count encoding:NSUTF8StringEncoding];
    
    NSLog(@"Ответ 5  -  %@\n", received);
    
    NSArray *jsonObject = [NSJSONSerialization JSONObjectWithData:[NSData dataWithBytes:bytes length:count] options:0 error:NULL];
    
    
    self.WDR = [jsonObject valueForKey:@"param"];
    
    return self.WDR;
    
}

-(NSString*) paramsInfoFieldOfView:(NSString*)type {
    
    NSString * message = [NSString stringWithFormat:@"{\"token\":%@,\"msg_id\":1,\"type\":\"%@\"}" ,[self getToken] , type];
    NSData *data = [message dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"Запрос 5  -  %@\n", message);
    [[self createSocket] sendBytes:[data bytes] count:[data length]];
    char bytes[1024];
    count = [[self createSocket] receiveBytes:bytes count:1024];
    
    NSString *received = [[NSString alloc] initWithBytes:bytes length:count encoding:NSUTF8StringEncoding];
    
    NSLog(@"Ответ 5  -  %@\n", received);
    
    NSArray *jsonObject = [NSJSONSerialization JSONObjectWithData:[NSData dataWithBytes:bytes length:count] options:0 error:NULL];
    
    
    self.fieldOfView = [jsonObject valueForKey:@"param"];
    
    return self.fieldOfView;
    
}

-(NSString*)paramsInfoDefaultMode:(NSString*)type {
    
    NSString * message = [NSString stringWithFormat:@"{\"token\":%@,\"msg_id\":1,\"type\":\"%@\"}" ,[self getToken] , type];
    NSData *data = [message dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"Запрос 5  -  %@\n", message);
    [[self createSocket] sendBytes:[data bytes] count:[data length]];
    char bytes[1024];
    count = [[self createSocket] receiveBytes:bytes count:1024];
    
    NSString *received = [[NSString alloc] initWithBytes:bytes length:count encoding:NSUTF8StringEncoding];
    
    NSLog(@"Ответ 5  -  %@\n", received);
    
    NSArray *jsonObject = [NSJSONSerialization JSONObjectWithData:[NSData dataWithBytes:bytes length:count] options:0 error:NULL];
    
    self.defaultMode = [jsonObject valueForKey:@"param"];
    
    return self.defaultMode;
    
    
}

-(void) deleteFileFromCamera:(NSString *)param {
    
    NSString * message = [NSString stringWithFormat:@"{\"token\":%@,\"msg_id\":1281,\"param\":\"%@\"}" ,[self getToken] , param];
    NSData *data = [message dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"Запрос 5  -  %@\n", message);
    [[self createSocket] sendBytes:[data bytes] count:[data length]];
    char bytes[1024];
    count = [[self createSocket] receiveBytes:bytes count:1024];
    NSString *received = [[NSString alloc] initWithBytes:bytes length:count encoding:NSUTF8StringEncoding];
    NSLog(@"Ответ 5  -  %@\n", received);
    
}



-(void)deleteToken {

    NSString * message = [NSString stringWithFormat:@"{\"token\":%@,\"msg_id\":258}", [self getToken]];
    NSData *data = [message dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"Запрос 5  -  %@\n", message);
    [[self createSocket] sendBytes:[data bytes] count:[data length]];
    char bytes[1024];
    count = [[self createSocket] receiveBytes:bytes count:1024];
    NSString *received = [[NSString alloc] initWithBytes:bytes length:count encoding:NSUTF8StringEncoding];
    NSLog(@"Ответ 5  -  %@\n", received);
    NSString * string;
    self.token = string;

}

-(NSString *) getCameraTime
{
    NSString * message = [NSString stringWithFormat:@"{\"token\":%@,\"msg_id\":1,\"type\":\"camera_time\"}" ,[self getToken]];
    NSData *data = [message dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"Запрос 5  -  %@\n", message);
    [[self createSocket] sendBytes:[data bytes] count:[data length]];
    char bytes[1024];
    count = [[self createSocket] receiveBytes:bytes count:1024];
    NSString *received = [[NSString alloc] initWithBytes:bytes length:count encoding:NSUTF8StringEncoding];
    
    NSLog(@"Ответ 5  -  %@\n", received);
    
    NSArray *jsonObject = [NSJSONSerialization JSONObjectWithData:[NSData dataWithBytes:bytes length:count] options:0 error:NULL];

    NSString * param = [jsonObject valueForKey:@"param"];

    return param;
}

-(void) downloadVideoFromName:(NSString *)name
{
    
    NSString * videoName = name;
    [FCFileManager createDirectoriesForPath:[[FCFileManager pathForDocumentsDirectory] stringByAppendingString:@"/album"]];
    NSString *path = [[[FCFileManager pathForDocumentsDirectory] stringByAppendingString:@"/album/"] stringByAppendingString:videoName];
    BOOL testFileExists = [FCFileManager existsItemAtPath:path];
    if (testFileExists) {
        [FCFileManager removeItemAtPath:path];
    }
    BOOL testFileExistsTwo = [FCFileManager existsItemAtPath:path];
    NSLog(@"%@", path);
    if (!testFileExistsTwo)
    {
        self.byteCount = [self getInCameraFile:videoName];
        if (self.byteCount == 0) {
            char bytes[self.byteCount];
            count = [[self createSocketFromReciveFile] receiveBytes:bytes count:self.byteCount];
        }
        else
        {
            [[self createSocketFromReciveFile] receiveFile:path length:self.byteCount];
            char bytes[1024];
            count = [[self createSocket] receiveBytes:bytes count:1024];
            NSString *received = [[NSString alloc] initWithBytes:bytes length:count encoding:NSUTF8StringEncoding];
            NSLog(@"Ответ 5  -  %@\n", received);
        }
    }
}

-(void) startTimerRecording
{
    if (!self.timer) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(cameraRecording) userInfo:nil repeats:YES];
    }
    else
    {
        [self.timer fire];
    }
}


-(void) cameraRecording
{
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        NSString * message = [NSString stringWithFormat:@"{\"token\":%@,\"msg_id\":1,\"type\":\"app_status\"}" ,[self getToken]];
        NSData *data = [message dataUsingEncoding:NSUTF8StringEncoding];
        NSLog(@"Запрос 5  -  %@\n", message);
        [[self createSocket] sendBytes:[data bytes] count:[data length]];
        char bytes[1024];
        count = [[self createSocket] receiveBytes:bytes count:1024];
        
        NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:[NSData dataWithBytes:bytes length:count] options:0 error:NULL];
        
        NSLog(@"%@", jsonObject);
        
        NSString * str = [jsonObject valueForKey:@"param"];
        
        
        if (str.length > 0) {
            if ([str isEqualToString:@"record"]) {
                self.record = YES;
            }
            else
            {
                self.record = NO;
            }
        }
        else
        {
            self.record = NO;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"checkCameraRecording" object:nil];
        });
    });
    
}

-(void) stopTimerRecording
{
    [self.timer invalidate];
    self.timer = nil;
}

@end
