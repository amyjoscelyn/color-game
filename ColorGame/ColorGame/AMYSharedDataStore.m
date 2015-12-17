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
        _colorsForGradient = [[self arrayOfGradientColors] mutableCopy];
        _colorsForGameButtons = [self arrayOfGameButtonGradientColors];
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

- (NSArray *)arrayOfGradientColors
{
    NSArray *colors = [NSArray arrayWithObjects:
                       [UIColor colorWithRed:153.0f /255.0f green:38.25f / 255.0f blue:25.5f / 255.0f alpha:1.0f],
                       [UIColor colorWithRed:216.75f /255.0f green:0.0f / 255.0f blue:0.0f / 255.0f alpha:1.0f],
                       [UIColor colorWithRed:178.5f /255.0f green:0.0f / 255.0f blue:76.5f / 255.0f alpha:1.0f],
                       [UIColor colorWithRed:140.25f / 255.0f green:0.0f / 255.0f blue:63.75f / 255.0f alpha:1.0f],
                       [UIColor colorWithRed:150.0f /255.0f green:0.0f / 255.0f blue:101.0f / 255.0f alpha:1.0f],
                       [UIColor colorWithRed:102.5f /255.0f green:12.75f / 255.0f blue:89.25f / 255.0f alpha:1.0f],
                       
                       [UIColor colorWithRed:166.0f /255.0f green:0.0f / 255.0f blue:0.0f / 255.0f alpha:1.0f],
                       [UIColor colorWithRed:178.5f /255.0f green:64.0f / 255.0f blue:0.0f / 255.0f alpha:1.0f],
                       [UIColor colorWithRed:178.5f /255.0f green:102.0f / 255.0f blue:0.0f / 255.0f alpha:1.0f],
                       [UIColor colorWithRed:217.0f / 255.0f green:127.5f / 255.0f blue:0.0f / 255.0f alpha:1.0f],
                       [UIColor colorWithRed:229.5f /255.0f green:166.0f / 255.0f blue:0.0f / 255.0f alpha:1.0f],
                       [UIColor colorWithRed:255.0f /255.0f green:166.0f / 255.0f blue:0.0f / 255.0f alpha:1.0f],
                       
                       [UIColor colorWithRed:255.0f /255.0f green:217.0f / 255.0f blue:0.0f / 255.0f alpha:1.0f],
                       [UIColor colorWithRed:255.0f /255.0f green:255.0f / 255.0f blue:0.0f / 255.0f alpha:1.0f],
                       [UIColor colorWithRed:204.0f /255.0f green:255.0f / 255.0f blue:0.0f / 255.0f alpha:1.0f],
                       [UIColor colorWithRed:153.0f /255.0f green:255.0f / 255.0f blue:0.0f / 255.0f alpha:1.0f],
                       [UIColor colorWithRed:135.0f /255.0f green:242.0f / 255.0f blue:242.0f / 255.0f alpha:1.0f],
                       [UIColor colorWithRed:89.0f /255.0f green:229.5f / 255.0f blue:178.5f / 255.0f alpha:1.0f],
                       
                       [UIColor colorWithRed:89.0f /255.0f green:217.0f / 255.0f blue:204.0f / 255.0f alpha:1.0f],
                       [UIColor colorWithRed:51.0f /255.0f green:204.0f / 255.0f blue:217.0f / 255.0f alpha:1.0f],
                       [UIColor colorWithRed:0.0f /255.0f green:178.5f / 255.0f blue:242.0f / 255.0f alpha:1.0f],
                       [UIColor colorWithRed:0.0f /255.0f green:140.0f / 255.0f blue:242.0f / 255.0f alpha:1.0f],
                       [UIColor colorWithRed:0.0f /255.0f green:115.0f / 255.0f blue:255.0f / 255.0f alpha:1.0f],
                       [UIColor colorWithRed:103.0f /255.0f green:89.0f / 255.0f blue:255.0f / 255.0f alpha:1.0f],
                       
                       [UIColor colorWithRed:140.0f /255.0f green:76.5f / 255.0f blue:255.0f / 255.0f alpha:1.0f],
                       [UIColor colorWithRed:140.0f /255.0f green:38.0f / 255.0f blue:255.0f / 255.0f alpha:1.0f],
                       [UIColor colorWithRed:140.0f /255.0f green:13.0f / 255.0f blue:229.5f / 255.0f alpha:1.0f],
                       [UIColor colorWithRed:140.0f /255.0f green:0.0f / 255.0f blue:191.0f / 255.0f alpha:1.0f],
                       [UIColor colorWithRed:140.0f /255.0f green:0.0f / 255.0f blue:140.0f / 255.0f alpha:1.0f],
                       [UIColor colorWithRed:153.0f /255.0f green:0.0f / 255.0f blue:115.0f / 255.0f alpha:1.0f],
                       
                       [UIColor colorWithRed:153.0f /255.0f green:0.0f / 255.0f blue:89.0f / 255.0f alpha:1.0f],
                       [UIColor colorWithRed:166.0f /255.0f green:0.0f / 255.0f blue:64.0f / 255.0f alpha:1.0f],
                       [UIColor colorWithRed:166.0f /255.0f green:0.0f / 255.0f blue:38.0f / 255.0f alpha:1.0f], nil];
    return colors;
}

