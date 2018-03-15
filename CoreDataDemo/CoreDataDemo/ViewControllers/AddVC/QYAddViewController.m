//
//  QYAddViewController.m
//  CoreDataDemo
//
//  Created by QiaoYan on 2018/3/1.
//  Copyright © 2018年 QiaoYan. All rights reserved.
//

#import "QYAddViewController.h"

@interface QYAddViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *desTextTextField;

@end

@implementation QYAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)addItem:(id)sender {
    if ([self.delegate respondsToSelector:@selector(addItemWithTitle:desText:)]) {
        [self.delegate addItemWithTitle:self.titleTextField.text
                                desText:self.desTextTextField.text];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)hideKeyBoard:(id)sender {
    if ([self.titleTextField isFirstResponder]) {
        [self.titleTextField resignFirstResponder];
    }
    
    if ([self.desTextTextField isFirstResponder]) {
        [self.desTextTextField resignFirstResponder];
    }
}

#pragma mark - UITextField Delegate

//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
//    if (<#condition#>) {
//        <#statements#>
//    }
//}

@end




