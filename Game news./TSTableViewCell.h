//
//  TSTableViewCell.h
//  Game news.
//
//  Created by Mac on 11.06.16.
//  Copyright © 2016 Tsvigun Alexandr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TSLabel.h"
#import "TSNew.h"

@interface TSTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *coverView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *sourceLabel;
@property (weak, nonatomic) IBOutlet UILabel *dataLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end
