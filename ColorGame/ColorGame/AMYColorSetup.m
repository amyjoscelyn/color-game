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

- (UIColor *)setColorWithMode:(NSUInteger)mode difficulty:(NSUInteger)difficulty currentColor:(UIColor *)priorColor
{ //THIS CAN BE REFACTORED INTO AT LEAST TWO SEPARATE METHODS:
    // one to get the arrays, and read just one
    // one to pick the actual color
    // maybe another, if i see fit
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
        veryEasyArray = [ @[ @8, @16, @24, @32, @40, @48, @56, @64, @72, @80, @88, @96, @104, @112, @120, @128, @136, @144, @152, @160, @168, @176, @184, @192, @200, @208, @216, @224, @232, @240, @248, @256, @"1" ] mutableCopy];
        easyArray = [ @[ @4, @8, @12, @16, @20, @24, @28, @32, @36, @40, @44, @48, @52, @56, @60, @64, @68, @72, @76, @80, @84, @88, @92, @96, @100, @104, @108, @112, @116, @120, @124, @128, @132, @136, @140, @144, @148, @152, @156, @160, @164, @168, @172, @176, @180, @184, @188, @192, @196, @200, @204, @208, @212, @216, @220, @224, @228, @232, @236, @240, @244, @248, @252, @256, @"1" ] mutableCopy];
        mediumArray = [ @[ @16, @32, @48, @64, @80, @96, @112, @128, @144, @160, @176, @192, @208, @224, @240, @256, @"0" ] mutableCopy];
        hardArray = [ @[ @8, @16, @24, @32, @40, @48, @56, @64, @72, @80, @88, @96, @104, @112, @120, @128, @136, @144, @152, @160, @168, @176, @184, @192, @200, @208, @216, @224, @232, @240, @248, @256, @"0" ] mutableCopy];
        masterArray = [ @[ @4, @8, @12, @16, @20, @24, @28, @32, @36, @40, @44, @48, @52, @56, @60, @64, @68, @72, @76, @80, @84, @88, @92, @96, @100, @104, @108, @112, @116, @120, @124, @128, @132, @136, @140, @144, @148, @152, @156, @160, @164, @168, @172, @176, @180, @184, @188, @192, @196, @200, @204, @208, @212, @216, @220, @224, @228, @232, @236, @240, @244, @248, @252, @256, @"0" ] mutableCopy];
        
        arrayOfArrays = [ @[ veryEasyArray, easyArray, mediumArray, hardArray, masterArray ] mutableCopy];
    }
    NSMutableArray *arrayWithDifficulty = [arrayOfArrays[difficulty] mutableCopy];
    NSString *rgb = [self rgbChosenFromArray:arrayWithDifficulty];
    //these can probably just have a comma next to them, and not be set to anything right now.  Except Alpha, of course.
    CGFloat red = 1;
    CGFloat green = 1;
    CGFloat blue = 1;
    CGFloat alpha = 1;
    
    CGFloat colorRed, colorGreen, colorBlue, colorAlpha;
    CGFloat priorRed, priorGreen, priorBlue, priorAlpha;
    
    UIColor *color;
    
    NSString *numberOfValuesThatWillBeZero = arrayWithDifficulty.lastObject;
    [arrayWithDifficulty removeLastObject];
    
    do
    {
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
        color = [UIColor colorWithRed:red/256.0 green:green/256.0 blue:blue/256.0 alpha:alpha];
        NSLog(@"new color: %@, old color: %@", color, priorColor);
        
        [color    getRed: &colorRed
                   green: &colorGreen
                    blue: &colorBlue
                   alpha: &colorAlpha ];
        
        [priorColor    getRed: &priorRed
                   green: &priorGreen
                    blue: &priorBlue
                   alpha: &priorAlpha ];
        
    } while (colorRed == priorRed && colorGreen == priorGreen && colorBlue == priorBlue);
    
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
