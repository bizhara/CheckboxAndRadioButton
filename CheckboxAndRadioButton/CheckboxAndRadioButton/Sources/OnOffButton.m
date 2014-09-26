//
//  OnOffButton.m
//  CheckboxAndRadioButton
//
//  Created by hara on 2014/08/08.
//  Copyright (c) 2014年 Kazuaki Hara. All rights reserved.
//

#import "OnOffButton.h"

#pragma mark - OnOffButtonGestureRecognizer

/** OnOffButton へのタッチ動作を制御する
 *  ＊self.view が、OnOffButton
 */
@interface OnOffButtonGestureRecognizer : UIGestureRecognizer

@end

@implementation OnOffButtonGestureRecognizer

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // タッチがあったら、ハイライト状態にする
    OnOffButton* onOffButton = (OnOffButton*)self.view;
    [onOffButton changeHighlighted:YES];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    // タッチしたビューの判別
    UITouch* touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self.view];
    UIView* touchView = [self.view hitTest:touchPoint withEvent:event];
    
    // OnOffButton 内をタッチしていれば、ハイライト ON、そうでなければ、ハイライト OFF
    OnOffButton* onOffButton = (OnOffButton*)self.view;
    [onOffButton changeHighlighted:(touchView == self.view)];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    // タッチが終わった状態を判別できるように、ハイライトの状態をそのままにして OnOffButton の touchesEnded:withEvent: を呼び出す
    [self.view touchesEnded:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

@end

#pragma mark - OnOffButton

@interface OnOffButton ()
@property (weak, nonatomic) IBOutlet UIButton* onOffImage;

@property (copy, nonatomic) void (^changedOnOffButton)(OnOffButton* inOnButton);

@end

@implementation OnOffButton

- (void)setup:(void (^)(OnOffButton* inOnButton))cbChangedOnOffButton
{
    self.changedOnOffButton = cbChangedOnOffButton;
    
    // このボタン全体として反応したいので、全体を囲むこのクラスに GestureRecognizer を付加する
    OnOffButtonGestureRecognizer* gestureRecognizer = [[OnOffButtonGestureRecognizer alloc] init];
    [self addGestureRecognizer:gestureRecognizer];
    // 逆にボタンだけが反応してしまうと想定外なので、ボタン自体は、反応しないようにしておく
    self.onOffImage.userInteractionEnabled = NO;
    
    // デフォルトのハイライトイメージを設定
    [self changeHighlightImage];
    
    self.enabled = YES;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    // OnOffButtonGestureRecognizer は、終了状態判断用にハイライトの状態をそのままにしてこのメソッドを
    // 呼び出すようになっているので、判断用に保持した後は、ハイライトを OFF にしておく必要あり
    BOOL highlighted = self.highlighted;
    [self changeHighlighted:NO];
    
    // タッチがこのオブジェクト内で終わった時のみ選択状態を変える
    if (highlighted) {
        [self changeSelected:!self.selected];
    }
}

- (void)changeSelected:(BOOL)inSelected
{
    // 内部に含まれる ON/OFF イメージと選択状態を同じくする
    self.selected = inSelected;
    self.onOffImage.selected = inSelected;
    
    // 選択状態に応じてハイライトイメージを設定
    [self changeHighlightImage];
    
    // 選択状態に変化があったことを通知
    if (self.changedOnOffButton) self.changedOnOffButton(self);
}

- (void)changeHighlighted:(BOOL)inHighlighted
{
    self.highlighted = inHighlighted;
    self.onOffImage.highlighted = inHighlighted;
}

- (void)changeHighlightImage
{
    // self.onOffImage.selected と逆のイメージをハイライトイメージとする
    // 基本、バックグラウンドイメージを対象とするが、無ければ、フォアグラウンドも対象にする
    UIImage* highlightImage = (self.onOffImage.selected) ?
        [self.onOffImage backgroundImageForState:UIControlStateNormal] :
        [self.onOffImage backgroundImageForState:UIControlStateSelected];
    if (highlightImage) {
        [self.onOffImage setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
    }
    else {
        highlightImage = (self.onOffImage.selected) ?
            [self.onOffImage imageForState:UIControlStateNormal] :
            [self.onOffImage imageForState:UIControlStateSelected];
        [self.onOffImage setImage:highlightImage forState:UIControlStateHighlighted];
    }
}

- (void)changeEnabled:(BOOL)inEnabled
{
    self.enabled = inEnabled;
    self.onOffImage.enabled = inEnabled;
}

@end
