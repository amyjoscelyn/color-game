//
//  AMYColorSetup.m
//  ColorGame
//
//  Created by Amy Joscelyn on 12/8/15.
//  Copyright © 2015 Amy Joscelyn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMYColorSetup.h"

@implementation AMYColorSetup

- (NSArray *)setColorArrayWithMode:(NSUInteger)mode difficulty:(NSUInteger)difficulty
{
    NSMutableArray *veryEasyArray = [[NSMutableArray alloc] init];
    NSMutableArray *easyArray = [[NSMutableArray alloc] init];
    NSMutableArray *mediumArray = [[NSMutableArray alloc] init];
    NSMutableArray *hardArray = [[NSMutableArray alloc] init];
    NSMutableArray *masterArray = [[NSMutableArray alloc] init];
    
    NSMutableArray *arrayOfArrays = [[NSMutableArray alloc] init];
    
    if (mode == 0)
    {
        veryEasyArray = [ @[ @.5, @.75, @1, @"2" ] mutableCopy];
        easyArray = [ @[ @.5, @1, @"1" ] mutableCopy];
        mediumArray = [ @[ @.25, @.5, @.75, @1, @"1" ] mutableCopy];
        hardArray = [ @[ @.5, @.75, @1, @"0" ] mutableCopy];
        masterArray = [ @[ @.25, @.5, @.75, @1, @"0" ] mutableCopy];
        
        arrayOfArrays = [ @[ veryEasyArray, easyArray, mediumArray, hardArray, masterArray ] mutableCopy];
    }
    else if (mode == 1)
    {
        veryEasyArray = [ @[ @.5, @1, @"1" ] mutableCopy];
        easyArray = [ @[ @.2, @.5, @.7, @1, @"1" ] mutableCopy];
        mediumArray = [ @[ @.2, @.5, @.7, @1, @"0" ] mutableCopy];
        hardArray = [ @[ @.2, @.4, @.5, @.6, @.8, @1, @"0" ] mutableCopy];
        masterArray = [ @[ @.1, @.2, @.3, @.4, @.5, @.6, @.7, @.8, @.9, @1, @"0" ] mutableCopy];
        
        arrayOfArrays = [ @[ veryEasyArray, easyArray, mediumArray, hardArray, masterArray ] mutableCopy];
    }
    else if (mode == 2)
    {
        veryEasyArray = [ @[ @.25, @.5, @.75, @1, @"1" ] mutableCopy];
        easyArray = [ @[ @.25, @.5, @.75, @1, @"0" ] mutableCopy];
        mediumArray = [ @[ @.1, @.25, @.4, @.5, @.6, @.75, @.9, @1, @"0" ] mutableCopy];
        hardArray = [ @[ @.1, @.2, @.25, @.3, @.4, @.5, @.6, @.7, @.75, @.8, @.9, @1, @"0" ] mutableCopy];
        masterArray = [ @[ @.05, @.1, @.15, @.2, @.25, @.3, @.35, @.4, @.45, @.5, @.55, @.6, @.65, @.7, @.75, @.8, @.85, @.9, @.95, @1, @"0" ] mutableCopy];
        
        arrayOfArrays = [ @[ veryEasyArray, easyArray, mediumArray, hardArray, masterArray ] mutableCopy];
    }
    else
    {
        veryEasyArray = [ @[  ] mutableCopy];
        easyArray = [ @[  ] mutableCopy];
        mediumArray = [ @[  ] mutableCopy];
        hardArray = [ @[  ] mutableCopy];
        masterArray = [ @[  ] mutableCopy];
        
        arrayOfArrays = [ @[ veryEasyArray, easyArray, mediumArray, hardArray, masterArray ] mutableCopy];
    }
    NSMutableArray *arrayWithDifficulty = [arrayOfArrays[difficulty] mutableCopy];
    //now i know the exact array that is going to be worked with
    
    NSString *rgb = [self rgbChosenFromArray:arrayWithDifficulty];
    
    CGFloat red = 1;
    CGFloat green = 1;
    CGFloat blue = 1;
    CGFloat alpha = 1;
    //now i have red, green, or blue chosen...
    
    NSString *numberOfValuesThatWillBeZero = arrayWithDifficulty.lastObject;
    [arrayWithDifficulty removeLastObject];
    
    if ([numberOfValuesThatWillBeZero isEqualToString:@"2"])
    {
        if ([rgb isEqualToString:@"Red"])
        {
            red = [self randomValueFromArray:arrayWithDifficulty];
            green = 0;
            blue = 0;
        }
        else if ([rgb isEqualToString:@"Green"])
        {
            red = 0;
            green = [self randomValueFromArray:arrayWithDifficulty];
            blue = 0;
        }
        else
        {
            red = 0;
            green = 0;
            blue = [self randomValueFromArray:arrayWithDifficulty];
        }
    }
    else if ([numberOfValuesThatWillBeZero isEqualToString:@"1"])
    {
        if ([rgb isEqualToString:@"Red"])
        {
            red = 0;
            green = [self randomValueFromArray:arrayWithDifficulty];
            blue = [self randomValueFromArray:arrayWithDifficulty];
        }
        else if ([rgb isEqualToString:@"Green"])
        {
            red = [self randomValueFromArray:arrayWithDifficulty];
            green = 0;
            blue = [self randomValueFromArray:arrayWithDifficulty];
        }
        else
        {
            red = [self randomValueFromArray:arrayWithDifficulty];
            green = [self randomValueFromArray:arrayWithDifficulty];
            blue = 0;
        }
    }
    else
    {
        red = [self randomValueFromArray:arrayWithDifficulty];
        green = [self randomValueFromArray:arrayWithDifficulty];
        blue = [self randomValueFromArray:arrayWithDifficulty];
    }
    NSLog(@"r: %f, g: %f, b: %f", red, green, blue);
    
    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    
    /*
     If mode is 0, and difficulty is 0, arc4_random 0-2 for an array containing red, green, blue.  The one chosen gets to be the one with a number.  This means the ones not chosen become value of 0.  The chosen one goes through arc4_random again to determine which number from the difficulty array (in this case, veryEasy, or easier: arrayWithDifficulty) becomes that value.  Then it goes through the dance to turn it from NSNumber to CGFloat, and it's added, with the other 0 values, to the chosen color method.  This color is returned, and the method returns a single color.
     If the mode is 0, and difficulty is 1 or 2 (< 3), arc4_random on the RGB array to figure out which one is going to be 0.  Then the other two go through arc4_random to determine their values, go through the dance, and get added to the color method.
     If the mode is 0, and difficulty is 3 or 4 (> 2), arc4_random all three with the difficultyArray and add to the method.
     
     If the mode is 1, difficulty < 2, arc4_random RGB for a single 0, then arc4random twice the difficultyArray to get values for method.
     If mode is 1, diff > 1 (else), arc4_random all three for color method.
    
     If mode is 2, diff = 0, you need one zero, and two true values.
     Else, get all three values randomly.
     
     And so on!
     
     Check should be put into place, so while color had just been chosen (currentColor, saved in dataStore?), do it all again!  (rather, do-while)
     */
    
    return color;
}

