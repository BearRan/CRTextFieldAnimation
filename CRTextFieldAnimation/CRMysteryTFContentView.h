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
- (void)didTapStartTitleEvent:(CRMysteryTFContentView *)crMysteryTFContentView;
- (void)triggerNoNextEvent:(CRMysteryTFContentView *)crMysteryTFContentView;

@end

@interface CRMysteryTFContentView : UIView

@property (weak, nonatomic) id <CRMysteryTFContentViewDelegate> delegate;
@property (strong, nonatomic) NSMutableArray <CRMysteryTFModel *> *crMysteryTFModels;
@property (strong, nonatomic) NSString  *startNoticeStr;
@property (strong, nonatomic) NSString  *finishNoticeStr;

- (instancetype)initWithMinFrame:(CGRect)frame maxWidth:(CGFloat)maxWidth;

- (void)showStartTitleAniamtionWithString:(NSString *)string completion:(void (^)())completion;
- (void)hideStartTitleAniamtionCompletion:(void (^)())completion;
- (void)startFinishTitleAniamtionWithString:(NSString *)string completion:(void (^)())completion;

- (void)reloadDataAndShowMysteryField;
- (void)showNext;

@end
