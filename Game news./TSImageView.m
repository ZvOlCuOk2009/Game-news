//
//  TSImageView.m
//  Game news
//
//  Created by Mac on 14.06.16.
//  Copyright © 2016 Tsvigun Alexandr. All rights reserved.
//

#import "TSImageView.h"

@implementation TSImageView

- (id)initWithCellAtIndex:(TSTableViewCell *)cell atIndex:(NSInteger)i
{
    self = [super init];
    if (self) {
        CGRect frame = CGRectMake(i * cell.scrollView.bounds.size.width, 0 * cell.scrollView.bounds.size.height,
                                  cell.scrollView.bounds.size.width, cell.scrollView.bounds.size.height);
        self.frame = frame;
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
    }
    return self;
}

- (id)initWithCellTheImage:(TSTableViewCell *)cell
{
    self = [super init];
    if (self) {
        CGRect frame = CGRectMake(cell.contentView.bounds.size.width - 50, cell.contentView.bounds.size.height / 8, 62, 24);
        self.frame = frame;
        self.image = [UIImage imageNamed:@"top"];
        self.layer.cornerRadius = 12;
        self.layer.masksToBounds = YES;
    }
    return self;
}

@end
