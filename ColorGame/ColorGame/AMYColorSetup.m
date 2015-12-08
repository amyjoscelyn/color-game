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

+ (NSArray *)setColorArrays
{
    UIColor *red = [UIColor redColor];       // 1|0|0|1
    UIColor *yellow = [UIColor yellowColor];    // 1|1|0|1
    UIColor *green = [UIColor greenColor];     // 0|1|0|1
    UIColor *cyan = [UIColor cyanColor];        // 0|1|1|1
    UIColor *blue   = [UIColor blueColor];      // 0|0|1|1
    UIColor *magenta = [UIColor magentaColor];  // 1|0|1|1
    UIColor *white  = [UIColor whiteColor];     // 1|1|1|1
    UIColor *royalRed = [UIColor colorWithRed:.5 green:0 blue:0 alpha:1];
    UIColor *royalGreen = [UIColor colorWithRed:0 green:.5 blue:0 alpha:1];
    UIColor *royalBlue = [UIColor colorWithRed:0 green:0 blue:.5 alpha:1];
    
    NSArray *veryEasyColors = @[ red, royalRed, yellow, green, royalGreen, cyan, blue, royalBlue, magenta, white ]; //WHITE IS NOT WORKING CORRECTLY
    
    UIColor *hotPink = [UIColor colorWithRed:1 green:0 blue:.5 alpha:1];
    UIColor *coral = [UIColor colorWithRed:1 green:.5 blue:.5 alpha:1];
    UIColor *orange = [UIColor orangeColor];    // 1|5|0|1
    UIColor *paleYellow = [UIColor colorWithRed:1 green:1 blue:.5 alpha:1];
    UIColor *softGreen = [UIColor colorWithRed:.5 green:1 blue:.5 alpha:1];
    UIColor *seaGreen = [UIColor colorWithRed:0 green:.5 blue:.5 alpha:1];
    UIColor *weedGreen = [UIColor colorWithRed:.5 green:.5 blue:0 alpha:1];
    UIColor *limeGreen = [UIColor colorWithRed:.5 green:1 blue:0 alpha:1];
    UIColor *brightGreen = [UIColor colorWithRed:0 green:1 blue:.5 alpha:1];
    UIColor *skyBlue = [UIColor colorWithRed:.5 green:1 blue:1 alpha:1];
    UIColor *mildBlue = [UIColor colorWithRed:0 green:.5 blue:1 alpha:1];
    UIColor *periwinkle = [UIColor colorWithRed:.5 green:.5 blue:1 alpha:1];
    UIColor *brightPurple = [UIColor colorWithRed:.5 green:0 blue:1 alpha:1];
    UIColor *purple = [UIColor purpleColor];    // 5|0|5|1
    UIColor *fuschia = [UIColor colorWithRed:1 green:.5 blue:1 alpha:1];
    UIColor *gray = [UIColor grayColor];        // 5|5|5|1
    
    NSArray *easyColors = @[ hotPink, coral, orange, paleYellow, softGreen, seaGreen, weedGreen, limeGreen, brightGreen, skyBlue, mildBlue, periwinkle, brightPurple, purple, fuschia, gray ];
    
    UIColor *brown  = [UIColor brownColor]; // 6|4|2|1
    UIColor *dustyRose = [UIColor colorWithRed:.6 green:0 blue:.2 alpha:1];
    UIColor *vividGreen = [UIColor colorWithRed:.5 green:.75 blue:0 alpha:1];
    UIColor *darkBlue = [UIColor colorWithRed:0 green:.2 blue:.4 alpha:1];
    UIColor *coralRose = [UIColor colorWithRed:1 green:0 blue:.25 alpha:1];
    
    NSArray *mediumColors = @[ brown, dustyRose, vividGreen, darkBlue, coralRose ];
    
    UIColor *springGreen = [UIColor colorWithRed:.45 green:.75 blue:.5 alpha:1];
    UIColor *darkRed = [UIColor colorWithRed:.5 green:0 blue:.1 alpha:1];
    
    NSArray *hardColors = @[ springGreen, darkRed ];
    
    UIColor *lightGray = [UIColor lightGrayColor];  // 667|667|667|1
    UIColor *darkGray = [UIColor darkGrayColor];    // 333|333|333|1
    
    NSArray *masterColors = @[ lightGray, darkGray ];
    
    NSArray *arrayOfArrays = @[ veryEasyColors, easyColors, mediumColors, hardColors, masterColors ];
    return arrayOfArrays;
}

@end
