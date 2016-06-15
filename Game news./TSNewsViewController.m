//
//  ViewController.m
//  Game news.
//
//  Created by Mac on 16.05.16.
//  Copyright © 2016 Tsvigun Alexandr. All rights reserved.
//


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
@property (strong, nonatomic) MSSPageViewController *pageViewController;

@end

@implementation TSNewsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController setValue:[[MSSTabNavigationBar alloc]init] forKeyPath:@"navigationBar"];
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    
    self.arrayNews = [NSMutableArray array];
    [self getNewsFromServer];
    
    NSInteger weight = self.view.bounds.size.width - (self.view.bounds.size.width / 3);
    CGRect frame = CGRectMake(self.view.bounds.origin.x + 20, 100, weight / 3, 30);
    TSLabel *label = [[TSLabel alloc] initWithFrame:frame
                                               text:@"Stories"
                                          textColor:[UIColor whiteColor]
                                               font:[UIFont systemFontOfSize:18]
                                             atLine:1];
    
    NSInteger weight2 = self.view.bounds.size.width - (self.view.bounds.size.width / 3);
    CGRect frame2 = CGRectMake(165, 100, weight2 / 3, 30);
    TSLabel *label2 = [[TSLabel alloc] initWithFrame:frame2
                                               text:@"Video"
                                          textColor:[UIColor lightGrayColor]
                                               font:[UIFont systemFontOfSize:18]
                                             atLine:1];
    
    NSInteger weight3 = self.view.bounds.size.width - (self.view.bounds.size.width / 3);
    CGRect frame3 = CGRectMake(280, 100, weight3 / 3, 30);
    TSLabel *label3 = [[TSLabel alloc] initWithFrame:frame3
                                                text:@"Favourites"
                                           textColor:[UIColor lightGrayColor]
                                                font:[UIFont systemFontOfSize:18]
                                              atLine:1];
    
    [self.navigationController.navigationBar addSubview:label];
    [self.navigationController.navigationBar addSubview:label2];
    [self.navigationController.navigationBar addSubview:label3];
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

}

- (void)actionMenu
{
    
}

- (void)actionSearch
{
    
}

#pragma mark - API

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
            
            TSLabel *title = [[TSLabel alloc] initWithFrame:CGRectMake(8, scrollImageView.frame.size.height / 2, scrollImageView.frame.size.width - 16, scrollImageView.frame.size.height / 3)
                                                       text:post.name
                                                  textColor:[UIColor whiteColor]
                                                       font:[UIFont boldSystemFontOfSize:20.0]
                                                     atLine:0];
            
            TSLabel *link = [[TSLabel alloc] initWithFrame:CGRectMake(8, (scrollImageView.frame.size.height / 2) + 50, scrollImageView.frame.size.width / 2, scrollImageView.frame.size.height / 4)
                                                      text:post.link
                                                 textColor:[UIColor blueColor]
                                                      font:[UIFont systemFontOfSize:10.0]
                                                    atLine:1];
            
            TSLabel *date = [[TSLabel alloc] initWithFrame:CGRectMake((scrollImageView.frame.size.width / 2) + 30, (scrollImageView.frame.size.height / 2) + 50, scrollImageView.frame.size.width / 2, scrollImageView.frame.size.height / 4)
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

#pragma mark - Library

- (NSArray *)viewControllersForPageViewController:(MSSPageViewController *)pageViewController
{
    UIViewController *controllerOne = [[UIViewController alloc] init];
    UIViewController *controllerTwo = [[UIViewController alloc] init];
    UIViewController *controllerThree = [[UIViewController alloc] init];
    
    NSArray *controllers = @[controllerOne, controllerTwo, controllerThree];
    
    return controllers;
}

- (void)tabBarView:(MSSTabBarView *)tabBarView populateTab:(MSSTabBarCollectionViewCell *)tab atIndex:(NSInteger)index
{
    for (int i = 0; i < 3; i++) {
        if (index == 0) {
            tab.title = @"Stories";
        } else if (index == 1) {
            tab.title = @"              Video";
        } else if (index == 2) {
            tab.title = @"              Favorites";
        }
    }
}

- (NSInteger)numberOfItemsForTabBarView:(MSSTabBarView *)tabBarView
{
    return 0;//[[self viewControllersForPageViewController:self.pageViewController] count];
}

@end
