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

@interface TSNewsViewController () <MSSTabBarViewDataSource, MSSTabBarViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
//@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) NSMutableArray *arrayNews;

@end

@implementation TSNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setValue:[[MSSTabNavigationBar alloc]init] forKeyPath:@"navigationBar"];
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    
    self.arrayNews = [NSMutableArray array];
    [self getNewsFromServer];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.translucent = NO;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 140, 0);
    
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

#pragma mark - Library

- (NSArray *)viewControllersForPageViewController:(MSSPageViewController *)pageViewController
{
    UITableViewController *controller = [[UITableViewController alloc] init];
    UITableViewController *controller2 = [[UITableViewController alloc] init];
    UITableViewController *controller3 = [[UITableViewController alloc] init];
    
    NSArray *controllers = @[controller, controller2, controller3];
    
    return controllers;
}

- (void)tabBarView:(MSSTabBarView *)tabBarView populateTab:(MSSTabBarCollectionViewCell *)tab atIndex:(NSInteger)index
{
    
}

- (NSInteger)numberOfItemsForTabBarView:(nonnull MSSTabBarView *)tabBarView
{
    return 3;
}

- (nullable NSArray<NSString *> *)tabTitlesForTabBarView:(nonnull MSSTabBarView *)tabBarView
{
    NSArray *arrayTitle = @[@"News", @"Video", @"Favorit"];
    
    return arrayTitle;
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
    static NSString *identifier = @"cell";
    
    TSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[TSTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    TSNew *new = [self.arrayNews objectAtIndex:indexPath.row];
    cell.titleLabel.text = new.name;
    cell.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.titleLabel.numberOfLines = 0;
    [cell.titleLabel sizeToFit];
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
    return cell;
}

#pragma mark - UITableViewDelegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
