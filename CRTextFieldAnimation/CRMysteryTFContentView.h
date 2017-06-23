//
//  CRMysteryTFContentView.h
//  CRTextFieldAnimation
//
//  Created by Bear on 2017/6/21.
//  Copyright © 2017年 Bear. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CRMysteryTFContentView;

@protocol CRMysteryTFContentViewDelegate <NSObject>

- (void)CRMysteryTFContentViewFrameDidChanged:(CRMysteryTFContentView *)crMysteryTFContentView;

@end

@interface CRMysteryTFContentView : UIView

@property (weak, nonatomic) id <CRMysteryTFContentViewDelegate> delegate;

- (instancetype)initWithMinFrame:(CGRect)frame maxWidth:(CGFloat)maxWidth;

@end
