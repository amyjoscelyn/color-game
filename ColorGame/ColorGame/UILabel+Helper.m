//
//  UILabel+Helper.m
//  ColorGame
//
//  Created by Amy Joscelyn on 4/15/16.
//  Copyright © 2016 Amy Joscelyn. All rights reserved.
//

#import "UILabel+Helper.h"

@implementation UILabel (Helper)

- (void)setSubstituteFontName:(NSString *)name UI_APPEARANCE_SELECTOR
{
    self.font = [UIFont fontWithName:name size:self.font.pointSize];
}

@end
