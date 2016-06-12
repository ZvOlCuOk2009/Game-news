//
//  TSDataManager.h
//  Game news.
//
//  Created by Mac on 09.06.16.
//  Copyright © 2016 Tsvigun Alexandr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface TSServerManager : NSObject

+ (TSServerManager *)sharedManager;
- (void)newsToReceiveRequestFromTheServer:(void(^)(NSArray *news)) success
                                inFailure:(void(^)(NSError *error)) failure;

@end
