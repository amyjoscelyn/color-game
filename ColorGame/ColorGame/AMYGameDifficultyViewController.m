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

@property (weak, nonatomic) IBOutlet UIButton *veryEasyButton;
@property (weak, nonatomic) IBOutlet UIButton *easyButton;
@property (weak, nonatomic) IBOutlet UIButton *mediumButton;
@property (weak, nonatomic) IBOutlet UIButton *hardButton;
@property (weak, nonatomic) IBOutlet UIButton *masterButton;

@property (strong, nonatomic) AMYSharedDataStore *store;

@end

@implementation AMYGameDifficultyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.store = [AMYSharedDataStore sharedDataStore];
}

- (void)viewWillAppear:(BOOL)animated
{
    NSArray *buttons = [NSArray arrayWithObjects:self.veryEasyButton, self.easyButton, self.mediumButton, self.hardButton, self.masterButton, nil];
    NSArray *colors = self.store.colorsForGradient;
    
    NSUInteger i = 0;
    
    for (UIButton *button in buttons)
    {
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        
        CAGradientLayer *buttonGradient = [CAGradientLayer layer];
        buttonGradient.frame = button.bounds;
        buttonGradient.colors = [NSArray arrayWithObjects:
                                 (id)[colors[i] CGColor],
                                 (id)[colors[i+1] CGColor],
                                 nil];
        [button.layer insertSublayer:buttonGradient atIndex:0];
        
        CALayer *buttonLayer = [button layer];
        [buttonLayer setMasksToBounds:YES];
        [buttonLayer setCornerRadius:5.0f];
        
        [buttonLayer setBorderWidth:1.0f];
        [buttonLayer setBorderColor:[[UIColor blackColor] CGColor]];
        i++;
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.store rotateColorsInArray];
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
    
    AMYColorGameViewController *gameDVC = segue.destinationViewController;
    gameDVC.delegate = self;
}

@end
