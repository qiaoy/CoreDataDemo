//
//  QYCoreDataManager.h
//  CoreDataDemo
//
//  Created by QiaoYan on 2018/3/1.
//  Copyright © 2018年 QiaoYan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class QYHomePageListObject;

@interface QYCoreDataManager : NSObject

@property (nonatomic, readonly, strong) NSManagedObjectContext *managerObjectContext;

+ (instancetype)manager;

- (NSArray<QYHomePageListObject *> *)loadHomePageListFromCoreData;

@end
