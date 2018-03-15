//
//  QYTableViewCell.m
//  CoreDataDemo
//
//  Created by QiaoYan on 2018/3/6.
//  Copyright © 2018年 QiaoYan. All rights reserved.
//

#import "QYTableViewCell.h"
#import "QYHomePageViewModel.h"

@interface QYTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *desLabel;

@end

@implementation QYTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)configWithHomePageViewModel:(QYHomePageViewModel *)viewModel {
    self.titleLabel.text = viewModel.title;
    self.desLabel.text = viewModel.desText;
    self.iconImageView.image = [UIImage imageNamed:viewModel.imageName];
}

@end
