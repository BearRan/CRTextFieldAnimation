//
//  CRMysteryTextFiled.m
//  CRTextFieldAnimation
//
//  Created by Bear on 2017/5/26.
//  Copyright © 2017年 Bear. All rights reserved.
//

#import "CRMysteryTextFiled.h"
#import "CRTextFieldDefines.h"
#import "CRTFIconView.h"
#import "CRTFConfirmBtn.h"
#import <POP/POP.h>

typedef NS_ENUM(NSInteger, CRTFCaculateType) {
    CRTFCaculateTypeTFMinWidth,
    CRTFCaculateTypeTFMaxWidth,
    CRTFCaculateTypeSelfWidth,
};

@interface CRMysteryTextFiled () <CRMysteryTFAndTitleViewDelegate>
{
    CRTFIconView *_tfIconView;
    CRTFConfirmBtn *_tfConfirmBtn;
    
    CGFloat _gapX;
    CGFloat _ratioX;
    CGFloat _ratioY;
    
    CGFloat _tfIconViewWidth;
    CGFloat _confirmBtnWidth;
    CGFloat _textFieldHeight;
    
    CGFloat _minWidth;
    CGFloat _maxWidth;
}

@end

@implementation CRMysteryTextFiled

- (instancetype)initWithMinFrame:(CGRect)frame maxWidth:(CGFloat)maxWidth
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        _minWidth = self.width;
        _maxWidth = maxWidth;
        
        [self initPara];
        [self createUI];
        
//        __weak typeof(self) weakSelf = self;
//        [BearConstants delayAfter:2.0 dealBlock:^{
//            [weakSelf iconViewFadeOutAniamtion];
//        }];
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
}

- (void)createUI
{
    _tfIconView = [[CRTFIconView alloc] initWithFrame:CGRectMake(0, 0, _tfIconViewWidth, _tfIconViewWidth)];
    [self addSubview:_tfIconView];
    
    _tfConfirmBtn = [[CRTFConfirmBtn alloc] initWithFrame:CGRectMake(0, 0, _confirmBtnWidth, _confirmBtnWidth)];
    [_tfConfirmBtn addTarget:self action:@selector(confirmBtnEvent) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_tfConfirmBtn];
    _tfConfirmBtn.center = CGPointMake(self.width - _tfIconViewWidth / 2.0, self.height / 2.0);
    
    
    CGFloat textFieldMaxWith = [self caculateParaWithType:CRTFCaculateTypeTFMaxWidth];
    CGFloat textFieldMinWith = [self caculateParaWithType:CRTFCaculateTypeTFMinWidth];
    
    _mysteryTFAndTitleView = [[CRMysteryTFAndTitleView alloc] initWithMinFrame:CGRectMake(_tfIconView.maxX + _gapX, 0, textFieldMinWith, self.height) maxWidth:textFieldMaxWith];
    _mysteryTFAndTitleView.delegate = self;
    [self addSubview:_mysteryTFAndTitleView];
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
            resultValue = _maxWidth - leftNeedWidth - rightNeedWidth;
        }
            break;
            
        case CRTFCaculateTypeSelfWidth:
        {
            resultValue = _mysteryTFAndTitleView.width + leftNeedWidth + rightNeedWidth;
        }
            break;
            
        default:
            break;
    }
    
    return resultValue;
}

#pragma mark - Event
- (void)confirmBtnEvent
{
    if ([_delegate respondsToSelector:@selector(CRTextFieldDidClickConfirmBtn:)]) {
        [_delegate CRTextFieldDidClickConfirmBtn:self];
    }
}

#pragma mark - CRMysteryTFAndTitleViewDelegate
- (void)mysteryTFAndTitleViewFrameDidChanged:(CRMysteryTFAndTitleView *)mysteryTFAndTitleView
{
    [self relayUI];
}

#pragma mark - Animation
- (void)iconViewFadeOutAniamtion
{
    POPBasicAnimation *basicAniamtion = [POPBasicAnimation animation];
    basicAniamtion.property = [POPAnimatableProperty propertyWithName:kPOPLayerPositionX];
    basicAniamtion.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    basicAniamtion.toValue = @(self.width);
    [_tfIconView.layer pop_addAnimation:basicAniamtion forKey:nil];
}

#pragma mark - Setter & Getter
- (void)setCrMysteryTFModel:(CRMysteryTFModel *)crMysteryTFModel
{
    _crMysteryTFModel = crMysteryTFModel;
    
    if (crMysteryTFModel.iconImage) {
        [_tfIconView setIconImage:crMysteryTFModel.iconImage];
    }
    
    _mysteryTFAndTitleView.titleLabel.text = [NSString stringWithFormat:@"%@", crMysteryTFModel.titleStr];
    [_mysteryTFAndTitleView cleanTextField];
}

@end
