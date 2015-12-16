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

@property (weak, nonatomic) IBOutlet UIButton *simpleModeButton;
@property (weak, nonatomic) IBOutlet UIButton *basicModeButton;
@property (weak, nonatomic) IBOutlet UIButton *moderateModeButton;
@property (weak, nonatomic) IBOutlet UIButton *challengingModeButton;
@property (weak, nonatomic) IBOutlet UIButton *zenModeButton;

@end

@implementation AMYGameModeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.store = [[AMYSharedDataStore alloc] init];
    
    self.challengingModeButton.enabled = NO;
    
    
    NSArray *buttons = [NSArray arrayWithObjects:self.simpleModeButton, self.basicModeButton, self.moderateModeButton, self.challengingModeButton, self.zenModeButton, nil];
    
    NSArray *colors = [NSArray arrayWithObjects:
                       [UIColor colorWithRed:153.0f /255.0f green:38.25f / 255.0f blue:25.5f / 255.0f alpha:1.0f],
                       [UIColor colorWithRed:216.75f /255.0f green:0.0f / 255.0f blue:0.0f / 255.0f alpha:1.0f],
                       [UIColor colorWithRed:178.5f /255.0f green:0.0f / 255.0f blue:76.5f / 255.0f alpha:1.0f],
                       [UIColor colorWithRed:140.25f / 255.0f green:0.0f / 255.0f blue:63.75f / 255.0f alpha:1.0f],
                       [UIColor colorWithRed:150.0f /255.0f green:0.0f / 255.0f blue:101.0f / 255.0f alpha:1.0f],
                       [UIColor colorWithRed:102.5f /255.0f green:12.75f / 255.0f blue:89.25f / 255.0f alpha:1.0f],
                       
                       [UIColor colorWithRed:0.0f /255.0f green:0.0f / 255.0f blue:0.0f / 255.0f alpha:1.0f],
                       [UIColor colorWithRed:0.0f /255.0f green:0.0f / 255.0f blue:0.0f / 255.0f alpha:1.0f],
                       [UIColor colorWithRed:0.0f /255.0f green:0.0f / 255.0f blue:0.0f / 255.0f alpha:1.0f],
                       [UIColor colorWithRed:0.0f /255.0f green:0.0f / 255.0f blue:0.0f / 255.0f alpha:1.0f],
                       [UIColor colorWithRed:0.0f /255.0f green:0.0f / 255.0f blue:0.0f / 255.0f alpha:1.0f],
                       [UIColor colorWithRed:0.0f /255.0f green:0.0f / 255.0f blue:0.0f / 255.0f alpha:1.0f], nil];
    
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
}

@end
