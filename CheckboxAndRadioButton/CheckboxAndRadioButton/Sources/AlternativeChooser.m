//
//  AlternativeChooser.m
//  CheckboxAndRadioButton
//
//  Created by hara on 2014/12/30.
//  Copyright (c) 2014年 Kazuaki Hara. All rights reserved.
//

#import "AlternativeChooser.h"

@interface AlternativeChooser ()
- (void)changedAlternativeButton:(AlternativeChooserItem*)inAlternativeButton;

@end

#pragma mark - AlternativeChooserItem

@implementation AlternativeChooserItem

- (void)changeSelected:(BOOL)inSelected
{
    [super changeSelected:inSelected];
    
    // 選択状態に変化（択一ボタンは OFF → ON のみ）があったら、択一ボタングループを管理するクラスに通知
    AlternativeChooser* owner = (AlternativeChooser*)self.superview;
    [owner changedAlternativeButton:self];
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

#pragma mark - AlternativeChooser

@implementation AlternativeChooser

- (void)setup:(void (^)(OnOffButton* inOnButton))cbChangedOnOffButton
{
    for (UIView* subView in self.subviews) {
        if ([subView isKindOfClass:[AlternativeChooserItem class]]) {
            [((AlternativeChooserItem*)subView) setup:cbChangedOnOffButton];
        }
    }
}

- (void)changeSelectedId:(NSInteger)inSelectedId
{
    // 今まで ON のものを OFF にし、OFF のものを ON にする
    AlternativeChooserItem* lastSelected = [self findAlternativeButtonBy:self.selectedButtonId];
    if (lastSelected) {
        [lastSelected changeSelected:NO];
    }
    
    AlternativeChooserItem* nextSelecting = [self findAlternativeButtonBy:inSelectedId];
    [nextSelecting changeSelected:YES];
    
    // ON にしたものの ID を記録
    self.selectedButtonId = inSelectedId;
}

- (void)changedAlternativeButton:(AlternativeChooserItem*)inAlternativeButton
{
    // 今まで ON のものを OFF にし、新しく ON になったものを記録
    AlternativeChooserItem* lastSelected = [self findAlternativeButtonBy:self.selectedButtonId];
    if (lastSelected != inAlternativeButton) {
        [lastSelected changeSelected:!lastSelected.selected];
        
        self.selectedButtonId = inAlternativeButton.tag;
    }
}

- (AlternativeChooserItem*)findAlternativeButtonBy:(NSInteger)inAlternativeButtonId
{
    // tag 値が一致するものを探す
    for (UIView* subView in self.subviews) {
        if ([subView isKindOfClass:[AlternativeChooserItem class]]) {
            if (subView.tag == inAlternativeButtonId) {
                return (AlternativeChooserItem*)subView;
            }
        }
    }
    return nil;
}

- (void)changeEnabled:(BOOL)inEnabled
{
    for (UIView* subView in self.subviews) {
        if ([subView isKindOfClass:[AlternativeChooserItem class]]) {
            AlternativeChooserItem* alternativeButton = (AlternativeChooserItem*)subView;
            [alternativeButton changeEnabled:inEnabled];
        }
    }
}

@end
