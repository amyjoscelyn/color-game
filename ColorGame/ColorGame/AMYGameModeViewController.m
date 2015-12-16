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
//                       [UIColor colorWithRed:153.0f /255.0f green:38.25f / 255.0f blue:25.5f / 255.0f alpha:1.0f],
//                       [UIColor colorWithRed:216.75f /255.0f green:0.0f / 255.0f blue:0.0f / 255.0f alpha:1.0f],
//                       [UIColor colorWithRed:178.5f /255.0f green:0.0f / 255.0f blue:76.5f / 255.0f alpha:1.0f],
//                       [UIColor colorWithRed:140.25f / 255.0f green:0.0f / 255.0f blue:63.75f / 255.0f alpha:1.0f],
//                       [UIColor colorWithRed:150.0f /255.0f green:0.0f / 255.0f blue:101.0f / 255.0f alpha:1.0f],
//                       [UIColor colorWithRed:102.5f /255.0f green:12.75f / 255.0f blue:89.25f / 255.0f alpha:1.0f],
                       
//                       [UIColor colorWithRed:166.0f /255.0f green:0.0f / 255.0f blue:0.0f / 255.0f alpha:1.0f],
//                       [UIColor colorWithRed:178.5f /255.0f green:64.0f / 255.0f blue:0.0f / 255.0f alpha:1.0f],
//                       [UIColor colorWithRed:178.5f /255.0f green:102.0f / 255.0f blue:0.0f / 255.0f alpha:1.0f],
//                       [UIColor colorWithRed:217.0f / 255.0f green:127.5f / 255.0f blue:0.0f / 255.0f alpha:1.0f],
//                       [UIColor colorWithRed:229.5f /255.0f green:166.0f / 255.0f blue:0.0f / 255.0f alpha:1.0f],
//                       [UIColor colorWithRed:255.0f /255.0f green:166.0f / 255.0f blue:0.0f / 255.0f alpha:1.0f],
                       
//                       [UIColor colorWithRed:255.0f /255.0f green:217.0f / 255.0f blue:0.0f / 255.0f alpha:1.0f],
//                       [UIColor colorWithRed:255.0f /255.0f green:255.0f / 255.0f blue:0.0f / 255.0f alpha:1.0f],
//                       [UIColor colorWithRed:204.0f /255.0f green:255.0f / 255.0f blue:0.0f / 255.0f alpha:1.0f],
//                       [UIColor colorWithRed:153.0f /255.0f green:255.0f / 255.0f blue:0.0f / 255.0f alpha:1.0f],
//                       [UIColor colorWithRed:135.0f /255.0f green:242.0f / 255.0f blue:242.0f / 255.0f alpha:1.0f],
//                       [UIColor colorWithRed:89.0f /255.0f green:229.5f / 255.0f blue:178.5f / 255.0f alpha:1.0f],
                       
//                       [UIColor colorWithRed:89.0f /255.0f green:217.0f / 255.0f blue:204.0f / 255.0f alpha:1.0f],
//                       [UIColor colorWithRed:51.0f /255.0f green:204.0f / 255.0f blue:217.0f / 255.0f alpha:1.0f],
//                       [UIColor colorWithRed:0.0f /255.0f green:178.5f / 255.0f blue:242.0f / 255.0f alpha:1.0f],
//                       [UIColor colorWithRed:0.0f /255.0f green:140.0f / 255.0f blue:242.0f / 255.0f alpha:1.0f],
//                       [UIColor colorWithRed:0.0f /255.0f green:115.0f / 255.0f blue:255.0f / 255.0f alpha:1.0f],
//                       [UIColor colorWithRed:103.0f /255.0f green:89.0f / 255.0f blue:255.0f / 255.0f alpha:1.0f],
                       
//                       [UIColor colorWithRed:140.0f /255.0f green:76.5f / 255.0f blue:255.0f / 255.0f alpha:1.0f],
//                       [UIColor colorWithRed:140.0f /255.0f green:38.0f / 255.0f blue:255.0f / 255.0f alpha:1.0f],
//                       [UIColor colorWithRed:140.0f /255.0f green:13.0f / 255.0f blue:229.5f / 255.0f alpha:1.0f],
                       [UIColor colorWithRed:140.0f /255.0f green:0.0f / 255.0f blue:191.0f / 255.0f alpha:1.0f],
                       [UIColor colorWithRed:140.0f /255.0f green:0.0f / 255.0f blue:140.0f / 255.0f alpha:1.0f],
                       [UIColor colorWithRed:153.0f /255.0f green:0.0f / 255.0f blue:115.0f / 255.0f alpha:1.0f],
                       
                       [UIColor colorWithRed:153.0f /255.0f green:0.0f / 255.0f blue:89.0f / 255.0f alpha:1.0f],
                       [UIColor colorWithRed:166.0f /255.0f green:0.0f / 255.0f blue:64.0f / 255.0f alpha:1.0f],
                       [UIColor colorWithRed:166.0f /255.0f green:0.0f / 255.0f blue:38.0f / 255.0f alpha:1.0f], nil];
    
    //it would be really neat to do this in a rotating way.  like, after it's presented (maybe in viewWillDisappear), the six gradients used can be added to the end and then deleted from the front.  Or maybe I can do something a little more subtle, which is to just delete the first one and add that to the end, and it slowly rotates that way.  It would take a long time for you to see the exact same gradient pattern on the buttons.  I like it!  Good prep too for my subtle background changes.
    
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
