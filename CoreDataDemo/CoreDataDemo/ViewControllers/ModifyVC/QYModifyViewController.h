//
//  QYModifyViewController.h
//  CoreDataDemo
//
//  Created by QiaoYan on 2018/3/1.
//  Copyright © 2018年 QiaoYan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QYHomePageViewModel;
@protocol QYModifyViewControllerDelegate;

@interface QYModifyViewController : UIViewController

@property (nonatomic, weak) id<QYModifyViewControllerDelegate> delegate;

- (instancetype)initWithNibName:(NSString *)nibNameOrNil
                         bundle:(NSBundle *)nibBundleOrNil
              homepageViewModel:(QYHomePageViewModel *)viewModel;

@end

@protocol QYModifyViewControllerDelegate <NSObject>

- (void)textModifyWithNewTitle:(NSString *)newtitle
                   newdDesText:(NSString *)newDesTest;

@end
