//
//  TSLabel.m
//  Game news
//
//  Created by Mac on 13.06.16.
//  Copyright © 2016 Tsvigun Alexandr. All rights reserved.
//

#import "TSLabel.h"

@implementation TSLabel

- (id)initWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)color
               font:(UIFont *)font atLine:(NSInteger)line
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        self.text = text;
        self.textColor = color;
        self.font = font;
        self.lineBreakMode = NSLineBreakByWordWrapping;
        self.numberOfLines = line;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)color toMark:(BOOL)mark
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        self.text = text;
        self.textColor = color;
        self.font = [UIFont fontWithName:@"Light" size:17];
        self.textAlignment = NSTextAlignmentCenter;
        if (mark == YES) {
            UIView *strip = [[UIView alloc] initWithFrame:CGRectMake(0, 34, frame.size.width, 2)];
            strip.backgroundColor = [UIColor blueColor];
            [self addSubview:strip];
        }
    }
    return self;
}

@end



