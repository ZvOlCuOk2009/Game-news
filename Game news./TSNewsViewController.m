//
//  ViewController.m
//  Game news.
//
//  Created by Mac on 16.05.16.
//  Copyright © 2016 Tsvigun Alexandr. All rights reserved.
//

#define xCoord 100
#define weihtBarLabel 30

#define RGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue: b/255.0 alpha:1.0]
#define WHITE_COLOR RGB(255, 255, 255)
#define LIGHT_GRAY_COLOR RGB(62, 62, 62)

#import "TSNewsViewController.h"
#import "MSSTabBarView.h"
#import "TSServerManager.h"
#import "TSTableViewCell.h"
#import "TSNew.h"
#import "UIImageView+AFNetworking.h"
#import "NSString+TSFormatingDate.h"
#import "UIImage+TSImage.h"
#import "TSLabel.h"
#import "TSImageView.h"
#import "TSCountLinesLabel.h"

@interface TSNewsViewController () <UINavigationControllerDelegate, UIScrollViewDelegate,
                                    MSSTabBarViewDataSource, MSSTabBarViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *arrayNews;
@property (strong, nonatomic) NSString *stringTitle;

@end

@implementation TSNewsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController setValue:[[MSSTabNavigationBar alloc]init] forKeyPath:@"navigationBar"];
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    
    self.arrayNews = [NSMutableArray array];
    [self getNewsFromServer];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.translucent = NO;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu"]
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(actionMenu)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"search"]
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(actionSearch)];

    NSInteger offset = self.view.bounds.origin.x + 20;
    NSInteger weightTab = (self.view.bounds.size.width - 80) / 3;
    
    CGRect frame1 = CGRectMake(offset, xCoord, weightTab, weihtBarLabel);
    CGRect frame2 = CGRectMake((offset * 2) + weightTab, xCoord, weightTab, weihtBarLabel);
    CGRect frame3 = CGRectMake(((offset * 3) + (weightTab * 2)), xCoord, weightTab, weihtBarLabel);
    
    TSLabel *storiesNavBarLabel = [[TSLabel alloc] initWithFrame:frame1
                                                            text:@"Stories"
                                                       textColor:WHITE_COLOR
                                                          toMark:YES];
    
    TSLabel *videoNavBarLabel = [[TSLabel alloc] initWithFrame:frame2
                                                          text:@"Video"
                                                     textColor:LIGHT_GRAY_COLOR
                                                        toMark:NO];
    
    TSLabel *favouritesNavBarLabel = [[TSLabel alloc] initWithFrame:frame3
                                                               text:@"Favourites"
                                                          textColor:LIGHT_GRAY_COLOR
                                                             toMark:NO];
    
    [self.navigationController.navigationBar addSubview:storiesNavBarLabel];
    [self.navigationController.navigationBar addSubview:videoNavBarLabel];
    [self.navigationController.navigationBar addSubview:favouritesNavBarLabel];
}

- (void)actionMenu
{
    
}

- (void)actionSearch
{
    
}

#pragma mark - Data request URL

- (void)getNewsFromServer
{
    [[TSServerManager sharedManager]
     newsToReceiveRequestFromTheServer:^(NSArray *news) {
         [self.arrayNews addObjectsFromArray:news];
         
         NSMutableArray *indexPaths = [NSMutableArray array];
         for (int i = 0; i < news.count; i++) {
             [indexPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
         }
         [self.tableView beginUpdates];
         [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
         [self.tableView endUpdates];
     }
     inFailure:^(NSError *error) {
         NSLog(@"error = %@", [error localizedDescription]);
     }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.arrayNews count];
}

- (TSTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier;
    
    if (indexPath.row == 0) {
        identifier = @"top";
    } else {
        identifier = @"cell";
    }
    
    TSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[TSTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

#pragma mark - Configure cell

- (void)configureCell:(TSTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
        cell.scrollView.contentSize = CGSizeMake(self.view.bounds.size.width * [self.arrayNews count], cell.scrollView.bounds.size.height);
        
        for (int i = 0; i < [self.arrayNews count]; i++) {
            
            TSNew *post = [self.arrayNews objectAtIndex:i];
            
            TSImageView *scrollImageView = [[TSImageView alloc] initWithCellAtIndex:cell atIndex:i];
            scrollImageView.image = [UIImage transformationImage:post.cover];
            
            CGRect frameTitle = CGRectMake(8, scrollImageView.frame.size.height / 2, scrollImageView.frame.size.width - 16, scrollImageView.frame.size.height / 3);
            
            CGRect frameLink = CGRectMake(8, (scrollImageView.frame.size.height / 2) + 50, scrollImageView.frame.size.width / 2, scrollImageView.frame.size.height / 4);
            
            CGRect frameDate = CGRectMake((scrollImageView.frame.size.width / 2) + 30, (scrollImageView.frame.size.height / 2) + 50, scrollImageView.frame.size.width / 2, scrollImageView.frame.size.height / 4);
            
            TSLabel *title = [[TSLabel alloc] initWithFrame:frameTitle
                                                       text:post.name
                                                  textColor:[UIColor whiteColor]
                                                       font:[UIFont boldSystemFontOfSize:20.0]
                                                     atLine:0];
            
            TSLabel *link = [[TSLabel alloc] initWithFrame:frameLink
                                                      text:post.link
                                                 textColor:[UIColor blueColor]
                                                      font:[UIFont systemFontOfSize:10.0]
                                                    atLine:1];
            
            TSLabel *date = [[TSLabel alloc] initWithFrame:frameDate
                                                      text:[NSString stringFormatingDate:post.date]
                                                 textColor:[UIColor whiteColor]
                                                      font:[UIFont systemFontOfSize:10.0]
                                                    atLine:1];
            
            [scrollImageView addSubview:title];
            [scrollImageView addSubview:link];
            [scrollImageView addSubview:date];
            
            [cell.scrollView addSubview:scrollImageView];
        }
        
        [cell.contentView addSubview:[[TSImageView alloc] initWithCellTheImage:cell]];
        
    } else {
        
        TSNew *new = [self.arrayNews objectAtIndex:indexPath.row];
        cell.titleLabel.text = new.name;
        cell.sourceLabel.text = new.link;
        cell.dataLabel.text = [NSString stringFormatingDate:new.date];
        NSURLRequest *request = [NSURLRequest requestWithURL:new.cover];
        __weak TSTableViewCell *weakCell = cell;
        [cell.coverView setImageWithURLRequest:request
                              placeholderImage:nil
                                       success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
                                           weakCell.coverView.image = image;
                                           [weakCell layoutSubviews];
                                       } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
                                           NSLog(@"Error - %@", [error localizedDescription]);
                                       }];
        self.stringTitle = new.name;
    }
}

#pragma mark - UITableViewDelegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height;
    
    if (indexPath.row == 0) {
        height = 204;
    } else {
        if ([TSCountLinesLabel lineCountForTitleLabel:self.stringTitle parenrView:self.view] == 1) {
            height = 248;
        } else if ([TSCountLinesLabel lineCountForTitleLabel:self.stringTitle parenrView:self.view] == 2) {
            height = 271;
        } else if ([TSCountLinesLabel lineCountForTitleLabel:self.stringTitle parenrView:self.view] == 3) {
            height = 294;
        }
    }
    return  height;
}

@end
