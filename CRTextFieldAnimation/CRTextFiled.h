//
//  CRTextFiled.h
//  CRTextFieldAnimation
//
//  Created by Bear on 2017/5/26.
//  Copyright © 2017年 Bear. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CRTextFiled;

@protocol CRTextFiledDelegate <NSObject>

- (void)CRTextFieldFrameDidChanged:(CRTextFiled *)crTextField;

@end

@interface CRTextFiled : UIView

@property (assign, nonatomic) CGFloat maxWidth;
@property (weak, nonatomic) id <CRTextFiledDelegate> delegate;

- (instancetype)initWithMinFrame:(CGRect)frame;

- (instancetype)initWithFrame:(CGRect)frame UNAVAILABLE_ATTRIBUTE;
- (instancetype)init UNAVAILABLE_ATTRIBUTE;
+ (instancetype)new UNAVAILABLE_ATTRIBUTE;

@end
