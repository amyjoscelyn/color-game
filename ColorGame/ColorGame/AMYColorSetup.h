//
//  AMYColorSetup.h
//  ColorGame
//
//  Created by Amy Joscelyn on 12/8/15.
//  Copyright © 2015 Amy Joscelyn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AMYColorSetup : NSObject

@property (nonatomic, strong) NSArray *veryEasyColors;
@property (nonatomic, strong) NSArray *easyColors;
@property (nonatomic, strong) NSArray *mediumColors;
@property (nonatomic, strong) NSArray *hardColors;
@property (nonatomic, strong) NSArray *masterColors;

+ (void)setColorArrays;

@end
