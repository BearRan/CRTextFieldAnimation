//
//  CRTFIconView.m
//  CRTextFieldAnimation
//
//  Created by Bear on 2017/5/26.
//  Copyright © 2017年 Bear. All rights reserved.
//

#import "CRTFIconView.h"
#import "CRTextFieldDefines.h"

@interface CRTFIconView ()

@property (strong, nonatomic) UIImageView *iconImageV;

@end

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
    
    self.iconImageV = [UIImageView new];
    [self addSubview:self.iconImageV];
}

#pragma mark - Setter 
- (void)setIconImage:(UIImage *)iconImage
{
    self.iconImageV.image = iconImage;
    
    [self.iconImageV sizeToFit];
    
    CGFloat scaleRatio = 1.4;
    self.iconImageV.size = CGSizeMake(self.iconImageV.width * scaleRatio, self.iconImageV.height * scaleRatio);
    [self.iconImageV BearSetCenterToParentViewWithAxis:kAXIS_X_Y];
}

@end
