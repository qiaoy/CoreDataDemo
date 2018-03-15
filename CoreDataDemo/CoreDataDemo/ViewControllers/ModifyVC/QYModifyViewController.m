//
//  QYModifyViewController.m
//  CoreDataDemo
//
//  Created by QiaoYan on 2018/3/1.
//  Copyright © 2018年 QiaoYan. All rights reserved.
//

#import "QYModifyViewController.h"
#import "QYHomePageViewModel.h"

@interface QYModifyViewController ()

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *desTextTextField;

@property (nonatomic, copy) NSString *qyTitle;
@property (nonatomic, copy) NSString *desText;

@end

@implementation QYModifyViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil
                         bundle:(NSBundle *)nibBundleOrNil
              homepageViewModel:(QYHomePageViewModel *)viewModel {
    if (self = [self initWithNibName:nibNameOrNil
                              bundle:nibBundleOrNil]) {
        self.qyTitle = viewModel.title;
        self.desText = viewModel.desText;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_configTextField];
}

#pragma mark - Private Methods

- (void)p_configTextField {
    self.titleTextField.text = self.qyTitle;
    self.desTextTextField.text = self.desText;
}

#pragma mark - Events

- (IBAction)hideKeyBoard:(id)sender {
    if ([self.titleTextField isFirstResponder]) {
        [self.titleTextField resignFirstResponder];
    }
    
    if ([self.desTextTextField isFirstResponder]) {
        [self.desTextTextField resignFirstResponder];
    }
}

- (IBAction)done:(id)sender {
    if ([self.delegate respondsToSelector:@selector(textModifyWithNewTitle:newdDesText:)]) {
        [self.delegate textModifyWithNewTitle:self.titleTextField.text
                                  newdDesText:self.desTextTextField.text];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
