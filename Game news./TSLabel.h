//
//  TSLabel.h
//  Game news
//
//  Created by Mac on 13.06.16.
//  Copyright © 2016 Tsvigun Alexandr. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TSLabel : UILabel

- (id)initWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)color font:(UIFont *)font atLine:(NSInteger)line;

- (id)initWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)color toMark:(BOOL)mark;

@end
