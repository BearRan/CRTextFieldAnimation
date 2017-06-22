//
//  CRMysteryTextFiled.h
//  CRTextFieldAnimation
//
//  Created by Bear on 2017/5/26.
//  Copyright © 2017年 Bear. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CRMysteryTextFiled;

@protocol CRTextFiledDelegate <NSObject>

- (void)CRTextFieldFrameDidChanged:(CRMysteryTextFiled *)crTextField;

@end

@interface CRMysteryTextFiled : UIView

@property (weak, nonatomic) id <CRTextFiledDelegate> delegate;

- (instancetype)initWithMinFrame:(CGRect)frame maxWidth:(CGFloat)maxWidth;

- (instancetype)initWithFrame:(CGRect)frame UNAVAILABLE_ATTRIBUTE;
- (instancetype)init UNAVAILABLE_ATTRIBUTE;
+ (instancetype)new UNAVAILABLE_ATTRIBUTE;

@end
