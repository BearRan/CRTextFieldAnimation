//
//  CRMysteryTFContentView.m
//  CRTextFieldAnimation
//
//  Created by Bear on 2017/6/21.
//  Copyright © 2017年 Bear. All rights reserved.
//

#import "CRMysteryTFContentView.h"
#import "CRTextFieldDefines.h"
#import "CRMysteryTextFiled.h"
#import "BearSeesawManager.h"

@interface CRMysteryTFContentView () <CRTextFiledDelegate>
{
    CGFloat _minWidth;
    CGFloat _maxWidth;
    BearSeesawManager *_seesawManager;
    NSInteger _currentIndex;
    UILabel *_pureLabel;
}

@end

@implementation CRMysteryTFContentView

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
    
    _currentIndex = 0;
    
    _seesawManager = [[BearSeesawManager alloc] init];
}

- (void)createUI
{
    self.layer.cornerRadius = self.height / 2.0;
    self.layer.borderWidth = CRTFBorderWidth;
    self.layer.borderColor = CRTFLightColor.CGColor;
    
    _pureLabel = [UILabel new];
    _pureLabel.textColor = [UIColor whiteColor];
    _pureLabel.font = FontSize_6(20);
    [self addSubview:_pureLabel];
}

#pragma mark - Animate
- (void)showNext
{
    __weak typeof(self) weakSelf = self;
    
    [self hideCurrentMysteryTextFieldAnimationCompletion:^{
        [weakSelf showNextMysteryTextFieldAnimation];
    }];
}

- (void)hideCurrentMysteryTextFieldAnimationCompletion:(void (^)())completion
{
    CRMysteryTextFiled *crTextFiledCurrent = [_seesawManager getObjectWithType:BearSeesawObjectTypeCurrent];
    [UIView animateWithDuration:2.0 animations:^{
        [crTextFiledCurrent setX:self.width];
    } completion:^(BOOL finished) {
        [crTextFiledCurrent removeFromSuperview];
        
        if (completion) {
            completion();
        }
    }];
}

- (void)showNextMysteryTextFieldAnimation
{
    if (_currentIndex < [_crMysteryTFModels count] - 1) {
        [_seesawManager exchangeObject];
        _currentIndex++;
        
        CRMysteryTextFiled *crTextFiled;
        id tempObj = [_seesawManager getObjectWithType:BearSeesawObjectTypeCurrent];
        if ([tempObj isKindOfClass:[CRMysteryTextFiled class]]) {
            crTextFiled = tempObj;
            crTextFiled.crMysteryTFModel = _crMysteryTFModels[_currentIndex];
        }else{
            crTextFiled = [self generateMysteryTextFieldWithModel:_crMysteryTFModels[_currentIndex]];
        }
        
        [self addSubview:crTextFiled];
        [crTextFiled BearSetCenterToParentViewWithAxis:kAXIS_X_Y];
        [_seesawManager setObject:crTextFiled withType:BearSeesawObjectTypeCurrent];
    }
}

- (void)defaultSuccessAniamtionCompletion:(void (^)())completion
{
    
}

- (void)showStartTitleAniamtionWithString:(NSString *)string completion:(void (^)())completion
{
    _pureLabel.text = [NSString stringWithFormat:@"%@", string];
    [_pureLabel sizeToFit];
    [_pureLabel BearSetCenterToParentViewWithAxis:kAXIS_X_Y];
    _pureLabel.alpha = 0;
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.25 animations:^{
        _pureLabel.alpha = 1;
        [weakSelf setWidth_DonotMoveCenter:_pureLabel.width + 80];
        [_pureLabel BearSetCenterToParentViewWithAxis:kAXIS_X_Y];
    } completion:^(BOOL finished) {
        if (completion) {
            completion();
        }
    }];
}

#pragma mark - Generate
- (CRMysteryTextFiled *)generateMysteryTextFieldWithModel:(CRMysteryTFModel *)crMysteryTFModel
{
    CRMysteryTextFiled *crTextFiled = [[CRMysteryTextFiled alloc] initWithMinFrame:CGRectMake(0, 0, _minWidth, self.height) maxWidth:_maxWidth];
    crTextFiled.crMysteryTFModel = crMysteryTFModel;
    crTextFiled.delegate = self;
    return crTextFiled;
}

#pragma mark - CRTextFiledDelegate
- (void)CRTextFieldFrameDidChanged:(CRMysteryTextFiled *)crTextField
{
    self.frame = crTextField.bounds;
    
    if ([_delegate respondsToSelector:@selector(CRMysteryTFContentViewFrameDidChanged:)]) {
        [_delegate CRMysteryTFContentViewFrameDidChanged:self];
    }
}

- (void)CRTextFieldDidClickConfirmBtn:(CRMysteryTextFiled *)crTextField
{
    if ([_delegate respondsToSelector:@selector(CRMysteryTFContentViewDidClickConfirmBtn:)]) {
        [_delegate CRMysteryTFContentViewDidClickConfirmBtn:crTextField];
    }
}

#pragma mark - Setter & Getter
- (void)setCrMysteryTFModels:(NSMutableArray<CRMysteryTFModel *> *)crMysteryTFModels
{
    _crMysteryTFModels = crMysteryTFModels;
}

- (void)reloadDataAndShowMysteryField
{
    CRMysteryTextFiled *crTextFiled;
    id tempObj = [_seesawManager getObjectWithType:BearSeesawObjectTypeCurrent];
    if ([tempObj isKindOfClass:[CRMysteryTextFiled class]]) {
        crTextFiled = tempObj;
        crTextFiled.crMysteryTFModel = _crMysteryTFModels[_currentIndex];
    }else{
        crTextFiled = [self generateMysteryTextFieldWithModel:_crMysteryTFModels[_currentIndex]];
    }

    [self addSubview:crTextFiled];
    [crTextFiled BearSetCenterToParentViewWithAxis:kAXIS_X_Y];
    [_seesawManager setObject:crTextFiled withType:BearSeesawObjectTypeCurrent];
}

@end
