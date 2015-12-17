//
//  AMYSharedDataStore.h
//  ColorGame
//
//  Created by Amy Joscelyn on 12/9/15.
//  Copyright © 2015 Amy Joscelyn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface AMYSharedDataStore : NSObject

@property (nonatomic) NSUInteger mode;
@property (nonatomic) NSUInteger difficulty;
@property (nonatomic, strong) NSMutableArray *colorsForGradient;
@property (nonatomic, strong) NSArray *colorsForGameButtons;

+ (instancetype)sharedDataStore;

- (void)rotateColorsInArray;

@end
