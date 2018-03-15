//
//  QYHomePageModel.m
//  CoreDataDemo
//
//  Created by QiaoYan on 2018/3/1.
//  Copyright © 2018年 QiaoYan. All rights reserved.
//

#import "QYHomePageViewModel.h"

@interface QYHomePageViewModel ()

@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *desText;

@end

@implementation QYHomePageViewModel

- (instancetype)initWithTitle:(NSString *)title
                      desText:(NSString *)desText
                    imageName:(NSString *)imageName {
    if (self = [super init]) {
        self.title = title;
        self.desText = desText;
        self.imageName = imageName;
    }
    return self;
}

- (void)resetWithTitle:(NSString *)newTitle
               desText:(NSString *)newDesText {
    self.title = newTitle;
    self.desText = newDesText;
}

@end
