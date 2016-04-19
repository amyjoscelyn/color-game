//
//  AppDelegate.m
//  ColorGame
//
//  Created by Amy Joscelyn on 12/8/15.
//  Copyright © 2015 Amy Joscelyn. All rights reserved.
//

#import "AppDelegate.h"
#import "UILabel+Helper.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
//    NSString *fontName = @"GurmukhiMN"; //i like it, but it makes the buttons look weird
//    NSString *fontName = @"IowanOldStyle-Bold"; //hmm... too big, but nice. I think it's my favorite so far.
//    NSString *fontName = @"Palatino-Bold"; //not bad, but not spectacular
//    NSString *fontName = @"AvenirNextCondensed-Bold"; //growing on me
    NSString *fontName = @"";
    
    [[UILabel appearance] setSubstituteFontName:fontName];
    
    UINavigationBar *navBar = [UINavigationBar appearance];
    navBar.tintColor = [UIColor colorWithRed:47/255.0 green:44/255.0 blue:39/255.0 alpha:1.0];
//    navBar.barTintColor = [UIColor colorWithRed:47/255.0 green:44/255.0 blue:39/255.0 alpha:1.0];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
