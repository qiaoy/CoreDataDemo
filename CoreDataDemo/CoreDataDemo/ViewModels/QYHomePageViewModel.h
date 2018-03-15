//
//  QYHomePageModel.h
//  CoreDataDemo
//
//  Created by QiaoYan on 2018/3/1.
//  Copyright © 2018年 QiaoYan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface QYHomePageViewModel : NSObject

@property (nonatomic, readonly, copy) NSString *imageName;
@property (nonatomic, readonly, copy) NSString *title;
@property (nonatomic, readonly, copy) NSString *desText;

- (instancetype)initWithTitle:(NSString *)title
                      desText:(NSString *)desText
                    imageName:(NSString *)imageName;

- (void)resetWithTitle:(NSString *)newTitle
               desText:(NSString *)newDesText;

@end
NS_ASSUME_NONNULL_END






