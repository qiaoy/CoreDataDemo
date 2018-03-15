//
//  QYHomePageListViewModel.h
//  CoreDataDemo
//
//  Created by QiaoYan on 2018/3/1.
//  Copyright © 2018年 QiaoYan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class QYHomePageViewModel;

NS_ASSUME_NONNULL_BEGIN
@interface QYHomePageListViewModel : NSObject

@property (nonatomic, readonly, copy) NSArray<QYHomePageViewModel *> *viewModels;

- (void)modifyHomeListWithNewTitle:(NSString *)newTitle
                        newDesText:(NSString *)newDesText
                             index:(NSInteger)index;

- (void)addHomeListWithTitle:(NSString *)title
                     desText:(NSString *)desText;

- (void)removeHomeListWithIndex:(NSInteger)index;

- (void)searchWithText:(NSString *)text;

@end
NS_ASSUME_NONNULL_END
