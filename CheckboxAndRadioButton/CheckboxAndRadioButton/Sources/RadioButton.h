//
//  RadioButton.h
//  CheckboxAndRadioButton
//
//  Created by hara on 2014/08/08.
//  Copyright (c) 2014年 Kazuaki Hara. All rights reserved.
//

#import "OnOffButton.h"

/** 単体ラジオボタン
 *  ＊各ボタンを識別するのに tag 値を使用するので設定を忘れずに
 */
@interface RadioButton : OnOffButton

@end

/** （実際に使う）ラジオボタン
 *  ＊サブビューに各 RadioButton を持っているという前提
 */
@interface RadioButtons : UIView
@property (assign, nonatomic) NSInteger selectedRadioButtonId;

/// 初期化のため、使用前に必ず呼ぶこと
- (void)setup:(id<OnOffButtonDelegate>)inDelegate;

/// 選択ラジオボタンの変更
- (void)changeSelectedId:(NSInteger)inSelectedId;

/// 有効無効状態の変更
- (void)changeEnabled:(BOOL)inEnabled;

@end