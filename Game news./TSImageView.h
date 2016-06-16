//
//  TSImageView.h
//  Game news
//
//  Created by Mac on 14.06.16.
//  Copyright © 2016 Tsvigun Alexandr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TSTableViewCell.h"

@interface TSImageView : UIImageView

- (id)initWithCellAtIndex:(TSTableViewCell *)cell atIndex:(NSInteger)i;

- (id)initWithCellTheImage:(TSTableViewCell *)cell;

@end
