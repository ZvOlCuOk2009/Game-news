//
//  TSLabel.m
//  Game news
//
//  Created by Mac on 13.06.16.
//  Copyright © 2016 Tsvigun Alexandr. All rights reserved.
//

#import "TSLabel.h"

@implementation TSLabel

- (id)initWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)color font:(UIFont *)font
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        self.text = text;
        self.textColor = color;
        self.font = font;
    }
    return self;
}
@end