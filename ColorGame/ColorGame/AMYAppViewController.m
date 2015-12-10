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
    
    NSLog(@"Mode: %@,\nDifficulty: %@", self.store.mode, self.store.difficulty);
}

-(void)setEmbeddedViewController:(UIViewController *)controller
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
    //constrain container.view to super view--all the way to edges!
    [controller didMoveToParentViewController:self];
}

@end
