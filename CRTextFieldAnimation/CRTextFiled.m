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

@interface CRTextFiled ()
{
    CRTFIconView *_tfIconView;
    CRTFConfirmBtn *_tfConfirmBtn;
    UILabel *_titleLabel;
    UITextField *_textField;
    CGFloat _gapX;
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
    _gapX = 15;
    self.layer.cornerRadius = self.height / 2.0;
    self.layer.borderWidth = CRTFBorderWidth;
    self.layer.borderColor = CRTFLightColor.CGColor;
    
    CGFloat tfIconViewWidth = self.height;
    CGFloat confirmBtnWidth = 34;
    CGFloat textFieldHeight = 30;
    
    _tfIconView = [[CRTFIconView alloc] initWithFrame:CGRectMake(0, 0, tfIconViewWidth, tfIconViewWidth)];
    [self addSubview:_tfIconView];
    
    _tfConfirmBtn = [[CRTFConfirmBtn alloc] initWithFrame:CGRectMake(0, 0, confirmBtnWidth, confirmBtnWidth)];
    [self addSubview:_tfConfirmBtn];
    _tfConfirmBtn.center = CGPointMake(self.width - tfIconViewWidth / 2.0, self.height / 2.0);
    
    _titleLabel = [UILabel new];
    _titleLabel.text = @"Name";
    _titleLabel.font = [UIFont systemFontOfSize:10];
    _titleLabel.textColor = CRTFTitleLabelColor;
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    [_titleLabel sizeToFit];
    [_titleLabel setX:_tfIconView.maxX + _gapX];
    [_titleLabel setMaxX_DontMoveMinX:_tfConfirmBtn.x - _gapX];
    [self addSubview:_titleLabel];
    
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(_titleLabel.x, 0, _titleLabel.width, textFieldHeight)];
    [self addSubview:_textField];
    
    [UIView BearV2AutoLayViewArray:(NSMutableArray *)@[_titleLabel, _textField] layoutAxis:kLAYOUT_AXIS_Y alignmentType:kSetAlignmentType_Idle alignmentOffDis:0 gapAray:@[@7, @2, @5]];
}

@end
