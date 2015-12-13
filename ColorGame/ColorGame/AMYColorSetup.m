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

+ (NSArray *)setColorArraysWithMode:(NSUInteger)mode
{
    //Single Value Colors
    UIColor *red = [UIColor redColor];          // 1.|00|00|1.
    UIColor *green = [UIColor greenColor];      // 00|1.|00|1.
    UIColor *blue   = [UIColor blueColor];      // 00|00|1.|1.
    
    UIColor *royalRed = [UIColor colorWithRed:.75 green:0 blue:0 alpha:1];                               // 75|00|00|1.
    UIColor *royalGreen = [UIColor colorWithRed:0 green:75 blue:0 alpha:1];                               // 00|75|00|1.
    UIColor *royalBlue = [UIColor colorWithRed:0 green:0 blue:.75 alpha:1];                               // 00|00|75|1.
    
    UIColor *darkRed = [UIColor colorWithRed:.5 green:0 blue:0 alpha:1];                               // 50|00|00|1.
    UIColor *darkGreen = [UIColor colorWithRed:0 green:.5 blue:0 alpha:1];                               // 00|50|00|1.
    UIColor *darkBlue = [UIColor colorWithRed:0 green:0 blue:.5 alpha:1];                               // 00|00|50|1.
    
    //Double Value Colors
    //just 1.
    UIColor *yellow = [UIColor yellowColor];    // 1.|1.|00|1.
    UIColor *cyan = [UIColor cyanColor];        // 00|1.|1.|1.
    UIColor *magenta = [UIColor magentaColor];  // 1.|00|1.|1.
    
    //just 75
    UIColor *goldenrod = [UIColor colorWithRed:.75 green:.75 blue:0 alpha:1];    // 75|75|00|1.
    UIColor *mildFuschia = [UIColor colorWithRed:.75 green:0 blue:.75 alpha:1];    // 75|00|75|1.
    UIColor *mildTeal = [UIColor colorWithRed:0 green:.75 blue:.75 alpha:1];    // 00|75|75|1.
    
    //just 50
    UIColor *purple = [UIColor purpleColor];    // 50|00|50|1.
    UIColor *teal = [UIColor colorWithRed:0 green:.5 blue:.5 alpha:1];                               // 00|50|50|1.
    UIColor *weedGreen = [UIColor colorWithRed:.5 green:.5 blue:0 alpha:1];                               // 50|50|00|1.
    
    //just 25
    UIColor *midnightPurple = [UIColor colorWithRed:.25 green:0 blue:.25 alpha:1];    // 25|00|25|1.
    UIColor *stormySea = [UIColor colorWithRed:0 green:.25 blue:.25 alpha:1];    // 00|25|25|1.
    UIColor *poopGreen = [UIColor colorWithRed:.25 green:0 blue:.25 alpha:1];    // 25|00|25|1.
    
    //75 and 1.
    UIColor *sunflower = [UIColor colorWithRed:1 green:.75 blue:0 alpha:1];    // 1.|75|00|1.
    UIColor *bubblegum = [UIColor colorWithRed:1 green:0 blue:.75 alpha:1];    // 1.|00|75|1.
    UIColor *yellowGreen = [UIColor colorWithRed:.75 green:1 blue:0 alpha:1];    // 75|1.|0|1.
    UIColor *aquaGreen = [UIColor colorWithRed:0 green:1 blue:.75 alpha:1];    // 00|1.|75|1.
    UIColor *candyPurple = [UIColor colorWithRed:.75 green:0 blue:1 alpha:1];    // 75|00|1.|1.
    UIColor *aquaBlue = [UIColor colorWithRed:0 green:.75 blue:1 alpha:1];    // 00|75|1.|1.
   
    //50 and 1.
    UIColor *pink = [UIColor colorWithRed:1 green:0 blue:.5 alpha:1];                               // 1.|00|50|1.
    UIColor *orange = [UIColor orangeColor];    // 1.|50|00|1.
    UIColor *limeGreen = [UIColor colorWithRed:.5 green:1 blue:0 alpha:1];                               // 50|1.|00|1.
    UIColor *brightGreen = [UIColor colorWithRed:0 green:1 blue:.5 alpha:1];                             // 00|1.|50|1.
    UIColor *mildBlue = [UIColor colorWithRed:0 green:.5 blue:1 alpha:1];                               // 00|50|1.|1.
    UIColor *brightPurple = [UIColor colorWithRed:.5 green:0 blue:1 alpha:1];                        // 50|00|1.|1.
    
    //25 and 1
    UIColor *coralRose = [UIColor colorWithRed:1 green:0 blue:.25 alpha:1];                               // 1.|00|25|1.
    UIColor *boldOrange = [UIColor colorWithRed:1 green:.25 blue:0 alpha:1];    // 1.|25|00|1.
//    UIColor *stillGreen = [UIColor colorWithRed:.25 green:1 blue:0 alpha:1];    // 25|1.|00|1.
//    UIColor *color3 = [UIColor colorWithRed:0 green:1 blue:.25 alpha:1];    // 00|1.|25|1.  THESE LOOK LIKE NOTHING
    UIColor *bluePurple = [UIColor colorWithRed:.25 green:0 blue:1 alpha:1];    // 25|00|1.|1.
    UIColor *lighterBlue = [UIColor colorWithRed:0 green:.25 blue:1 alpha:1];    // 00|25|1.|1.
    
    //50 and 75
    UIColor *vividGreen = [UIColor colorWithRed:.5 green:.75 blue:0 alpha:1];                        // 50|75|00|1.
    UIColor *vividPurple = [UIColor colorWithRed:.5 green:0 blue:.75 alpha:1];    // 50|00|75|1.
    UIColor *umber = [UIColor colorWithRed:.75 green:.5 blue:0 alpha:1];    // 75|50|00|1.
    UIColor *lightBlue = [UIColor colorWithRed:0 green:.5 blue:.75 alpha:1];    // 00|50|75|1.
    UIColor *vividRose = [UIColor colorWithRed:.75 green:0 blue:.5 alpha:1];    // 75|00|50|1.
    UIColor *mildGreen = [UIColor colorWithRed:0 green:.75 blue:.5 alpha:1];    // 00|75|50|1.
    
    //25 and 75
    UIColor *deepBlue = [UIColor colorWithRed:0 green:.25 blue:.75 alpha:1];    // 00|25|75|1.
    UIColor *deepPurple = [UIColor colorWithRed:.25 green:0 blue:.75 alpha:1];    // 25|00|75|1.
    UIColor *deepGreen = [UIColor colorWithRed:0 green:.75 blue:.25 alpha:1];    // 00|75|25|1.
    UIColor *summerGreen = [UIColor colorWithRed:.25 green:.75 blue:0 alpha:1];    // 25|75|00|1.
    UIColor *deepPink = [UIColor colorWithRed:.75 green:0 blue:.25 alpha:1];    // 75|00|25|1.
    UIColor *burntOrange = [UIColor colorWithRed:.75 green:.25 blue:0 alpha:1];    // 75|25|00|1.
    
    //25 and 50
    UIColor *c = [UIColor colorWithRed:0 green:.25 blue:.5 alpha:1];    // 00|25|50|1.
    UIColor *d = [UIColor colorWithRed:.25 green:0 blue:.5 alpha:1];    // 25|00|50|1.
    UIColor *e = [UIColor colorWithRed:0 green:.5 blue:.25 alpha:1];    // 00|50|25|1.
    UIColor *f = [UIColor colorWithRed:.25 green:.5 blue:0 alpha:1];    // 25|50|00|1.
    UIColor *g = [UIColor colorWithRed:.5 green:0 blue:.25 alpha:1];    // 50|00|25|1.
    UIColor *h = [UIColor colorWithRed:.5 green:.25 blue:0 alpha:1];    // 50|25|00|1.
    
    
    UIColor *dustyRose = [UIColor colorWithRed:.6 green:0 blue:.2 alpha:1];                               // 60|00|20|1.
    UIColor *darkTeal = [UIColor colorWithRed:0 green:.2 blue:.4 alpha:1];                               // 00|20|40|1.
    
    //Triple Value Colors
    UIColor *coral = [UIColor colorWithRed:1 green:.5 blue:.5 alpha:1];                               // 1.|50|50|1.
    UIColor *paleYellow = [UIColor colorWithRed:1 green:1 blue:.5 alpha:1];                               // 1.|1.|50|1.
    UIColor *softGreen = [UIColor colorWithRed:.5 green:1 blue:.5 alpha:1];                               // 50|1.|50|1.
    UIColor *skyBlue = [UIColor colorWithRed:.5 green:1 blue:1 alpha:1];                               // 50|1.|1.|1.
    UIColor *periwinkle = [UIColor colorWithRed:.5 green:.5 blue:1 alpha:1];                             // 50|50|1.|1.
    UIColor *fuschia = [UIColor colorWithRed:1 green:.5 blue:1 alpha:1];                               // 1.|50|1.|1.
    
    
    UIColor *lightGray = [UIColor colorWithRed:.75 green:.75 blue:.75 alpha:1];    // 75|75|75|1.
    UIColor *color44 = [UIColor colorWithRed:.25 green:.25 blue:.25 alpha:1];    // 25|25|25|1.
    UIColor *color45 = [UIColor colorWithRed:.5 green:.5 blue:.5 alpha:1];    // 50|50|50|1.
    
    // 00|00|00|1.
    
    
    
    
    UIColor *brown  = [UIColor brownColor];     // 60|40|20|1.
    UIColor *springGreen = [UIColor colorWithRed:.45 green:.75 blue:.5 alpha:1];       // 45|75|50|1.
    UIColor *darkGray = [UIColor darkGrayColor];    // 333|333|333|1       // 00|00|00|1.
    
    //all same values
    
    /*
     UIColor *gray = [UIColor grayColor];    // 50|50|50|1.
     UIColor *white  = [UIColor whiteColor]; // 1.|1.|1.|1.
     WHITE IS NOT WORKING CORRECTLY, NEITHER IS GRAY.  I think something about how similar black and gray and white are--with no red/blue/green to be offset by, affects the algorithm
     */
    
    NSMutableArray *veryEasyColors = [[NSMutableArray alloc] init];
    NSMutableArray *easyColors = [[NSMutableArray alloc] init];
    NSMutableArray *mediumColors = [[NSMutableArray alloc] init];
    NSMutableArray *hardColors = [[NSMutableArray alloc] init];
    NSMutableArray *masterColors = [[NSMutableArray alloc] init];
    
    if (mode == 0)
    {
        veryEasyColors = [ @[ red, green, blue, royalRed, royalGreen, royalBlue, darkRed, darkGreen, darkBlue ] mutableCopy];
        easyColors = [ @[ yellow, cyan, magenta, purple, teal, weedGreen, pink, orange, limeGreen, brightGreen, mildBlue, brightPurple ] mutableCopy];
        mediumColors = [ @[ coral, paleYellow, softGreen, skyBlue, periwinkle, fuschia ] mutableCopy];
        //I think hard and medium should be switched... to go from switching three colors back to two doesn't make sense.  it would be better to make the two color choices just not include the colors they've already encountered in easy unless somtehing new had been brought to the table... like alpha, which it has not.
        hardColors = [ @[ yellow, cyan, magenta, purple, teal, weedGreen, pink, orange, limeGreen, brightGreen, mildBlue, brightPurple, goldenrod, mildFuschia, mildTeal, midnightPurple, stormySea, poopGreen, coralRose, boldOrange, bluePurple, lighterBlue, vividRose, vividGreen, vividPurple, umber, lightBlue, mildGreen, deepBlue, deepPink, deepGreen, deepPurple, summerGreen, burntOrange, sunflower, bubblegum, candyPurple, yellowGreen, aquaBlue, aquaGreen ] mutableCopy];
        masterColors = [ @[  ] mutableCopy];
    }
    else if (mode == 1)
    {
        veryEasyColors = [ @[  ] mutableCopy];
        easyColors = [ @[  ] mutableCopy];
        mediumColors = [ @[  ] mutableCopy];
        hardColors = [ @[  ] mutableCopy];
        masterColors = [ @[  ] mutableCopy];
    }
    else if (mode == 2)
    {
        veryEasyColors = [ @[  ] mutableCopy];
        easyColors = [ @[  ] mutableCopy];
        mediumColors = [ @[  ] mutableCopy];
        hardColors = [ @[  ] mutableCopy];
        masterColors = [ @[  ] mutableCopy];
    }
    else
    {
        veryEasyColors = [ @[  ] mutableCopy];
        easyColors = [ @[  ] mutableCopy];
        mediumColors = [ @[  ] mutableCopy];
        hardColors = [ @[  ] mutableCopy];
        masterColors = [ @[  ] mutableCopy];
    }
    
    NSArray *arrayOfArrays = @[ veryEasyColors, easyColors, mediumColors, hardColors, masterColors ];
    return arrayOfArrays;
}

/*
 Okay--so colors should now be set up by mode.
 Simple:
 VE-single color, .5, .75, 1    :)
 E-mix two, .5, 1               :)
 M-mix three, .5, 1             :0 this doesn't seem like enough
 H-mix two, .25, .5, .75, 1     :0 just need `25 and 50`
 M-mix three, .25, .5, .75, 1
 
 Basic:
 VE-mix two, .5, 1
 E-mix two, .2, .5, .7, 1
 M-mix three, .2, .5, .7, 1
 H-mix three, .2, .4, .5, .6, .8, 1
 M-mix three, .1, .2, .3, .4, .5, .6, .7, .8, .9, 1
 
 Moderate:
 VE-mix two, .25, .5, .75, 1
 E-mix three, .25, .5, .75, 1
 M-mix three, .1, .25, .4, .5, .6, .75, .9, 1
 H-mix three, .1, .2, .25, .3, .4, .5, .6, .7, .75, .8, .9, 1
 M-mix three, .05, .1, .15, .2, .25, .3, .35, .4, .45, .5, .55, .6, .65, .7, .75, .8, .85, .9, .95, 1
 
 Challenging:
 Forthcoming!
 */

@end
