//
//  CRTFConfirmBtn.m
//  CRTextFieldAnimation
//
//  Created by Bear on 2017/5/26.
//  Copyright © 2017年 Bear. All rights reserved.
//

#import "CRTFConfirmBtn.h"
#import "CRTextFieldDefines.h"
#import "CRTextFieldDefines.h"

@interface CRTFConfirmBtn ()
{
    UIImageView *_arrowImageV;
}

@end

@implementation CRTFConfirmBtn

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self createUI];
    }
    
    return self;
}

- (void)createUI
{
    self.backgroundColor = CRTFBtnColor;
    self.layer.cornerRadius = self.height / 2.0;
    
    _arrowImageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CRTFArrow_ICON"]];
    [self addSubview:_arrowImageV];
    [_arrowImageV BearSetCenterToParentViewWithAxis:kAXIS_X_Y];
}

@end
