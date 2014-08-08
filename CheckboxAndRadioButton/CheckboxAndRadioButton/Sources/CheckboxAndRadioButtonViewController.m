//
//  CheckboxAndRadioButtonViewController.m
//  CheckboxAndRadioButton
//
//  Created by hara on 2014/08/08.
//  Copyright (c) 2014年 Kazuaki Hara. All rights reserved.
//

#import "CheckboxAndRadioButtonViewController.h"
#import "Checkbox.h"

@interface CheckboxAndRadioButtonViewController ()
@property (weak, nonatomic) IBOutlet Checkbox* checkbox1;
@property (weak, nonatomic) IBOutlet Checkbox* checkbox2;
@property (weak, nonatomic) IBOutlet UIView* checkboxFrame;

@end

@implementation CheckboxAndRadioButtonViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"CheckboxAndRadioButton";
    
    [self.checkbox1 setup:nil];
    [self.checkbox2 setup:nil];
    
    self.checkboxFrame.layer.borderColor = [[UIColor grayColor] CGColor];
    self.checkboxFrame.layer.borderWidth = 1;
    self.checkboxFrame.layer.cornerRadius = 6;
}

@end
