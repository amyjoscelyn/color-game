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
    
    self.store = [AMYSharedDataStore sharedDataStore];
    
    if ([sender.titleLabel.text isEqualToString:@"Very Easy"])
    {
        self.store.difficulty = 0;
    }
    else if ([sender.titleLabel.text isEqualToString:@"Easy"])
    {
        self.store.difficulty = 1;
    }
    else if ([sender.titleLabel.text isEqualToString:@"Medium"])
    {
        self.store.difficulty = 2;
    }
    else if ([sender.titleLabel.text isEqualToString:@"Hard"])
    {
        self.store.difficulty = 3;
    }
    else
    {
        self.store.difficulty = 4;
    }
    NSLog(@"difficulty chosen: %lu", self.store.difficulty);
    AMYColorGameViewController *gameDVC = segue.destinationViewController;
    gameDVC.delegate = self;
}

@end
