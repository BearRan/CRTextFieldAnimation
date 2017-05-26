//
//  CRTFConfirmBtn.m
//  CRTextFieldAnimation
//
//  Created by Bear on 2017/5/26.
//  Copyright © 2017年 Bear. All rights reserved.
//

#import "CRTFConfirmBtn.h"
#import "CRTextFieldDefines.h"

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
}

@end
