//
//  TSNew.h
//  Game news.
//
//  Created by Mac on 09.06.16.
//  Copyright © 2016 Tsvigun Alexandr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSNew : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *link;
@property (strong, nonatomic) NSURL *cover;
@property (assign, nonatomic) double date;

- (id)initWithParameterNew:(NSDictionary *)dictionary;

@end
