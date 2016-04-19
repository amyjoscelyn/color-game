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
    [self setEmbeddedViewController:difficultyVC name:@"menu"];
}

- (void)showZenGame
{
    UIViewController *zenVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ZenViewController"];
    [self setEmbeddedViewController:zenVC name:@"zen"];
}

- (void)setEmbeddedViewController:(UIViewController *)controller name:(NSString *)name
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
        make.left.right.and.bottom.equalTo(self.containerView);
        
        if ([name isEqualToString:@"menu"])
        {
            make.top.equalTo(@(self.navigationController.navigationBar.frame.size.height + 36));
        }
        else
        {
            make.top.equalTo(@(self.navigationController.navigationBar.frame.size.height));
        }
    }];
    
    [controller didMoveToParentViewController:self];
}

@end
