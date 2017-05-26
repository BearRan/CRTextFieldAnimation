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
#import "CRTextFiled.h"

@interface ViewController ()
{
    CRTextFiled *_crTextFiled;
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
    
    _crTextFiled = [[CRTextFiled alloc] initWithMaxFrame:CGRectMake(0, 0, 213, 63)];
    [self.view addSubview:_crTextFiled];
    [_crTextFiled BearSetCenterToParentViewWithAxis:kAXIS_X_Y];
}

@end
