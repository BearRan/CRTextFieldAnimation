//
//  CRMysteryTFContentView.h
//  CRTextFieldAnimation
//
//  Created by Bear on 2017/6/21.
//  Copyright © 2017年 Bear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CRMysteryTFModel.h"
#import "CRMysteryTextFiled.h"
@class CRMysteryTFContentView;

@protocol CRMysteryTFContentViewDelegate <NSObject>

- (void)CRMysteryTFContentViewFrameDidChanged:(CRMysteryTFContentView *)crMysteryTFContentView;
- (void)CRMysteryTFContentViewDidClickConfirmBtn:(CRMysteryTextFiled *)crTextField;

@end

@interface CRMysteryTFContentView : UIView

@property (weak, nonatomic) id <CRMysteryTFContentViewDelegate> delegate;
@property (strong, nonatomic) NSMutableArray <CRMysteryTFModel *> *crMysteryTFModels;

- (instancetype)initWithMinFrame:(CGRect)frame maxWidth:(CGFloat)maxWidth;
- (void)reloadData;
- (void)showNextMysteryTextFieldAnimation;

@end
