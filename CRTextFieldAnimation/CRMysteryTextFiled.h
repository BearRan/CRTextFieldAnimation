//
//  CRMysteryTextFiled.h
//  CRTextFieldAnimation
//
//  Created by Bear on 2017/5/26.
//  Copyright © 2017年 Bear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CRMysteryTFModel.h"
#import "CRMysteryTFAndTitleView.h"
@class CRMysteryTextFiled;

@protocol CRTextFiledDelegate <NSObject>

- (void)CRTextFieldFrameDidChanged:(CRMysteryTextFiled *)crTextField;
- (void)CRTextFieldDidClickConfirmBtn:(CRMysteryTextFiled *)crTextField;

@end

@interface CRMysteryTextFiled : UIView

@property (strong, nonatomic) CRMysteryTFModel *crMysteryTFModel;
@property (weak, nonatomic) id <CRTextFiledDelegate> delegate;
@property (strong, nonatomic) CRMysteryTFAndTitleView *mysteryTFAndTitleView;

- (instancetype)initWithMinFrame:(CGRect)frame maxWidth:(CGFloat)maxWidth;
- (void)setCurrentWidth:(CGFloat)currentWidth;

- (instancetype)initWithFrame:(CGRect)frame UNAVAILABLE_ATTRIBUTE;
- (instancetype)init UNAVAILABLE_ATTRIBUTE;
+ (instancetype)new UNAVAILABLE_ATTRIBUTE;

@end
