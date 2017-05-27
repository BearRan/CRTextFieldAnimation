//
//  CRTextFiled.m
//  CRTextFieldAnimation
//
//  Created by Bear on 2017/5/26.
//  Copyright © 2017年 Bear. All rights reserved.
//

#import "CRTextFiled.h"
#import "CRTextFieldDefines.h"
#import "CRTFIconView.h"
#import "CRTFConfirmBtn.h"

typedef NS_ENUM(NSInteger, CRTFCaculateType) {
    CRTFCaculateTypeTFMinWidth,
    CRTFCaculateTypeTFMaxWidth,
    CRTFCaculateTypeSelfWidth,
};

@interface CRTextFiled ()
{
    CRTFIconView *_tfIconView;
    CRTFConfirmBtn *_tfConfirmBtn;
    UILabel *_titleLabel;
    UITextField *_textField;
    
    CGFloat _gapX;
    CGFloat _ratioX;
    CGFloat _ratioY;
    
    CGFloat _tfIconViewWidth;
    CGFloat _confirmBtnWidth;
    CGFloat _textFieldHeight;
    
    CGFloat _textFieldMaxWith;
    CGFloat _textFieldMinWith;
    CGFloat _minWidth;
}

@end

@implementation CRTextFiled

- (instancetype)initWithMinFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self initPara];
        [self createUI];
    }
    
    return self;
}

- (void)initPara
{
    _ratioX = self.width / 213.0;
    _ratioY = self.height / 63.0;
    _gapX = 15 * _ratioX;
    
    _tfIconViewWidth = self.height;
    _confirmBtnWidth = 34 * _ratioX;
    _textFieldHeight = 30 * _ratioY;
    
    _minWidth = self.width;
    self.maxWidth = self.width;
}

- (void)createUI
{
    self.layer.cornerRadius = self.height / 2.0;
    self.layer.borderWidth = CRTFBorderWidth;
    self.layer.borderColor = CRTFLightColor.CGColor;
    
    _tfIconView = [[CRTFIconView alloc] initWithFrame:CGRectMake(0, 0, _tfIconViewWidth, _tfIconViewWidth)];
    [_tfIconView setIconImage:[UIImage imageNamed:@"CRTFUser_ICON"]];
    [self addSubview:_tfIconView];
    
    _tfConfirmBtn = [[CRTFConfirmBtn alloc] initWithFrame:CGRectMake(0, 0, _confirmBtnWidth, _confirmBtnWidth)];
    [self addSubview:_tfConfirmBtn];
    _tfConfirmBtn.center = CGPointMake(self.width - _tfIconViewWidth / 2.0, self.height / 2.0);
    
    _titleLabel = [UILabel new];
    _titleLabel.text = @"Name";
    _titleLabel.font = [UIFont systemFontOfSize:10];
    _titleLabel.textColor = CRTFTitleLabelColor;
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    [_titleLabel sizeToFit];
    [_titleLabel setX:_tfIconView.maxX + _gapX];
    [_titleLabel setMaxX_DontMoveMinX:_tfConfirmBtn.x - _gapX];
    [self addSubview:_titleLabel];
    
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(_titleLabel.x, 0, _titleLabel.width, _textFieldHeight)];
    _textField.textColor = CRTFTextFieldColor;
    [_textField addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
    [self addSubview:_textField];
    
    [UIView BearV2AutoLayViewArray:(NSMutableArray *)@[_titleLabel, _textField] layoutAxis:kLAYOUT_AXIS_Y alignmentType:kSetAlignmentType_Idle alignmentOffDis:0 gapAray:@[@7, @2, @5]];
}

#pragma mark - RelayUI
- (void)relayUI
{
    CGFloat selfWidth = [self caculateParaWithType:CRTFCaculateTypeSelfWidth];
    
    if (selfWidth != self.width) {
        [self setWidth:selfWidth];
        _tfConfirmBtn.center = CGPointMake(self.width - _tfIconViewWidth / 2.0, self.height / 2.0);
        
        if ([_delegate respondsToSelector:@selector(CRTextFieldFrameDidChanged:)]) {
            [_delegate CRTextFieldFrameDidChanged:self];
        }
    }
}

#pragma mark - Event
- (void)textFieldDidChanged:(UITextField *)tf
{
    [tf sizeToFit];
    if (tf.width < _textFieldMinWith) {
        [tf setWidth:_textFieldMinWith];
    }else if (tf.width > _textFieldMaxWith) {
        [tf setWidth:_textFieldMaxWith];
    }
    
    [self relayUI];
}

- (CGFloat)caculateParaWithType:(CRTFCaculateType)type
{
    CGFloat resultValue = 0;
    CGFloat leftNeedWidth = _tfIconViewWidth + _gapX;
    CGFloat rightNeedWidth = (_confirmBtnWidth + _tfIconViewWidth) / 2.0 + _gapX;
    
    switch (type) {
        case CRTFCaculateTypeTFMinWidth:
        {
            resultValue = _minWidth - leftNeedWidth - rightNeedWidth;
        }
            break;
            
        case CRTFCaculateTypeTFMaxWidth:
        {
            resultValue = self.maxWidth - leftNeedWidth - rightNeedWidth;
        }
            break;
            
        case CRTFCaculateTypeSelfWidth:
        {
            resultValue = _textField.width + leftNeedWidth + rightNeedWidth;
        }
            break;
            
        default:
            break;
    }
    
    return resultValue;
}

#pragma mark - Setter & Getter
- (void)setMaxWidth:(CGFloat)maxWidth
{
    _maxWidth = maxWidth;
    
    _textFieldMaxWith = [self caculateParaWithType:CRTFCaculateTypeTFMaxWidth];
    _textFieldMinWith = [self caculateParaWithType:CRTFCaculateTypeTFMinWidth];
}

@end
