//
//  ServerManager.h
//  TeskFour
//
//  Created by Andrey on 13.03.15.
//  Copyright (c) 2015 serg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface ServerManager : NSObject

+(ServerManager *) sharedManager;

-(void) registrationToken:(NSString *)token uuid:(NSString *)uuid onSuccess:(void (^)(NSMutableArray *))success onFailure:(void (^)(NSError *))failure;

@end
