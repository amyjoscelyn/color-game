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

- (UIColor *)setColorWithMode:(NSUInteger)mode difficulty:(NSUInteger)difficulty
{
    NSMutableArray *veryEasyArray = [[NSMutableArray alloc] init];
    NSMutableArray *easyArray = [[NSMutableArray alloc] init];
    NSMutableArray *mediumArray = [[NSMutableArray alloc] init];
    NSMutableArray *hardArray = [[NSMutableArray alloc] init];
    NSMutableArray *masterArray = [[NSMutableArray alloc] init];
    
    NSMutableArray *arrayOfArrays = [[NSMutableArray alloc] init];
    
    if (mode == 0)
    {
        veryEasyArray = [ @[ @128, @256, @"2" ] mutableCopy];
        easyArray = [ @[ @64, @128, @192, @256, @"2" ] mutableCopy];
        mediumArray = [ @[ @128, @256, @"1" ] mutableCopy];
        hardArray = [ @[ @64, @128, @192, @256, @"1" ] mutableCopy];
        masterArray = [ @[ @64, @128, @192, @256, @"0" ] mutableCopy];
        
        arrayOfArrays = [ @[ veryEasyArray, easyArray, mediumArray, hardArray, masterArray ] mutableCopy];
    }
    else if (mode == 1)
    {
        veryEasyArray = [ @[ @32, @64, @96, @128, @160, @192, @224, @256, @"2" ] mutableCopy];
        easyArray = [ @[ @64, @128, @192, @256, @"1" ] mutableCopy];
        mediumArray = [ @[ @32, @64, @96, @128, @160, @192, @224, @256, @"1" ] mutableCopy];
        hardArray = [ @[ @64, @128, @192, @256, @"0" ] mutableCopy];
        masterArray = [ @[ @32, @64, @96, @128, @160, @192, @224, @256, @"0" ] mutableCopy];
        
        arrayOfArrays = [ @[ veryEasyArray, easyArray, mediumArray, hardArray, masterArray ] mutableCopy];
    }
    else if (mode == 2)
    { //.16 COLORS FOR SINGLE ARE REEEAAALLLLY DIFFICULT TO SEE THE DIFFERENCE FROM BLACK
        veryEasyArray = [ @[ @16, @32, @48, @64, @80, @96, @112, @128, @144, @160, @176, @192, @208, @224, @240, @256, @"2" ] mutableCopy];
        easyArray = [ @[ @32, @64, @96, @128, @160, @192, @224, @256, @"1" ] mutableCopy];
        mediumArray = [ @[ @16, @32, @48, @64, @80, @96, @112, @128, @144, @160, @176, @192, @208, @224, @240, @256, @"1" ] mutableCopy];
        hardArray = [ @[ @32, @64, @96, @128, @160, @192, @224, @256, @"0" ] mutableCopy];
        masterArray = [ @[ @16, @32, @48, @64, @80, @96, @112, @128, @144, @160, @176, @192, @208, @224, @240, @256, @"0" ] mutableCopy];
        
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
    NSString *rgb = [self rgbChosenFromArray:arrayWithDifficulty];
    
    CGFloat red = 1;
    CGFloat green = 1;
    CGFloat blue = 1;
    CGFloat alpha = 1;
    
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
    } //I CHANGED THIS AS WELL
    UIColor *color = [UIColor colorWithRed:red/256.0 green:green/256.0 blue:blue/256.0 alpha:alpha];
    
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

/*
Let's try this again, shall we?
 THE STANDARD STRUCTURE I'M USING GOES
 -----------------------------------------------------------
 VE-it's basically following this pattern, with an exception for Simple Mode
 E- 1/2 values
 M- full values
 H- 1/2 values, more mix
 M- full values, more mix
 
 Simple: (.64, 1.28, 1.92, 2.56)
 -----------------------------------------------------------
 VE-single color:   1.28, 2.56              :)
 E-single color:    .64, 1.28, 1.92, 2.56   :)
 M-mix two:         1.28, 2.56              :)
 H-mix two:         .64, 1.28, 1.92, 2.56   :)
 M-mix three:       .64, 1.28, 1.92, 2.56   :)
 
 Basic: (.32, .64, .96, 1.28, 1.6, 1.92, 2.24, 2.56)
 -----------------------------------------------------------
 VE-mix one:    .32, .64, .96, 1.28, 1.6, 1.92, 2.24, 2.56
 E-mix two:     .64, 1.28, 1.92, 2.56
 M-mix two:     .32, .64, .96, 1.28, 1.6, 1.92, 2.24, 2.56
 H-mix three:   .64, 1.28, 1.92, 2.56
 M-mix three:   .32, .64, .96, 1.28, 1.6, 1.92, 2.24, 2.56
 
 Moderate: (.16, .32, .48, .64, .8, .96, 1.12, 1.28, 1.44, 1.6, 1.76, 1.92, 2.08, 2.24, 2.4, 2.56)
 -----------------------------------------------------------
 VE-mix one:    .16, .32, .48, .64, .8, .96, 1.12, 1.28, 1.44, 1.6, 1.76, 1.92, 2.08, 2.24, 2.4, 2.56
 E-mix two:     .32, .64, .96, 1.28, 1.6, 1.92, 2.24, 2.56
 M-mix two:     .16, .32, .48, .64, .8, .96, 1.12, 1.28, 1.44, 1.6, 1.76, 1.92, 2.08, 2.24, 2.4, 2.56
 H-mix three:   .32, .64, .96, 1.28, 1.6, 1.92, 2.24, 2.56
 M-mix three:   .16, .32, .48, .64, .8, .96, 1.12, 1.28, 1.44, 1.6, 1.76, 1.92, 2.08, 2.24, 2.4, 2.56
 
 ****(Theoretically I'm missing a difficulty between here, with an increment value of .8.  Challenging Mode compensates for this, which is why it is an exception as well to the basic structure)************************
 
 Challenging: (.4, .8, .12, .16, .2, .24, .28, .32, .36, .4, .44, .48, .52, .56, .6, .64, .68, .72, .76, .8, .84, .88, .92, .96, 1, 1.04, 1.08, 1.12, 1.16, 1.2, 1.24, 1.28, 1.32, 1.36, 1.4, 1.44, 1.48, 1.52, 1.56, 1.6, 1.64, 1.68, 1.72, 1.76, 1.8, 1.84, 1.88, 1.92, 1.96, 2, 2.04, 2.08, 2.12, 2.16, 2.2, 2.24, 2.28, 2.32, 2.36, 2.4, 2.44, 2.48, 2.52, 2.56)
 -----------------------------------------------------------
 VE-mix two:    .8, .16, .24, .32, .4, .48, .56, .64, .72, .8, .88, .96, 1.04, 1.12, 1.2, 1.28, 1.36, 1.44, 1.52, 1.6, 1.68, 1.76, 1.84, 1.92, 2, 2.08, 2.16, 2.24, 2.32, 2.4, 2.48, 2.56
 E-mix two:     .4, .8, .12, .16, .2, .24, .28, .32, .36, .4, .44, .48, .52, .56, .6, .64, .68, .72, .76, .8, .84, .88, .92, .96, 1, 1.04, 1.08, 1.12, 1.16, 1.2, 1.24, 1.28, 1.32, 1.36, 1.4, 1.44, 1.48, 1.52, 1.56, 1.6, 1.64, 1.68, 1.72, 1.76, 1.8, 1.84, 1.88, 1.92, 1.96, 2, 2.04, 2.08, 2.12, 2.16, 2.2, 2.24, 2.28, 2.32, 2.36, 2.4, 2.44, 2.48, 2.52, 2.56
 M-mix three:   .16, .32, .48, .64, .8, .96, 1.12, 1.28, 1.44, 1.6, 1.76, 1.92, 2.08, 2.24, 2.4, 2.56
 H-mix three:   .8, .16, .24, .32, .4, .48, .56, .64, .72, .8, .88, .96, 1.04, 1.12, 1.2, 1.28, 1.36, 1.44, 1.52, 1.6, 1.68, 1.76, 1.84, 1.92, 2, 2.08, 2.16, 2.24, 2.32, 2.4, 2.48, 2.56
 M-mix three:   .4, .8, .12, .16, .2, .24, .28, .32, .36, .4, .44, .48, .52, .56, .6, .64, .68, .72, .76, .8, .84, .88, .92, .96, 1, 1.04, 1.08, 1.12, 1.16, 1.2, 1.24, 1.28, 1.32, 1.36, 1.4, 1.44, 1.48, 1.52, 1.56, 1.6, 1.64, 1.68, 1.72, 1.76, 1.8, 1.84, 1.88, 1.92, 1.96, 2, 2.04, 2.08, 2.12, 2.16, 2.2, 2.24, 2.28, 2.32, 2.36, 2.4, 2.44, 2.48, 2.52, 2.56
 */

/*
 I can make a sort of "colors that had just been played" array, keep track of the last three or four colors.  The array gets set up in the dataStore, and refreshed in ColorSetup when the difficulty is chosen.  The current color gets added in the ColorGameVC to that array.  The color being chosen cannot be the same as any in that array, and must be re-cast from arc4random until it's a new color.  When the current color is being added, the array is also checked: should it have more than three or four in the array.count, the first object is removed.  This way it's a rotating list.  If that still feels like too much, the array can be made a lot longer before the first object comes off.
 */

@end
