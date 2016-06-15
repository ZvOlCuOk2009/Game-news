//
//  TSCountLinesLabel.m
//  Game news
//
//  Created by Mac on 16.06.16.
//  Copyright © 2016 Tsvigun Alexandr. All rights reserved.
//

#import "TSCountLinesLabel.h"

@implementation TSCountLinesLabel

+ (NSInteger)lineCountForTitleLabel:(NSString *)text parenrView:(UIView *)view
{
    UIFont *font = [UIFont boldSystemFontOfSize:20.0];
    NSInteger width = view.frame.size.width - 16;
    
    CGRect rect = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{NSFontAttributeName:font}
                                     context:nil];
    
    return ceil(rect.size.height / font.lineHeight);
}

@end
