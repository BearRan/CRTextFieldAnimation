//
//  BearSeesawManager.m
//  CRTextFieldAnimation
//
//  Created by Bear on 2017/6/24.
//  Copyright © 2017年 Bear. All rights reserved.
//

#import "BearSeesawManager.h"

@interface BearSeesawManager ()
{
    NSMutableArray *_objects;
    id _currentObject;
    id _anotherObject;
}

@end

@implementation BearSeesawManager

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        [self initPara];
    }
    
    return self;
}

- (void)initPara
{
    _objects = [[NSMutableArray alloc] initWithCapacity:2];
    for (int i = 0; i < 2; i++) {
        NSObject *obj = [NSObject new];
        [_objects addObject:obj];
    }
}

- (id)getObjectWithType:(BearSeesawObjectType)type
{
    if (type == BearSeesawObjectTypeCurrent && _objects[0]) {
        return _objects[0];
    }else if (type == BearSeesawObjectTypeAnother && _objects[1]) {
        return _objects[1];
    }
    
    return nil;
}

- (void)setObject:(id)object withType:(BearSeesawObjectType)type
{
    if (!object) {
        return;
    }
    
    if (type == BearSeesawObjectTypeCurrent) {
        _objects[0] = object;
    }else if (type == BearSeesawObjectTypeAnother) {
        _objects[1] = object;
    }
    
    return;
}

- (void)exchangeObject
{
    id temp = _objects[0];
    _objects[0] = _objects[1];
    _objects[1] = temp;
}

@end
