//
//  NSString+TSFormatingDate.m
//  Game news.
//
//  Created by Mac on 12.06.16.
//  Copyright © 2016 Tsvigun Alexandr. All rights reserved.
//

#import "NSString+TSFormatingDate.h"

@implementation NSString (TSFormatingDate)

+ (NSString *)stringFormatingDate:(double)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    NSDate *sourceDate = [NSDate dateWithTimeIntervalSince1970:date];
    dateFormatter.dateFormat = @"HH:mm  MM.dd";
    dateFormatter.timeStyle = NSDateFormatterMediumStyle;
    dateFormatter.dateStyle = NSDateFormatterShortStyle;
    dateFormatter.doesRelativeDateFormatting = YES;
    NSString *stringData = [dateFormatter stringFromDate:sourceDate];
    return stringData;
}

@end
