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

@interface CRMysteryTFContentView () <CRTextFiledDelegate>
{
    CGFloat _minWidth;
    CGFloat _maxWidth;
}

@end

@implementation CRMysteryTFContentView

- (instancetype)initWithMinFrame:(CGRect)frame maxWidth:(CGFloat)maxWidth
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        _minWidth = self.width;
        _maxWidth = maxWidth;
        
        CRMysteryTextFiled *_crTextFiled = [[CRMysteryTextFiled alloc] initWithMinFrame:CGRectMake(0, 0, 213, 63) maxWidth:300];
        _crTextFiled.delegate = self;
        [self addSubview:_crTextFiled];
        [_crTextFiled BearSetCenterToParentViewWithAxis:kAXIS_X_Y];
    }
    
    return self;
}

#pragma mark - CRTextFiledDelegate
- (void)CRTextFieldFrameDidChanged:(CRMysteryTextFiled *)crTextField
{
    self.frame = crTextField.bounds;
    
    if ([_delegate respondsToSelector:@selector(CRMysteryTFContentViewFrameDidChanged:)]) {
        [_delegate CRMysteryTFContentViewFrameDidChanged:self];
    }
}

@end
