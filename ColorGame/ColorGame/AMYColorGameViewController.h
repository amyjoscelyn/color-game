//
//  AMYColorGameViewController.h
//  RandomFeaturesSequel
//
//  Created by Amy Joscelyn on 12/2/15.
//  Copyright © 2015 Amy Joscelyn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AMYColorGameViewController;

@protocol AMYColorGameViewControllerDelegate <NSObject>

- (void)AMYColorGameViewControllerDidCancel:(AMYColorGameViewController *)viewController;

@end

@interface AMYColorGameViewController : UIViewController

@property (nonatomic, weak) id<AMYColorGameViewControllerDelegate> delegate;

@end
