//
//  AMYGameDifficultyViewController.m
//  RandomFeaturesSequel
//
//  Created by Amy Joscelyn on 12/8/15.
//  Copyright © 2015 Amy Joscelyn. All rights reserved.
//

#import "AMYGameDifficultyViewController.h"
#import "AMYColorGameViewController.h"

@interface AMYGameDifficultyViewController () <AMYColorGameViewControllerDelegate>

@end

@implementation AMYGameDifficultyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)AMYColorGameViewControllerDidCancel:(AMYColorGameViewController *)viewController
{
    [viewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UIButton *)sender
{
    NSString *difficulty = @"";
//    NSLog(@"DIFFICULTY SELECTED: %@", sender.titleLabel.text);
    
    if ([sender.titleLabel.text isEqualToString:@"Very Easy"])
    {
        difficulty = @"very easy";
    }
    else if ([sender.titleLabel.text isEqualToString:@"Easy"])
    {
        difficulty = @"easy";
    }
    else if ([sender.titleLabel.text isEqualToString:@"Medium"])
    {
        difficulty = @"medium";
    }
    else if ([sender.titleLabel.text isEqualToString:@"Hard"])
    {
        difficulty = @"hard";
    }
    else
    {
        difficulty = @"master";
    }
    AMYColorGameViewController *gameDVC = segue.destinationViewController;
    gameDVC.difficulty = difficulty;
    gameDVC.delegate = self;
}

@end
