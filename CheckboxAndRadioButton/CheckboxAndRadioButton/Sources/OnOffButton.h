//
//  OnOffButton.h
//  CheckboxAndRadioButton
//
//  Created by hara on 2014/08/08.
//  Copyright (c) 2014年 Kazuaki Hara. All rights reserved.
//

#import <UIKit/UIKit.h>

/** ラジオボタンやチェックボックスのように「イメージ＋文言」で表現され、On/Off の状態を持つものを制御する
 *
 *  ＊以下の構成を前提とする
 *  ┌OnOffButton───────────────┐
 *    ┌UIButton─┐┌UILabel────────┐
 *    └──────┘└────────────┘
 *  └──────────────────────┘
 *  ＊位置や大きさ・見かけは、nib などであらかじめ定義されていること
 */
@interface OnOffButton : UIView
@property (weak, nonatomic) IBOutlet UIButton* onOffImage;
@property (weak, nonatomic) IBOutlet UILabel* onOffTitle;

@property (copy, nonatomic) void (^onChangedOnOffButton)(OnOffButton* inOnButton);

@property (assign, nonatomic) BOOL selected;
@property (assign, nonatomic) BOOL enabled;
@property (assign, nonatomic) BOOL highlighted;

/// 選択状態の変更
- (void)changeSelected:(BOOL)inSelected;

/// ハイライト状態の変更
- (void)changeHighlighted:(BOOL)inHighlighted;

/// 有効無効状態の変更
- (void)changeEnabled:(BOOL)inEnabled;

@end
