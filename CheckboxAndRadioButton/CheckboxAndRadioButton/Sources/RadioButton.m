//
//  RadioButton.m
//  CheckboxAndRadioButton
//
//  Created by hara on 2014/08/08.
//  Copyright (c) 2014年 Kazuaki Hara. All rights reserved.
//

#import "RadioButton.h"

@interface RadioButtons ()
- (void)changedRadioButton:(RadioButton*)inRadioButton;

@end

#pragma mark - RadioButton

@implementation RadioButton

- (void)changeSelected:(BOOL)inSelected
{
    [super changeSelected:inSelected];
    
    // 選択状態に変化（ラジオボタンは OFF → ON のみ）があったら、ラジオボタングループを管理するクラスに通知
    RadioButtons* owner = (RadioButtons*)self.superview;
    [owner changedRadioButton:self];
}

- (void)changeHighlighted:(BOOL)inHighlighted
{
    // 反応するのは、未選択のもののみ
    // タッチの開始時にハイライトを ON にし、終了時にそのハイライト状態でタッチ終了箇所を判別しているので、
    // こうしておけば、未選択のものへのタッチのみ画面上も選択状態上も変化が起きない
    if (!self.selected) {
        [super changeHighlighted:inHighlighted];
    }
}

@end

#pragma mark - RadioButtons

@implementation RadioButtons

- (void)setup:(void (^)(OnOffButton* inOnButton))cbChangedOnOffButton
{
    for (UIView* subView in self.subviews) {
        if ([subView isKindOfClass:[RadioButton class]]) {
            [((RadioButton*)subView) setup:cbChangedOnOffButton];
        }
    }
}

- (void)changeSelectedId:(NSInteger)inSelectedId
{
    // 今まで ON のものを OFF にし、OFF のものを ON にする
    RadioButton* lastSelected = [self findRadioButtonBy:self.selectedRadioButtonId];
    if (lastSelected) {
        [lastSelected changeSelected:NO];
    }
    
    RadioButton* nextSelecting = [self findRadioButtonBy:inSelectedId];
    [nextSelecting changeSelected:YES];
    
    // ON にしたものの ID を記録
    self.selectedRadioButtonId = inSelectedId;
}

- (void)changedRadioButton:(RadioButton*)inRadioButton
{
    // 今まで ON のものを OFF にし、新しく ON になったものを記録
    RadioButton* lastSelected = [self findRadioButtonBy:self.selectedRadioButtonId];
    if (lastSelected != inRadioButton) {
        [lastSelected changeSelected:!lastSelected.selected];
        
        self.selectedRadioButtonId = inRadioButton.tag;
    }
}

- (RadioButton*)findRadioButtonBy:(NSInteger)inRadioButtonId
{
    // tag 値が一致するものを探す
    for (UIView* subView in self.subviews) {
        if ([subView isKindOfClass:[RadioButton class]]) {
            if (subView.tag == inRadioButtonId) {
                return (RadioButton*)subView;
            }
        }
    }
    return nil;
}

- (void)changeEnabled:(BOOL)inEnabled
{
    for (UIView* subView in self.subviews) {
        if ([subView isKindOfClass:[RadioButton class]]) {
            RadioButton* radioButton = (RadioButton*)subView;
            [radioButton changeEnabled:inEnabled];
        }
    }
}

@end