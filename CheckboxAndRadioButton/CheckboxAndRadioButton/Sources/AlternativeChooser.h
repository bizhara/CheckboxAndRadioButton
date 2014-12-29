//
//  AlternativeChooser.h
//  CheckboxAndRadioButton
//
//  Created by hara on 2014/12/30.
//  Copyright (c) 2014年 Kazuaki Hara. All rights reserved.
//

#import "OnOffButton.h"

/** 単体択一ボタン
 *  ＊各ボタンを識別するのに tag 値を使用するので設定を忘れずに
 */
@interface AlternativeChooserItem : OnOffButton

@end

/** 択一ボタン（の集合）
 *  ＊サブビューに各 AlternativeChooserItem を持っているという前提
 */
@interface AlternativeChooser : UIView
@property (assign, nonatomic) NSInteger selectedButtonId;

/// 初期化のため、使用前に必ず呼ぶこと
- (void)setup:(void (^)(OnOffButton* inOnButton))cbChangedOnOffButton;

/// 選択ボタンの変更
- (void)changeSelectedId:(NSInteger)inSelectedId;

/// 有効無効状態の変更
- (void)changeEnabled:(BOOL)inEnabled;

@end
