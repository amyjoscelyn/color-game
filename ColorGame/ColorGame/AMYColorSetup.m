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
    UIColor *darkSea = [UIColor colorWithRed:0 green:.25 blue:.5 alpha:1];    // 00|25|50|1.
    UIColor *darkPurple = [UIColor colorWithRed:.25 green:0 blue:.5 alpha:1];    // 25|00|50|1.
    UIColor *forestGreen = [UIColor colorWithRed:0 green:.5 blue:.25 alpha:1];    // 00|50|25|1.
    UIColor *grass = [UIColor colorWithRed:.25 green:.5 blue:0 alpha:1];    // 25|50|00|1.
    UIColor *darkRose = [UIColor colorWithRed:.5 green:0 blue:.25 alpha:1];    // 50|00|25|1.
    UIColor *burntUmber = [UIColor colorWithRed:.5 green:.25 blue:0 alpha:1];    // 50|25|00|1.
    
    
//    UIColor *dustyRose = [UIColor colorWithRed:.6 green:0 blue:.2 alpha:1];                               // 60|00|20|1.
//    UIColor *darkTeal = [UIColor colorWithRed:0 green:.2 blue:.4 alpha:1];                               // 00|20|40|1.
    
    
    //Triple Value Colors
    //all same values
    UIColor *white = [UIColor whiteColor];      // 1.|1.|1.|1.
    UIColor *lightGray = [UIColor colorWithRed:.75 green:.75 blue:.75 alpha:1];    // 75|75|75|1.
    UIColor *gray = [UIColor colorWithRed:.5 green:.5 blue:.5 alpha:1];    // 50|50|50|1.
    UIColor *darkGray = [UIColor colorWithRed:.25 green:.25 blue:.25 alpha:1];    // 25|25|25|1.
    
    //mostly 1.
    UIColor *babyYellow = [UIColor colorWithRed:1 green:1 blue:.75 alpha:1];                               // 1.|1.|75|1.
    UIColor *paleYellow = [UIColor colorWithRed:1 green:1 blue:.5 alpha:1];                               // 1.|1.|50|1.
    UIColor *sunnyYellow = [UIColor colorWithRed:1 green:1 blue:.25 alpha:1];                               // 1.|1.|25|1.
    
    UIColor *babyBlue = [UIColor colorWithRed:.75 green:1 blue:1 alpha:1];                               // 75|1.|1.|1.
    UIColor *skyBlue = [UIColor colorWithRed:.5 green:1 blue:1 alpha:1];                               // 50|1.|1.|1.
    UIColor *tropicalBlue = [UIColor colorWithRed:.25 green:1 blue:1 alpha:1];                               // 25|1.|1.|1.
    
    UIColor *babyPink = [UIColor colorWithRed:1 green:.75 blue:1 alpha:1];                               // 1.|75|1.|1.
    UIColor *fuschia = [UIColor colorWithRed:1 green:.5 blue:1 alpha:1];                               // 1.|50|1.|1.
    UIColor *vividPink = [UIColor colorWithRed:1 green:.25 blue:1 alpha:1];                               // 1.|25|1.|1.
    
    //mostly .75
    UIColor *lightPurpleGray = [UIColor colorWithRed:.75 green:.75 blue:1 alpha:1];                               // 75|75|1.|1.
    UIColor *paleBrass = [UIColor colorWithRed:.75 green:.75 blue:.5 alpha:1];                               // 75|75|50|1.
    UIColor *sickBabyPoopGreen = [UIColor colorWithRed:.75 green:.75 blue:.25 alpha:1];                               // 75|75|25|1.
    
    UIColor *salmon = [UIColor colorWithRed:1 green:.75 blue:.75 alpha:1];                               // 1.|75|75|1.
    UIColor *grayAqua = [UIColor colorWithRed:.5 green:.75 blue:.75 alpha:1];                               // 50|75|75|1.
    UIColor *aquamarine = [UIColor colorWithRed:.25 green:.75 blue:.75 alpha:1];                               // 25|75|75|1.
    
    UIColor *paleGreen = [UIColor colorWithRed:.75 green:1 blue:.75 alpha:1];                               // 75|1.|75|1.
    UIColor *dusk = [UIColor colorWithRed:.75 green:.5 blue:.75 alpha:1];                               // 75|50|75|1.
    UIColor *vividFuschia = [UIColor colorWithRed:.75 green:.25 blue:.75 alpha:1];                               // 75|25|75|1.
    
    //mostly .5
    UIColor *coral = [UIColor colorWithRed:1 green:.5 blue:.5 alpha:1];                               // 1.|50|50|1.
    UIColor *sequoia = [UIColor colorWithRed:.75 green:.5 blue:.5 alpha:1];                               // 75|50|50|1.
    UIColor *darkAqua = [UIColor colorWithRed:.25 green:.5 blue:.5 alpha:1];                               // 25|50|50|1.
    
    UIColor *softGreen = [UIColor colorWithRed:.5 green:1 blue:.5 alpha:1];                               // 50|1.|50|1.
    UIColor *dullGreen = [UIColor colorWithRed:.5 green:.75 blue:.5 alpha:1];                               // 50|75|50|1.
    UIColor *grape = [UIColor colorWithRed:.5 green:.25 blue:.5 alpha:1];                               // 50|25|50|1.
    
    UIColor *periwinkle = [UIColor colorWithRed:.5 green:.5 blue:1 alpha:1];                             // 50|50|1.|1.
    UIColor *lapisPurple = [UIColor colorWithRed:.5 green:.5 blue:.75 alpha:1];                             // 50|50|75|1.
    UIColor *uglyYellow = [UIColor colorWithRed:.5 green:.5 blue:.25 alpha:1];                             // 50|50|25|1.
    
    //mostly .25
    UIColor *brightCoral = [UIColor colorWithRed:1 green:.25 blue:.25 alpha:1];                               // 1.|25|25|1.
    UIColor *vermillion = [UIColor colorWithRed:.75 green:.25 blue:.25 alpha:1];                               // 75|25|25|1.
    UIColor *fadedRed = [UIColor colorWithRed:.5 green:.25 blue:.25 alpha:1];                               // 50|25|25|1.
    
    UIColor *soGreen = [UIColor colorWithRed:.25 green:1 blue:.25 alpha:1];                               // 25|1.|25|1.
    UIColor *fieldGreen = [UIColor colorWithRed:.25 green:.75 blue:.25 alpha:1];                               // 25|75|25|1.
    UIColor *shadyForest = [UIColor colorWithRed:.25 green:.5 blue:.25 alpha:1];                               // 25|50|25|1.
    
    UIColor *soBlue = [UIColor colorWithRed:.25 green:.25 blue:1 alpha:1];                             // 25|25|1.|1.
    UIColor *lightIndigo = [UIColor colorWithRed:.25 green:.25 blue:.75 alpha:1];                             // 25|25|75|1.
    UIColor *indigo = [UIColor colorWithRed:.25 green:.25 blue:.5 alpha:1];                             // 25|25|50|1.
    
    //one of each
    //no 25
    UIColor *easterYellow = [UIColor colorWithRed:1 green:.75 blue:.5 alpha:1];                             // 1.|75|50|1.
    UIColor *easterPink = [UIColor colorWithRed:1 green:.5 blue:.75 alpha:1];                             // 1.|50|75|1.
    UIColor *easterGreen = [UIColor colorWithRed:.75 green:1 blue:.5 alpha:1];                             // 75|1.|50|1.
    UIColor *easterTeal = [UIColor colorWithRed:.5 green:1 blue:.75 alpha:1];                             // 50|1.|75|1.
    UIColor *easterPurple = [UIColor colorWithRed:.75 green:.5 blue:1 alpha:1];                             // 75|50|1.|1.
    UIColor *easterBlue = [UIColor colorWithRed:.5 green:.75 blue:1 alpha:1];                             // 50|75|1.|1.
    
    //no 50
    UIColor *summerYellow = [UIColor colorWithRed:1 green:.75 blue:.25 alpha:1];                             // 1.|75|25|1.
    UIColor *summerPink = [UIColor colorWithRed:1 green:.25 blue:.75 alpha:1];                             // 1.|25|75|1.
    UIColor *neonYellow = [UIColor colorWithRed:.75 green:1 blue:.25 alpha:1];                             // 75|1.|25|1.
    UIColor *modGreen = [UIColor colorWithRed:.25 green:1 blue:.75 alpha:1];                             // 25|1.|75|1.
    UIColor *summerViolet = [UIColor colorWithRed:.75 green:.25 blue:1 alpha:1];                             // 75|25|1.|1.
    UIColor *summerBlue = [UIColor colorWithRed:.25 green:.75 blue:1 alpha:1];                             // 25|75|1.|1.
    
    //no 75
    UIColor *autumnPink = [UIColor colorWithRed:1 green:.25 blue:.5 alpha:1];                             // 1.|25|50|1.
    UIColor *autumnOrange = [UIColor colorWithRed:1 green:.5 blue:.25 alpha:1];                             // 1.|50|25|1.
    UIColor *winterGreen = [UIColor colorWithRed:.25 green:1 blue:.5 alpha:1];                             // 25|1.|50|1.
    UIColor *neonGreen = [UIColor colorWithRed:.5 green:1 blue:.25 alpha:1];                             // 50|1.|25|1.
    UIColor *winterBlue = [UIColor colorWithRed:.25 green:.5 blue:1 alpha:1];                             // 25|50|1.|1.
    UIColor *cornBlue = [UIColor colorWithRed:.5 green:.25 blue:1 alpha:1];                             // 50|25|1.|1.
    
    //no 1.
    UIColor *blueGreen = [UIColor colorWithRed:.25 green:.75 blue:.5 alpha:1];                             // 25|75|50|1.
    UIColor *moreBlue = [UIColor colorWithRed:.25 green:.5 blue:.75 alpha:1];                             // 25|50|75|1.
    UIColor *autumnLeaf = [UIColor colorWithRed:.75 green:.25 blue:.5 alpha:1];                             // 75|25|50|1.
    UIColor *violet = [UIColor colorWithRed:.5 green:.25 blue:.75 alpha:1];                             // 50|25|75|1.
    UIColor *cornHusk = [UIColor colorWithRed:.75 green:.5 blue:.25 alpha:1];                             // 75|50|25|1.
    UIColor *realGreen = [UIColor colorWithRed:.5 green:.75 blue:.25 alpha:1];                             // 50|75|25|1.
    
    
    
    
        // 00|00|00|1.
    
    
