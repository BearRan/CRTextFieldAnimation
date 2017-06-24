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
}

@end

@implementation CRMysteryTFContentView

- (instancetype)initWithMinFrame:(CGRect)frame maxWidth:(CGFloat)maxWidth
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        _minWidth = self.width;
        _maxWidth = maxWidth;
        _currentIndex = 0;
        
        _seesawManager = [[BearSeesawManager alloc] init];
        
        self.layer.cornerRadius = self.height / 2.0;
        self.layer.borderWidth = CRTFBorderWidth;
        self.layer.borderColor = CRTFLightColor.CGColor;
    }
    
    return self;
}

#pragma mark - Animate
- (void)showNextMysteryTextFieldAnimation
{
    CRMysteryTextFiled *crTextFiledCurrent = [_seesawManager getObjectWithType:BearSeesawObjectTypeCurrent];
    [UIView animateWithDuration:2.0 animations:^{
        [crTextFiledCurrent setX:self.width];
    } completion:^(BOOL finished) {
        
        [crTextFiledCurrent removeFromSuperview];
        
        if (_currentIndex <= [_crMysteryTFModels count] - 1) {
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
        
    }];
}

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

- (void)reloadData
{
    CRMysteryTextFiled *crTextFiled = [self generateMysteryTextFieldWithModel:_crMysteryTFModels[_currentIndex]];
    [self addSubview:crTextFiled];
    [crTextFiled BearSetCenterToParentViewWithAxis:kAXIS_X_Y];
    [_seesawManager setObject:crTextFiled withType:BearSeesawObjectTypeCurrent];
}

@end
