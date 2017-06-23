//
//  CRMysteryTFAndTitleView.m
//  CRTextFieldAnimation
//
//  Created by Bear on 2017/6/21.
//  Copyright © 2017年 Bear. All rights reserved.
//

#import "CRMysteryTFAndTitleView.h"
#import "CRTextFieldDefines.h"

@interface CRMysteryTFAndTitleView ()
{
    CGFloat _minWidth;
    CGFloat _maxWidth;
    CGFloat _textFieldHeight;
    CGFloat _ratioY;
}

@end

@implementation CRMysteryTFAndTitleView

- (instancetype)initWithMinFrame:(CGRect)frame maxWidth:(CGFloat)maxWidth
{
    self = [super initWithFrame:frame];
    
    if (self) {
        _minWidth = self.width;
        _maxWidth = maxWidth;
        
        [self initPara];
        [self createUI];
    }
    
    return self;
}

- (void)initPara
{
    _ratioY = self.height / 63.0;
    _textFieldHeight = 30 * _ratioY;
}

- (void)createUI
{
    _titleLabel = [UILabel new];
    _titleLabel.text = @" ";
    _titleLabel.font = [UIFont systemFontOfSize:10];
    _titleLabel.textColor = CRTFTitleLabelColor;
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    [_titleLabel sizeToFit];
    [_titleLabel setWidth:self.width];
    [self addSubview:_titleLabel];
    
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(_titleLabel.x, 0, self.width, _textFieldHeight)];
    _textField.textColor = CRTFTextFieldColor;
    [_textField addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
    [self addSubview:_textField];
    
    [UIView BearV2AutoLayViewArray:(NSMutableArray *)@[_titleLabel, _textField] layoutAxis:kLAYOUT_AXIS_Y alignmentType:kSetAlignmentType_Idle alignmentOffDis:0 gapAray:@[@7, @2, @5]];
}

#pragma mark - Event
- (void)textFieldDidChanged:(UITextField *)tf
{
    [tf sizeToFit];
    if (tf.width < _minWidth) {
        [tf setWidth:_minWidth];
    }else if (tf.width > _maxWidth) {
        [tf setWidth:_maxWidth];
    }
    [self setWidth:tf.width];
    [_titleLabel setWidth:self.width];
    
    if ([_delegate respondsToSelector:@selector(mysteryTFAndTitleViewFrameDidChanged:)]) {
        [_delegate mysteryTFAndTitleViewFrameDidChanged:self];
    }
}


@end
