//
//  BearSeesawManager.h
//  CRTextFieldAnimation
//
//  Created by Bear on 2017/6/24.
//  Copyright © 2017年 Bear. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, BearSeesawObjectType) {
    BearSeesawObjectTypeCurrent,
    BearSeesawObjectTypeAnother,
};

@interface BearSeesawManager : NSObject

- (id)getObjectWithType:(BearSeesawObjectType)type;
- (void)setObject:(id)object withType:(BearSeesawObjectType)type;
- (void)exchangeObject;

@end