- (NSString *)rgbChosenFromArray:(NSArray *)valuesArray
{
    for (NSNumber *value in valuesArray)
    {
        NSLog(@"value: %@", value);
    }
    NSString *rgb = @"";
    NSUInteger rgbOption = arc4random_uniform(3);
    if (rgbOption == 0)
    {
        rgb = @"Red";
    }
    else if (rgbOption == 1)
    {
        rgb = @"Green";
    }
    else
    {
        rgb = @"Blue";
    }
    NSLog(@"rgb? %@", rgb);
    
    return rgb;
}

- (CGFloat)randomValueFromArray:(NSArray *)array
{
    NSUInteger valueChosen = arc4random_uniform((int)array.count);
    NSNumber *numberValue = array[valueChosen];
    return numberValue.floatValue;
}

/*
 Okay--so colors should now be set up by mode.
 Simple:
 VE-single color, .5, .75, 1    :)
 E-mix two, .5, 1               :)
 M-mix two, .25, .5, .75, 1     :)
 H-mix three, .5, .75, 1             :0 this doesn't seem like enough
 M-mix three, .25, .5, .75, 1   :)
 
 Basic:
 VE-mix two, .5, 1              :) reused from Simple-E
 E-mix two, .2, .5, .7, 1
 M-mix three, .2, .5, .7, 1
 H-mix three, .2, .4, .5, .6, .8, 1
 M-mix three, .1, .2, .3, .4, .5, .6, .7, .8, .9, 1
 
 Moderate:
 VE-mix two, .25, .5, .75, 1    :) reused from Simple-Me
 E-mix three, .25, .5, .75, 1   :) reused from Simple-Ma
 M-mix three, .1, .25, .4, .5, .6, .75, .9, 1
 H-mix three, .1, .2, .25, .3, .4, .5, .6, .7, .75, .8, .9, 1
 M-mix three, .05, .1, .15, .2, .25, .3, .35, .4, .45, .5, .55, .6, .65, .7, .75, .8, .85, .9, .95, 1
 
 Challenging:
 Forthcoming!
 */

@end
