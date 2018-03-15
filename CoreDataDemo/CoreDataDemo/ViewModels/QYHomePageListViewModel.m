//
//  QYHomePageListViewModel.m
//  CoreDataDemo
//
//  Created by QiaoYan on 2018/3/1.
//  Copyright © 2018年 QiaoYan. All rights reserved.
//

#import "QYHomePageListViewModel.h"
#import "QYCoreDataManager.h"
#import "QYHomePageListObject.h"
#import "QYHomePageViewModel.h"

@interface QYHomePageListViewModel ()

@property (nonatomic, copy) NSArray<QYHomePageViewModel *> *viewModels;
@property (nonatomic, copy) NSArray<QYHomePageViewModel *> *totalViewModels;
@property (nonatomic, copy) NSArray<QYHomePageViewModel *> *searchViewModels;

@property (nonatomic, getter=isSearching) BOOL searching;

@end

static NSString *const kImageName = @"girl";

@implementation QYHomePageListViewModel

- (instancetype)init {
    if (self = [super init]) {
        
        NSArray<QYHomePageListObject *> *objectList = \
        [[QYCoreDataManager manager] loadHomePageListFromCoreData];
        
        NSMutableArray<QYHomePageViewModel *> *tempViewModels = [NSMutableArray array];
        [objectList enumerateObjectsUsingBlock:^(QYHomePageListObject * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            QYHomePageViewModel *viewModel = \
            [[QYHomePageViewModel alloc] initWithTitle:obj.title
                                               desText:obj.desText
                                             imageName:obj.imageName];
            [tempViewModels addObject:viewModel];
        }];
        
        self.totalViewModels = tempViewModels;
        self.viewModels = tempViewModels;
    }
    return self;
}

#pragma mark - Private Methods

- (void)p_resetSearchViewModelsWith:(NSArray<QYHomePageListObject *> *)objs {
    NSMutableArray<QYHomePageViewModel *> *tempViewModels = [NSMutableArray array];
    [objs enumerateObjectsUsingBlock:^(QYHomePageListObject * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        QYHomePageViewModel *viewModel = \
        [[QYHomePageViewModel alloc] initWithTitle:obj.title
                                           desText:obj.desText
                                         imageName:obj.imageName];
        [tempViewModels addObject:viewModel];
    }];
    
    self.searchViewModels = tempViewModels;
}

- (void)p_resetHomePageViewModels {
    if (self.isSearching) {
        self.viewModels = self.searchViewModels;
    } else {
        self.viewModels = self.totalViewModels;
    }
}

- (void)p_modifyViewModelsWithTitle:(NSString *)newTitle
                         newDesText:(NSString *)newDesText
                              index:(NSInteger)index {
    QYHomePageViewModel *viewModel = self.totalViewModels[index];
    [viewModel resetWithTitle:newTitle
                      desText:newDesText];
    
    [self p_resetHomePageViewModels];
}

- (void)p_addViewMOdelsWithTitle:(NSString *)title
                       desText:(NSString *)desText {
    NSMutableArray<QYHomePageViewModel *> *tempViewModels = \
    [NSMutableArray arrayWithArray:self.totalViewModels];
    
    QYHomePageViewModel *viewModel = \
    [[QYHomePageViewModel alloc] initWithTitle:title
                                       desText:desText
                                     imageName:kImageName];
    [tempViewModels addObject:viewModel];
    
    self.totalViewModels = tempViewModels;
    
    [self p_resetHomePageViewModels];
}

- (void)p_removeViewModelWithIndex:(NSInteger)index  {
    NSMutableArray *tempViewModels = [NSMutableArray arrayWithArray:self.totalViewModels];
    [tempViewModels removeObjectAtIndex:index];
    self.totalViewModels = tempViewModels;
    
    [self p_resetHomePageViewModels];
}

#pragma mark - Public Methods

- (void)modifyHomeListWithNewTitle:(NSString *)newTitle
                        newDesText:(NSString *)newDesText
                             index:(NSInteger)index {
    NSArray<QYHomePageListObject *> *objectList = \
    [[QYCoreDataManager manager] loadHomePageListFromCoreData];
    
    QYHomePageListObject *obj = objectList[index];
    obj.title = newTitle;
    obj.desText = newDesText;
    
    NSError* error;
    [[QYCoreDataManager manager].managerObjectContext save:&error];
    
    if (error) {
        NSLog(@"Modify Fail");
    } else {
        [self p_modifyViewModelsWithTitle:newTitle
                               newDesText:newDesText
                                    index:index];
    }
}

- (void)addHomeListWithTitle:(NSString *)title
                     desText:(NSString *)desText {
    QYHomePageListObject *obj = \
    [NSEntityDescription insertNewObjectForEntityForName:@"QYHomePageListObject"
                                  inManagedObjectContext:[QYCoreDataManager manager].managerObjectContext];
    obj.title = title;
    obj.desText = desText;
    obj.imageName = kImageName;
    
    NSError* error;
    [[QYCoreDataManager manager].managerObjectContext save:&error];
    
    if (error) {
        NSLog(@"Add Fail");
    } else {
        [self p_addViewMOdelsWithTitle:title
                               desText:desText];
    }
}

- (void)removeHomeListWithIndex:(NSInteger)index {
    NSArray<QYHomePageListObject *> *objectList = \
    [[QYCoreDataManager manager] loadHomePageListFromCoreData];
    QYHomePageListObject *obj = objectList[index];
    [[QYCoreDataManager manager].managerObjectContext deleteObject:obj];
    
    [self p_removeViewModelWithIndex:index];
}

- (void)searchWithText:(NSString *)text {
    if (text.length == 0) {
        self.searching = NO;
    } else {
        self.searching = YES;
        
        NSFetchRequest *request = \
        [NSFetchRequest fetchRequestWithEntityName:@"QYHomePageListObject"];
        
        NSPredicate *predicate = \
        [NSPredicate predicateWithFormat:@"title CONTAINS %@ OR desText CONTAINS %@", text, text];
        [request setPredicate:predicate];
        
        NSSortDescriptor *title = [NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES];
        [request setSortDescriptors:@[title]];
        
        NSArray<QYHomePageListObject *> *temps = \
        [[QYCoreDataManager manager].managerObjectContext executeFetchRequest:request error:nil];
        
        [self p_resetSearchViewModelsWith:temps];
    }
    
    [self p_resetHomePageViewModels];
}

@end