- (void)rotateColorsInArray
{
    UIColor *firstColor = self.colorsForGradient[0];
    [self.colorsForGradient removeObjectAtIndex:0];
    [self.colorsForGradient addObject:firstColor];
}

- (NSArray *)arrayOfGameButtonGradientColors
{
    NSArray *colors = [NSArray arrayWithObjects:
                       //less red button
                       [UIColor colorWithRed:178.5f /255.0f green:0.0f / 255.0f blue:0.0f / 255.0f alpha:1.0f],
                       [UIColor colorWithRed:102.0f /255.0f green:0.0f / 255.0f blue:0.0f / 255.0f alpha:1.0f],
                       
                       //more red button
                       [UIColor colorWithRed:255.0f /255.0f green:0.0f / 255.0f blue:0.0f / 255.0f alpha:1.0f],
                       [UIColor colorWithRed:178.5f /255.0f green:0.0f / 255.0f blue:0.0f / 255.0f alpha:1.0f],
                       
                       //less green button
                       [UIColor colorWithRed:0.0f /255.0f green:178.5f / 255.0f blue:0.0f / 255.0f alpha:1.0f],
                       [UIColor colorWithRed:0.0f /255.0f green:102.0f / 255.0f blue:0.0f / 255.0f alpha:1.0f],
                       
                       //more green button
                       [UIColor colorWithRed:0.0f / 255.0f green:255.0f / 255.0f blue:0.0f / 255.0f alpha:1.0f],
                       [UIColor colorWithRed:0.0f /255.0f green:178.5f / 255.0f blue:0.0f / 255.0f alpha:1.0f],
                       
                       //less blue button
                       [UIColor colorWithRed:0.0f /255.0f green:0.0f / 255.0f blue:178.5f / 255.0f alpha:1.0f],
                       [UIColor colorWithRed:0.0f /255.0f green:0.0f / 255.0f blue:102.0f / 255.0f alpha:1.0f],
                       
                       //more blue button
                       [UIColor colorWithRed:0.0f /255.0f green:0.0f / 255.0f blue:255.0f / 255.0f alpha:1.0f],
                       [UIColor colorWithRed:0.0f /255.0f green:0.0f / 255.0f blue:178.5f / 255.0f alpha:1.0f],
                       
                       //more translucent
                       [UIColor colorWithRed:255.0f /255.0f green:255.0f / 255.0f blue:255.0f / 255.0f alpha:.35f],
                       [UIColor colorWithRed:255.0f /255.0f green:255.0f / 255.0f blue:255.0f / 255.0f alpha:.65f],
                       
                       //more opaque
                       [UIColor colorWithRed:255.0f /255.0f green:255.0f / 255.0f blue:255.0f / 255.0f alpha:.65f],
                       [UIColor colorWithRed:255.0f /255.0f green:255.0f / 255.0f blue:255.0f / 255.0f alpha:1.0f], nil];
    
    return colors;
}

@end
