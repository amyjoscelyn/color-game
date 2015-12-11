//
//  AMYAppViewController.m
//  ColorGame
//
//  Created by Amy Joscelyn on 12/9/15.
//  Copyright © 2015 Amy Joscelyn. All rights reserved.
//

#import "AMYAppViewController.h"
#import "AMYSharedDataStore.h"

@interface AMYAppViewController ()

@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (strong, nonatomic) AMYSharedDataStore *store;

@end

@implementation AMYAppViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.store = [AMYSharedDataStore sharedDataStore];
    
    NSLog(@"Mode: %lu,\nDifficulty: %lu", self.store.mode, self.store.difficulty);
    
    if (self.store.mode < 4)
    {
        [self showDifficultyOptions];
    }
    else
    {
        [self showZenGame];
    }
}

- (void)showDifficultyOptions
{
    UIViewController *difficultyVC = [self.storyboard instantiateViewControllerWithIdentifier:@"DifficultyViewController"];
    [self setEmbeddedViewController:difficultyVC];
}

- (void)showZenGame
{
    UIViewController *zenVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ZenViewController"];
    [self setEmbeddedViewController:zenVC];
}

- (void)setEmbeddedViewController:(UIViewController *)controller
{
    if([self.childViewControllers containsObject:controller])
    {
        return;
    }
    
    for(UIViewController *vc in self.childViewControllers)
    {
        [vc willMoveToParentViewController:nil];
        
        if(vc.isViewLoaded)
        {
            [vc.view removeFromSuperview];
        }
        
        [vc removeFromParentViewController];
    }

    if(!controller)
    {
        return;
    }
    
    [self addChildViewController:controller];
    [self.containerView addSubview:controller.view];
    [self.containerView.topAnchor constraintEqualToAnchor:controller.view.topAnchor].active = YES;
    [self.containerView.bottomAnchor constraintEqualToAnchor:controller.view.bottomAnchor].active = YES;
    [self.containerView.leadingAnchor constraintEqualToAnchor:controller.view.leadingAnchor].active = YES;
    [self.containerView.trailingAnchor constraintEqualToAnchor:controller.view.trailingAnchor].active = YES;
    //constrain container.view to super view--all the way to edges!
    [controller didMoveToParentViewController:self];
}

@end
