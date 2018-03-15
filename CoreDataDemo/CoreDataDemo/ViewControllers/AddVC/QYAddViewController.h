//
//  QYAddViewController.h
//  CoreDataDemo
//
//  Created by QiaoYan on 2018/3/1.
//  Copyright © 2018年 QiaoYan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QYAddViewControllerDelegate;

@interface QYAddViewController : UIViewController

@property (nonatomic, weak) id<QYAddViewControllerDelegate> delegate;

@end

@protocol QYAddViewControllerDelegate <NSObject>

- (void)addItemWithTitle:(NSString *)title
                 desText:(NSString *)desTest;

@end
