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
    UIView *_mainContentView;
    
    CGFloat _gapX;
    CGFloat _ratioX;
    CGFloat _ratioY;
    
    CGFloat _tfIconViewWidth;
    CGFloat _confirmBtnWidth;
    CGFloat _textFieldHeight;
    
    CGFloat _minWidth;
    CGFloat _maxWidth;
    
    CADisplayLink *_displayLink;
    UIBezierPath *_maskPath;
    CAShapeLayer *_maskLayer;
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
    
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkEvent)];
    [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    _displayLink.paused = YES;
}

- (void)createUI
{
    self.layer.masksToBounds = YES;
    
    _mainContentView = [[UIView alloc] initWithFrame:self.bounds];
    _mainContentView.backgroundColor = [UIColor orangeColor];
    _mainContentView.layer.masksToBounds = YES;
    [self addSubview:_mainContentView];
    
    _tfIconView = [[CRTFIconView alloc] initWithFrame:CGRectMake(0, 0, _tfIconViewWidth, _tfIconViewWidth)];
    [_mainContentView addSubview:_tfIconView];
    
    _tfConfirmBtn = [[CRTFConfirmBtn alloc] initWithFrame:CGRectMake(0, 0, _confirmBtnWidth, _confirmBtnWidth)];
    [_tfConfirmBtn addTarget:self action:@selector(confirmBtnEvent) forControlEvents:UIControlEventTouchUpInside];
    [_mainContentView addSubview:_tfConfirmBtn];
    _tfConfirmBtn.center = CGPointMake(self.width - _tfIconViewWidth / 2.0, self.height / 2.0);
    
    
    CGFloat textFieldMaxWith = [self caculateParaWithType:CRTFCaculateTypeTFMaxWidth];
    CGFloat textFieldMinWith = [self caculateParaWithType:CRTFCaculateTypeTFMinWidth];
    
    _mysteryTFAndTitleView = [[CRMysteryTFAndTitleView alloc] initWithMinFrame:CGRectMake(_tfIconView.maxX + _gapX, 0, textFieldMinWith, self.height) maxWidth:textFieldMaxWith];
    _mysteryTFAndTitleView.delegate = self;
    [_mainContentView addSubview:_mysteryTFAndTitleView];
}

#pragma mark - RelayUI
- (void)relayUI
{
    _tfConfirmBtn.center = CGPointMake(self.width - _tfIconViewWidth / 2.0, self.height / 2.0);
    
    if ([_delegate respondsToSelector:@selector(CRTextFieldFrameDidChanged:)]) {
        [_delegate CRTextFieldFrameDidChanged:self];
    }
}

- (void)autoChangeFrameAndRelayUI
{
    CGFloat selfWidth = [self caculateParaWithType:CRTFCaculateTypeSelfWidth];
    
    if (selfWidth != self.width) {
        [self setMyWidth:selfWidth];
        [self relayUI];
    }
}

- (void)setCurrentWidth:(CGFloat)currentWidth
{
    if (currentWidth > _maxWidth || currentWidth < _minWidth || currentWidth == self.width) {
        return;
    }
    
    [self setMyWidth:currentWidth];
    [self relayUI];
    
}

