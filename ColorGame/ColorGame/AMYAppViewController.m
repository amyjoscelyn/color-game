//
//  AMYAppViewController.m
//  ColorGame
//
//  Created by Amy Joscelyn on 12/9/15.
//  Copyright © 2015 Amy Joscelyn. All rights reserved.
//

#import "AMYAppViewController.h"
#import "AMYSharedDataStore.h"
#import <Masonry/Masonry.h>

@interface AMYAppViewController ()

@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (strong, nonatomic) AMYSharedDataStore *store;

@end

@implementation AMYAppViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.store = [AMYSharedDataStore sharedDataStore];
    
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
    
    [controller.view mas_updateConstraints:^(MASConstraintMaker *make)
    {
//        make.edges.equalTo(@0);
        
        make.left.right.and.bottom.equalTo(self.containerView);
        make.top.equalTo(@(self.navigationController.navigationBar.frame.size.height + 35));
        
        //is there a way to make the top edge equal to the bottom of the nav bar?
        /* perhaps
         make.left.right.and.bottom.equalTo(superview);
         make.top.equalTo(otherView);
         */
    }];
    
    [controller didMoveToParentViewController:self];
}

@end
