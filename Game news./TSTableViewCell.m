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
    
}

//+ (TSLabel *)titleLabel:(TSTableViewCell *)cell post:(TSNew *)post
//{
//    TSLabel *titleLabel = [[TSLabel alloc] initWithFrame:CGRectMake(8, cell.frame.size.height / 2, cell.frame.size.width - 16, cell.frame.size.height / 3)
//                                               text:post.name
//                                          textColor:[UIColor blackColor]
//                                               font:[UIFont boldSystemFontOfSize:20.0]
//                                             atLine:0];
//    return titleLabel;
//}

@end
