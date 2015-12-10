//
//  AMYGameDifficultyViewController.m
//  RandomFeaturesSequel
//
//  Created by Amy Joscelyn on 12/8/15.
//  Copyright © 2015 Amy Joscelyn. All rights reserved.
//

#import "AMYGameDifficultyViewController.h"
#import "AMYColorGameViewController.h"
#import "AMYSharedDataStore.h"

@interface AMYGameDifficultyViewController () <AMYColorGameViewControllerDelegate>

@property (strong, nonatomic) AMYSharedDataStore *store;

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
        self.store.difficulty = 0;
    }
    else if ([sender.titleLabel.text isEqualToString:@"Easy"])
    {
        difficulty = @"easy";
        self.store.difficulty = 1;
    }
    else if ([sender.titleLabel.text isEqualToString:@"Medium"])
    {
        difficulty = @"medium";
        self.store.difficulty = 2;
    }
    else if ([sender.titleLabel.text isEqualToString:@"Hard"])
    {
        difficulty = @"hard";
        self.store.difficulty = 3;
    }
    else
    {
        difficulty = @"master";
        self.store.difficulty = 4;
    }
    AMYColorGameViewController *gameDVC = segue.destinationViewController;
    gameDVC.difficulty = difficulty;
    gameDVC.delegate = self;
}

@end
