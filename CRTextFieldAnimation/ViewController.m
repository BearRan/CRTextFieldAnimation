//
//  ViewController.m
//  CRTextFieldAnimation
//
//  Created by Bear on 2017/5/26.
//  Copyright © 2017年 Bear. All rights reserved.
//

#import "ViewController.h"
#import <BearSkill/UIView+BearSet.h>
#import <BearSkill/BearConstants.h>
#import "CRMysteryTFContentView.h"

@interface ViewController () <CRMysteryTFContentViewDelegate>
{
    CRMysteryTFContentView *_crMysteryTFContentView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
}

- (void)createUI
{
    self.view.backgroundColor = UIColorFromHEX(0x1F1F1F);
    
    NSMutableArray <CRMysteryTFModel *> *crMysteryTFModels = [self generateModels];
    
    _crMysteryTFContentView = [[CRMysteryTFContentView alloc] initWithMinFrame:CGRectMake(0, 0, 213, 63) maxWidth:300];
    _crMysteryTFContentView.delegate = self;
    _crMysteryTFContentView.crMysteryTFModels = crMysteryTFModels;
    [self.view addSubview:_crMysteryTFContentView];
    [_crMysteryTFContentView BearSetCenterToParentViewWithAxis:kAXIS_X_Y];
    
    [self startAniamtion];
}

- (void)startAniamtion
{
    [_crMysteryTFContentView showStartTitleAniamtionWithString:@"Sign Up" completion:nil];
}

- (NSMutableArray <CRMysteryTFModel *> *)generateModels
{
    NSMutableArray <CRMysteryTFModel *> *crMysteryTFModels = [NSMutableArray new];
    
    CRMysteryTFModel *crMysteryTFModel;
    
    crMysteryTFModel = [CRMysteryTFModel new];
    crMysteryTFModel.titleStr = @"Name";
    crMysteryTFModel.iconImage = [UIImage imageNamed:@"CRTFUser_ICON"];
    [crMysteryTFModels addObject:crMysteryTFModel];
    
    crMysteryTFModel = [CRMysteryTFModel new];
    crMysteryTFModel.titleStr = @"Email";
    crMysteryTFModel.iconImage = [UIImage imageNamed:@"CRTFMail_ICON"];
    [crMysteryTFModels addObject:crMysteryTFModel];
    
    crMysteryTFModel = [CRMysteryTFModel new];
    crMysteryTFModel.titleStr = @"Password";
    crMysteryTFModel.iconImage = [UIImage imageNamed:@"CRTFLock_ICON"];
    [crMysteryTFModels addObject:crMysteryTFModel];
    
    return crMysteryTFModels;
}

#pragma mark - CRMysteryTFContentViewDelegate
- (void)CRMysteryTFContentViewFrameDidChanged:(CRMysteryTFContentView *)crMysteryTFContentView
{
    [crMysteryTFContentView BearSetCenterToParentViewWithAxis:kAXIS_X_Y];
}

- (void)CRMysteryTFContentViewDidClickConfirmBtn:(CRMysteryTextFiled *)crTextField
{
    NSLog(@"input:%@", crTextField.mysteryTFAndTitleView.textField.text);
    [_crMysteryTFContentView showNext];
}

- (void)didTapStartTitleEvent:(CRMysteryTFContentView *)crMysteryTFContentView
{
    [crMysteryTFContentView hideStartTitleAniamtionCompletion:^{
        [crMysteryTFContentView reloadDataAndShowMysteryField];
    }];
}

- (void)triggerNoNextEvent:(CRMysteryTFContentView *)crMysteryTFContentView
{
    [crMysteryTFContentView startFinishTitleAniamtionWithString:@"Welcome" completion:^{
        
        [crMysteryTFContentView reset];
        [crMysteryTFContentView showStartTitleAniamtionWithString:@"Sign Up" completion:nil];
        
    }];
}

@end
