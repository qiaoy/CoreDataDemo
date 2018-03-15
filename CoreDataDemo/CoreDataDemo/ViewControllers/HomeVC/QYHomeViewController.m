//
//  ViewController.m
//  CoreDataDemo
//
//  Created by QiaoYan on 2018/3/1.
//  Copyright © 2018年 QiaoYan. All rights reserved.
//

#import "QYHomeViewController.h"
#import "QYHomePageListViewModel.h"
#import "QYAddViewController.h"
#import "QYModifyViewController.h"
#import "QYHomePageViewModel.h"
#import "QYTableViewCell.h"

@interface QYHomeViewController ()
<UITableViewDataSource,
UITableViewDelegate,
UISearchBarDelegate,
QYAddViewControllerDelegate,
QYModifyViewControllerDelegate>

@property (nonatomic, strong) QYHomePageListViewModel *listViewModel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, assign) NSInteger modifyIndex;

@end

static NSString *const kHomePageCellID = @"kHomePageCellID";

@implementation QYHomeViewController

#pragma mark - Lift Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.modifyIndex = 0;
    self.listViewModel = [[QYHomePageListViewModel alloc] init];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"QYTableViewCell"
                                               bundle:nil]
         forCellReuseIdentifier:kHomePageCellID];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

#pragma Privete Methods

- (void)p_delegateItemWithIndex:(NSInteger)index {
    [self.listViewModel removeHomeListWithIndex:index];
}

#pragma mark - Events

- (IBAction)addItem:(id)sender {
    QYAddViewController *addVC = \
    [[QYAddViewController alloc] initWithNibName:@"QYAddViewController" bundle:nil];
    addVC.delegate = self;
    
    [self.navigationController pushViewController:addVC
                                         animated:YES];
}

#pragma mark - QYAddViewController Delegate

- (void)addItemWithTitle:(NSString *)title
                 desText:(NSString *)desTest {
    [self.listViewModel addHomeListWithTitle:title
                                     desText:desTest];
}

- (void)textModifyWithNewTitle:(NSString *)newtitle
                   newdDesText:(NSString *)newDesTest {
    [self.listViewModel modifyHomeListWithNewTitle:newtitle
                                        newDesText:newDesTest
                                             index:self.modifyIndex];
}

#pragma mark - UISearchBar Delegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [self.listViewModel searchWithText:searchText];
    
    [self.tableView reloadData];
}

#pragma mark - UITableView Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listViewModel.viewModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QYTableViewCell *cell = \
    [tableView dequeueReusableCellWithIdentifier:kHomePageCellID
                                    forIndexPath:indexPath];
    
    QYHomePageViewModel *viewModel = self.listViewModel.viewModels[indexPath.row];
    [cell configWithHomePageViewModel:viewModel];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.modifyIndex = indexPath.row;
    
    QYHomePageViewModel *viewModel = self.listViewModel.viewModels[indexPath.row];
    QYModifyViewController *modifyVC = \
    [[QYModifyViewController alloc] initWithNibName:nil
                                             bundle:nil
                                  homepageViewModel:viewModel];
    modifyVC.delegate = self;
    
    [self.navigationController pushViewController:modifyVC
                                         animated:YES];
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView
                  editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"Delete" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        [self p_delegateItemWithIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath]
                         withRowAnimation:UITableViewRowAnimationFade];
    }];
    
    return @[deleteAction];
}

@end
