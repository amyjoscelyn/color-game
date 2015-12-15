//
//  AMYSharedDataStore.m
//  ColorGame
//
//  Created by Amy Joscelyn on 12/9/15.
//  Copyright © 2015 Amy Joscelyn. All rights reserved.
//

#import "AMYSharedDataStore.h"

@implementation AMYSharedDataStore

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _mode = 0;
        _difficulty = 0;
    }
    return self;
}

+ (instancetype)sharedDataStore
{
    static AMYSharedDataStore *_sharedDataStore = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedDataStore = [[AMYSharedDataStore alloc] init];
    });
    return _sharedDataStore;
}

@end
