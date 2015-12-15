//
//  AMYGameModeViewController.m
//  ColorGame
//
//  Created by Amy Joscelyn on 12/9/15.
//  Copyright © 2015 Amy Joscelyn. All rights reserved.
//

#import "AMYGameModeViewController.h"
#import "AMYAppViewController.h"
#import "AMYSharedDataStore.h"

@interface AMYGameModeViewController ()

@property (strong, nonatomic) AMYSharedDataStore *store;

@property (weak, nonatomic) IBOutlet UIButton *basicModeButton;
@property (weak, nonatomic) IBOutlet UIButton *moderateModeButton;
@property (weak, nonatomic) IBOutlet UIButton *challengingModeButton;

@end

@implementation AMYGameModeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.store = [[AMYSharedDataStore alloc] init];
    
    self.basicModeButton.enabled = NO;
    self.moderateModeButton.enabled = NO;
    self.challengingModeButton.enabled = NO;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UIButton *)sender
{    
    self.store = [AMYSharedDataStore sharedDataStore];
    
    if ([sender.titleLabel.text isEqualToString:@"Simple"])
    {
        self.store.mode = 0;
    }
    else if ([sender.titleLabel.text isEqualToString:@"Basic"])
    {
        self.store.mode = 1;
    }
    else if ([sender.titleLabel.text isEqualToString:@"Moderate"])
    {
        self.store.mode = 2;
    }
    else if ([sender.titleLabel.text isEqualToString:@"Challenging"])
    {
        self.store.mode = 3;
    }
    else
    {
        self.store.mode = 4;
    }
    NSLog(@"mode chosen: %lu", self.store.mode);
}

@end
