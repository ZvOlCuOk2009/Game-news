//
//  TSNew.m
//  Game news.
//
//  Created by Mac on 09.06.16.
//  Copyright © 2016 Tsvigun Alexandr. All rights reserved.
//

#import "TSNew.h"

@implementation TSNew

- (id)initWithParameterNew:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.name = [dictionary objectForKey:@"name"];
        self.link = [dictionary objectForKey:@"link"];
        NSString *image = [dictionary objectForKey:@"cover"];
        self.cover = [NSURL URLWithString:image];
        self.date = [[dictionary objectForKey:@"date"] doubleValue];
    }
    return self;
}

@end
