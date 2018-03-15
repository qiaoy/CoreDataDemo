//
//  QYCoreDataManager.m
//  CoreDataDemo
//
//  Created by QiaoYan on 2018/3/1.
//  Copyright © 2018年 QiaoYan. All rights reserved.
//

#import "QYCoreDataManager.h"
#import "QYHomePageListObject.h"

@interface QYCoreDataManager ()

@property (nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, strong) NSManagedObjectContext *managerObjectContext;

@end

//static NSString *const kHomePageList = @"HomePageList";
//static NSString *const kExt = @"momd";

@implementation QYCoreDataManager

+ (instancetype)manager {
    static QYCoreDataManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[QYCoreDataManager alloc] init];
    });
    return manager;
}

- (instancetype)init {
    if (self = [super init]) {
        [self setupHomePageCoreData];
    }
    return self;
}

#pragma mark - Setup

- (void)setupHomePageCoreData {
    if (self.managerObjectContext) {
        return;
    }
    
    self.managerObjectContext  = \
    [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    
    NSURL *storeURL = \
    [[self p_applicationDocumentsDirectory] URLByAppendingPathComponent:@"HomePageList.sqlite"];
    
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"CoreDataDemo"
                                              withExtension:@"momd"];
    NSManagedObjectModel *managedObjectModel = \
    [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    NSPersistentStoreCoordinator *coordinator = \
    [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:managedObjectModel];
    
    NSError *error = nil;
    if (![coordinator addPersistentStoreWithType:NSSQLiteStoreType
                                   configuration:nil
                                             URL:storeURL
                                         options:nil
                                           error:&error]) {
        
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }
    
    [self.managerObjectContext  setPersistentStoreCoordinator:coordinator];
}

#pragma mark - Private Method

- (NSURL *)p_applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory
                                                   inDomains:NSUserDomainMask] lastObject];
}

#pragma mark - Public Methods

- (NSArray<QYHomePageListObject *> *)loadHomePageListFromCoreData {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = \
    [NSEntityDescription entityForName:@"QYHomePageListObject"
                inManagedObjectContext:self.managerObjectContext];
    
    [request setEntity:entity];

    NSError *error;
    return [self.managerObjectContext executeFetchRequest:request
                                                    error:&error];
}

@end
