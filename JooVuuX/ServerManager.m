//
//  ServerManager.m
//  TeskFour
//
//  Created by Andrey on 13.03.15.
//  Copyright (c) 2015 serg. All rights reserved.
//

#import "ServerManager.h"
#import "AFNetworking.h"

@interface ServerManager ()
@property (strong, nonatomic) AFHTTPRequestOperationManager* requestOperationManager;
@end
@implementation ServerManager

+(ServerManager *) sharedManager
{
    static ServerManager * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ServerManager alloc] init];
    });
    
    return manager;
}

-(void) registrationToken:(NSString *)token uuid:(NSString *)uuid onSuccess:(void (^)(NSMutableArray *))success onFailure:(void (^)(NSError *))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSDictionary * dict = [NSDictionary new];
    dict = @{@"action":@"register-device", @"platform":@"ios", @"token":token, @"did":uuid};
    
    [manager GET:@"http://joovuu.com/push/index.php" parameters:dict success:^(AFHTTPRequestOperation *operation, NSDictionary * responseObject) {
        NSLog(@"%@", responseObject);
    }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"Error: %@", error);
             if (failure) {
                 failure(error);
             }
         }];
}

@end


