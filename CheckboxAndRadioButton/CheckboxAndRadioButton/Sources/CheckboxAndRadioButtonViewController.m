//
//  CheckboxAndRadioButtonViewController.m
//  CheckboxAndRadioButton
//
//  Created by hara on 2014/08/08.
//  Copyright (c) 2014年 Kazuaki Hara. All rights reserved.
//

#import "CheckboxAndRadioButtonViewController.h"
#import "Checkbox.h"
#import "RadioButton.h"

typedef NS_ENUM(NSInteger, RadioButtonId) {
    RADIO_BUTTON_1 = 1,
    RADIO_BUTTON_2 = 2,
};

@interface CheckboxAndRadioButtonViewController ()
@property (weak, nonatomic) IBOutlet Checkbox* checkbox1;
@property (weak, nonatomic) IBOutlet Checkbox* checkbox2;
@property (weak, nonatomic) IBOutlet UIView* checkboxFrame;

@property (weak, nonatomic) IBOutlet RadioButtons* radioButtons;
@property (weak, nonatomic) IBOutlet UIView* radioButtonFrame;

@end

@implementation CheckboxAndRadioButtonViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Checkbox and RadioButton";
    
    self.checkboxFrame.layer.borderColor = [[UIColor grayColor] CGColor];
    self.checkboxFrame.layer.borderWidth = 1;
    self.checkboxFrame.layer.cornerRadius = 6;
    
    self.radioButtonFrame.layer.borderColor = [[UIColor grayColor] CGColor];
    self.radioButtonFrame.layer.borderWidth = 1;
    self.radioButtonFrame.layer.cornerRadius = 6;
    
    [self.radioButtons setChangedOnOffButtonCallback:^(OnOffButton *inOnButton) {
        switch (inOnButton.tag) {
            case RADIO_BUTTON_1:
                break;
            case RADIO_BUTTON_2:
                break;
        }
    }];
    
    [self.radioButtons changeSelectedId:RADIO_BUTTON_1];
}

@end
