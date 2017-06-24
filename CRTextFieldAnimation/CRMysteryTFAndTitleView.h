//
//  CRMysteryTFAndTitleView.h
//  CRTextFieldAnimation
//
//  Created by Bear on 2017/6/21.
//  Copyright © 2017年 Bear. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CRMysteryTFAndTitleView;

@protocol CRMysteryTFAndTitleViewDelegate <NSObject>

- (void)mysteryTFAndTitleViewFrameDidChanged:(CRMysteryTFAndTitleView *)mysteryTFAndTitleView;

@end

@interface CRMysteryTFAndTitleView : UIView

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UITextField *textField;
@property (weak, nonatomic) id <CRMysteryTFAndTitleViewDelegate> delegate;

- (instancetype)initWithMinFrame:(CGRect)frame maxWidth:(CGFloat)maxWidth;
- (void)cleanTextField;

@end