- (void)setMyWidth:(CGFloat)width
{
    [self setWidth:width];
    [_mainContentView setWidth:width];
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

- (void)displayLinkEvent
{
    [self changeMaskWithX:_tfIconView.layer.frame.origin.x];
}

#pragma mark - CRMysteryTFAndTitleViewDelegate
- (void)mysteryTFAndTitleViewFrameDidChanged:(CRMysteryTFAndTitleView *)mysteryTFAndTitleView
{
    [self autoChangeFrameAndRelayUI];
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

/*
- (void)test
{
    POPAnimatableProperty *prop = [POPAnimatableProperty propertyWithName:@"countdown" initializer:^(POPMutableAnimatableProperty *prop) {
        prop.writeBlock = ^(id obj, const CGFloat values[]) {
            UILabel *lable = (UILabel*)obj;
            label.text = [NSString stringWithFormat:@"d:d:d",(int)values[0]/60,(int)values[0]%60,(int)(values[0]*100)0];
        };
        //        prop.threshold = 0.01f;
    }];
    POPBasicAnimation *anBasic = [POPBasicAnimation linearAnimation];   //秒表当然必须是线性的时间函数
    anBasic.property = prop;    //自定义属性
    anBasic.fromValue = @(0);   //从0开始
    anBasic.toValue = @(3*60);  //180秒
    anBasic.duration = 3*60;    //持续3分钟
    anBasic.beginTime = CACurrentMediaTime() + 1.0f;    //延迟1秒开始
    [label pop_addAnimation:anBasic forKey:@"countdown"];
}
 */

- (void)fadeOutAnimationCompletion:(void (^)())completion
{
    
//    POPDecayAnimation *decayAnimation = [POPDecayAnimation animation];
//    POPAnimatableProperty *prop = [POPAnimatableProperty propertyWithName:@"com.rounak.boundsX" initializer:^(POPMutableAnimatableProperty *prop) {
//        // read value, feed data to Pop
//        prop.readBlock = ^(id obj, CGFloat values[]) {
//            values[0] = [obj bounds].origin.x;
//            values[1] = [obj bounds].origin.y;
//        };
//        // write value, get data from Pop, and apply it to the view
//        prop.writeBlock = ^(id obj, const CGFloat values[]) {
//            CGRect tempBounds = [obj bounds];
//            tempBounds.origin.x = values[0];
//            tempBounds.origin.y = values[1];
//            [obj setBounds:tempBounds];
//        };
//        // dynamics threshold
//        prop.threshold = 0.01;
//    }];
//    
//    decayAnimation.property = prop;
//    decayAnimation.velocity = [NSValue valueWithCGPoint:CGPointMake(100, 00)];
//    [_tfIconView pop_addAnimation:decayAnimation forKey:@"decelerate"];
    
    [self addSubview:_tfIconView];
    POPBasicAnimation *basicAniamtion = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionX];
    basicAniamtion.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    basicAniamtion.fromValue = @(_tfIconView.x + _tfIconView.width / 2.0);
    basicAniamtion.toValue = @(self.width + _tfIconView.width / 2.0);
    basicAniamtion.duration = 5;
    basicAniamtion.beginTime = CACurrentMediaTime() + 1.f;
    basicAniamtion.completionBlock = ^(POPAnimation *anim, BOOL finished) {
        _displayLink.paused = YES;
        [_mainContentView addSubview:_tfIconView];
        [_tfIconView setX:0];
        
        if (completion) {
            completion();
        }
    };
    [_tfIconView.layer pop_addAnimation:basicAniamtion forKey:nil];
    _displayLink.paused = NO;
    
    
    
    
//    POPAnimatableProperty *prop1 = [POPAnimatableProperty propertyWithName:@"1" initializer:^(POPMutableAnimatableProperty *prop) {
//        NSLog(@"--1");
//        prop.writeBlock = ^(id obj, const CGFloat *values) {
//            NSString *str = [NSString stringWithFormat:@"%d:%d:%d", (int)values[0]/60, (int)values[0]%60, (int)(values[0]*100)];
//            NSLog(@"str:%@", str);
//        };
//        
//        prop.readBlock = ^(id obj, CGFloat *values) {
//            NSLog(@"--2");
//        };
//        prop.threshold = 0.01;
//    }];
//    
//    POPBasicAnimation *countDownAnimation = [POPBasicAnimation linearAnimation];
//    countDownAnimation.property = prop1;
//    countDownAnimation.fromValue = @(0);
//    countDownAnimation.toValue = @(1 * 20);
//    countDownAnimation.duration = 1 * 20;
//    countDownAnimation.beginTime = CACurrentMediaTime() + 1.f;
//    
//    
//    UILabel *label = [UILabel new];
//    [self addSubview:label];
//    [_tfIconView.layer pop_addAnimation:countDownAnimation forKey:kPOPLayerPositionX];
    
    
    
    
    
    
}

- (void)changeMaskWithX:(CGFloat)maskX
{
    if (!_maskPath) {
        _maskPath = [UIBezierPath bezierPath];
    }
    [_maskPath removeAllPoints];
    [_maskPath moveToPoint:CGPointMake(maskX, 0)];
    [_maskPath addLineToPoint:CGPointMake(self.width, 0)];
    [_maskPath addLineToPoint:CGPointMake(self.width, self.height)];
    [_maskPath addLineToPoint:CGPointMake(maskX, self.height)];
    [_maskPath closePath];
    
    if (!_maskLayer) {
        _maskLayer = [CAShapeLayer layer];
    }
    _maskLayer.path = _maskPath.CGPath;
    _mainContentView.layer.mask = _maskLayer;
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
