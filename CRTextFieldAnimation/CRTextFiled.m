//
//  CRTextFiled.m
//  CRTextFieldAnimation
//
//  Created by Bear on 2017/5/26.
//  Copyright © 2017年 Bear. All rights reserved.
//

#import "CRTextFiled.h"
#import <BearSkill/UIView+BearSet.h>
#import <BearSkill/BearConstants.h>

#define lightColor UIColorFromHEX(0xCECECE)

@interface CRTextFiled ()
{
//    UIView *leftIcon
}

@end

@implementation CRTextFiled

- (instancetype)initWithMaxFrame:(CGRect)frame
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
    self.layer.borderWidth = 1;
    self.layer.borderColor = lightColor.CGColor;
}

@end
