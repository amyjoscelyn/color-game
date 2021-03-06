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

- (UIColor *)setColorWithMode:(NSUInteger)mode difficulty:(NSUInteger)difficulty currentColor:(UIColor *)priorColor; //maybe this method can have an added parameter of previous/currentColor, which can be compared to the color it's setting to make sure it's not a repeat

- (NSString *)rgbChosenFromArray:(NSArray *)valuesArray;

@end
