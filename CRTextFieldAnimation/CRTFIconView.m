//
//  CRTFIconView.m
//  CRTextFieldAnimation
//
//  Created by Bear on 2017/5/26.
//  Copyright © 2017年 Bear. All rights reserved.
//

#import "CRTFIconView.h"
#import "CRTextFieldDefines.h"

@implementation CRTFIconView

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
    self.layer.cornerRadius = self.height / 2.0;
    self.layer.borderColor = CRTFLightColor.CGColor;
    self.layer.borderWidth = CRTFBorderWidth;
}

@end
