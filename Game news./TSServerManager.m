//
//  TSDataManager.m
//  Game news.
//
//  Created by Mac on 09.06.16.
//  Copyright © 2016 Tsvigun Alexandr. All rights reserved.
//

#import "TSServerManager.h"
#import "TSNew.h"

@interface TSServerManager ()

@property (strong, nonatomic) AFHTTPSessionManager *sessionManager;

@end

@implementation TSServerManager

+ (TSServerManager *)sharedManager
{
    static TSServerManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[TSServerManager alloc] init];
    });
    return manager;
}

- (void)newsToReceiveRequestFromTheServer:(void(^)(NSArray *news)) success
                                inFailure:(void(^)(NSError *error)) failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:@"http://gamenewsapp.ru:3000/api/news"
      parameters:nil
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             NSDictionary *dictArray = responseObject;
             NSMutableArray *newsArray = [NSMutableArray array];
             for (NSDictionary *dict in dictArray) {
                 TSNew *new = [[TSNew alloc] initWithParameterNew:dict];
                 [newsArray addObject:new];
             }
             if (success) {
                 success(newsArray);
             }
             NSLog(@"JSON: %@", responseObject);
         }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             NSLog(@"Error: %@", error);
         }];
    
}

@end