//    UIColor *brown  = [UIColor brownColor];     // 60|40|20|1.
//    UIColor *springGreen = [UIColor colorWithRed:.45 green:.75 blue:.5 alpha:1];       // 45|75|50|1.
    
    NSMutableArray *veryEasyColors = [[NSMutableArray alloc] init];
    NSMutableArray *easyColors = [[NSMutableArray alloc] init];
    NSMutableArray *mediumColors = [[NSMutableArray alloc] init];
    NSMutableArray *hardColors = [[NSMutableArray alloc] init];
    NSMutableArray *masterColors = [[NSMutableArray alloc] init];
    
    if (mode == 0)
    {
        veryEasyColors = [ @[ red, green, blue, royalRed, royalGreen, royalBlue, darkRed, darkGreen, darkBlue ] mutableCopy];
        
        easyColors = [ @[ yellow, cyan, magenta, purple, teal, weedGreen, pink, orange, limeGreen, brightGreen, mildBlue, brightPurple ] mutableCopy];
        
        mediumColors = [ @[ yellow, cyan, magenta, purple, teal, weedGreen, pink, orange, limeGreen, brightGreen, mildBlue, brightPurple, goldenrod, mildFuschia, mildTeal, midnightPurple, stormySea, poopGreen, coralRose, boldOrange, bluePurple, lighterBlue, vividRose, vividGreen, vividPurple, umber, lightBlue, mildGreen, deepBlue, deepPink, deepGreen, deepPurple, summerGreen, burntOrange, sunflower, bubblegum, candyPurple, yellowGreen, aquaBlue, aquaGreen, darkSea, darkPurple, forestGreen, grass, darkRose, burntUmber ] mutableCopy];
        
        hardColors = [ @[ coral, paleYellow, softGreen, skyBlue, periwinkle, fuschia, white ] mutableCopy];
        
        masterColors = [ @[ white, lightGray, gray, darkGray, babyYellow, paleYellow, sunnyYellow, babyBlue, skyBlue, tropicalBlue, babyPink, fuschia, vividPink, lightPurpleGray, paleBrass, sickBabyPoopGreen, salmon, grayAqua, aquamarine, paleGreen, dusk, vividFuschia, coral, sequoia, darkAqua, softGreen, dullGreen, grape, periwinkle, lapisPurple, uglyYellow, brightCoral, vermillion, fadedRed, soGreen, fieldGreen, shadyForest, soBlue, lightIndigo, indigo, easterYellow, easterPink, easterGreen, easterTeal, easterPurple, easterBlue, summerYellow, summerPink, summerViolet, summerBlue, neonYellow, modGreen, autumnPink, autumnOrange, winterGreen, winterBlue, neonGreen, cornBlue, blueGreen, moreBlue, autumnLeaf, violet, cornHusk, realGreen ] mutableCopy];
    }
    else if (mode == 1)
    {
        veryEasyColors = [ @[ yellow, cyan, magenta, purple, teal, weedGreen, pink, orange, limeGreen, brightGreen, mildBlue, brightPurple ] mutableCopy];
        easyColors = [ @[  ] mutableCopy];
        mediumColors = [ @[  ] mutableCopy];
        hardColors = [ @[  ] mutableCopy];
        masterColors = [ @[  ] mutableCopy];
    }
    else if (mode == 2)
    {
        veryEasyColors = [ @[ yellow, cyan, magenta, purple, teal, weedGreen, pink, orange, limeGreen, brightGreen, mildBlue, brightPurple, goldenrod, mildFuschia, mildTeal, midnightPurple, stormySea, poopGreen, coralRose, boldOrange, bluePurple, lighterBlue, vividRose, vividGreen, vividPurple, umber, lightBlue, mildGreen, deepBlue, deepPink, deepGreen, deepPurple, summerGreen, burntOrange, sunflower, bubblegum, candyPurple, yellowGreen, aquaBlue, aquaGreen, darkSea, darkPurple, forestGreen, grass, darkRose, burntUmber ] mutableCopy];
        easyColors = [ @[ white, lightGray, gray, darkGray, babyYellow, paleYellow, sunnyYellow, babyBlue, skyBlue, tropicalBlue, babyPink, fuschia, vividPink, lightPurpleGray, paleBrass, sickBabyPoopGreen, salmon, grayAqua, aquamarine, paleGreen, dusk, vividFuschia, coral, sequoia, darkAqua, softGreen, dullGreen, grape, periwinkle, lapisPurple, uglyYellow, brightCoral, vermillion, fadedRed, soGreen, fieldGreen, shadyForest, soBlue, lightIndigo, indigo, easterYellow, easterPink, easterGreen, easterTeal, easterPurple, easterBlue, summerYellow, summerPink, summerViolet, summerBlue, neonYellow, modGreen, autumnPink, autumnOrange, winterGreen, winterBlue, neonGreen, cornBlue, blueGreen, moreBlue, autumnLeaf, violet, cornHusk, realGreen ] mutableCopy];
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
 M-mix two, .25, .5, .75, 1     :)
 H-mix three, .5, 1             :0 this doesn't seem like enough
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
