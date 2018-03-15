//
//  QYTableViewCell.h
//  CoreDataDemo
//
//  Created by QiaoYan on 2018/3/6.
//  Copyright © 2018年 QiaoYan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QYHomePageViewModel;

@interface QYTableViewCell : UITableViewCell

- (void)configWithHomePageViewModel:(QYHomePageViewModel *)viewModel;

@end
