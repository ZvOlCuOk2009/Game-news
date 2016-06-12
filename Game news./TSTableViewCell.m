//
//  TSTableViewCell.m
//  Game news.
//
//  Created by Mac on 11.06.16.
//  Copyright © 2016 Tsvigun Alexandr. All rights reserved.
//

#import "TSTableViewCell.h"

@implementation TSTableViewCell

- (void)awakeFromNib {
    
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.titleLabel.numberOfLines = 0;
    [self.titleLabel sizeToFit];
}

@end
