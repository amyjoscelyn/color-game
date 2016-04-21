//
//  AMYZenViewController.m
//  ColorGame
//
//  Created by Amy Joscelyn on 12/14/15.
//  Copyright © 2015 Amy Joscelyn. All rights reserved.
//

#import "AMYZenViewController.h"
#import "AMYSharedDataStore.h"

@interface AMYZenViewController ()

@property (weak, nonatomic) IBOutlet UILabel *redBackgroundValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *greenBackgroundValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *blueBackgroundValueLabel;

@property (weak, nonatomic) IBOutlet UIButton *lessRedButton;
@property (weak, nonatomic) IBOutlet UIButton *moreRedButton;
@property (weak, nonatomic) IBOutlet UIButton *lessGreenButton;
@property (weak, nonatomic) IBOutlet UIButton *moreGreenButton;
@property (weak, nonatomic) IBOutlet UIButton *lessBlueButton;
@property (weak, nonatomic) IBOutlet UIButton *moreBlueButton;

@property (weak, nonatomic) IBOutlet UIButton *hideFeatureButton;
@property (weak, nonatomic) IBOutlet UIButton *refreshViewButton;
@property (weak, nonatomic) IBOutlet UISegmentedControl *incrementSegmentedControl;

//@property (nonatomic) NSUInteger numberOfTimesRedButtonTapped;
//@property (nonatomic) NSUInteger numberOfTimesGreenButtonTapped;
//@property (nonatomic) NSUInteger numberOfTimesBlueButtonTapped;

@property (nonatomic) CGFloat colorWithRedFloat;
@property (nonatomic) CGFloat colorWithGreenFloat;
@property (nonatomic) CGFloat colorWithBlueFloat;

@property (nonatomic) NSInteger redInteger;
@property (nonatomic) NSInteger greenInteger;
@property (nonatomic) NSInteger blueInteger;

//@property (nonatomic) NSUInteger tapCapMax;
//@property (nonatomic) NSUInteger tapCapMin;
@property (nonatomic) CGFloat multiplier;
@property (nonatomic) NSInteger incrementValue;

@property (nonatomic, strong) AMYSharedDataStore *store;

@end

@implementation AMYZenViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setDefaultBackground];
    
    self.store = [AMYSharedDataStore sharedDataStore];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSArray *buttons = [NSArray arrayWithObjects:self.lessRedButton, self.moreRedButton, self.lessGreenButton, self.moreGreenButton, self.lessBlueButton, self.moreBlueButton, nil];
    NSArray *colors = self.store.colorsForGameButtons;
    
    NSUInteger i = 0;
    NSUInteger j = 1;
    
    for (UIButton *button in buttons)
    {
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        
        CAGradientLayer *buttonGradient = [CAGradientLayer layer];
        buttonGradient.frame = button.bounds;
        buttonGradient.colors = [NSArray arrayWithObjects:
                                 (id)[colors[i] CGColor],
                                 (id)[colors[j] CGColor],
                                 nil];
        [button.layer insertSublayer:buttonGradient atIndex:0];
        
        CALayer *buttonLayer = [button layer];
        [buttonLayer setMasksToBounds:YES];
        [buttonLayer setCornerRadius:5.0f];
        
        [buttonLayer setBorderWidth:1.0f];
        [buttonLayer setBorderColor:[[UIColor blackColor] CGColor]];
        i += 2;
        j += 2;
    }
}

- (void)setDefaultBackground
{
    self.view.backgroundColor = [UIColor blackColor];
    
    NSArray *colorValueLabels = @[ self.redBackgroundValueLabel,
                                   self.greenBackgroundValueLabel,
                                   self.blueBackgroundValueLabel];
    UIColor *textColor = [UIColor whiteColor];
    
    for (UILabel *colorValueLabel in colorValueLabels)
    {
        colorValueLabel.textColor = textColor;
        colorValueLabel.layer.shadowColor = textColor.CGColor;
        colorValueLabel.layer.shadowRadius = 4.0f;
        colorValueLabel.layer.shadowOpacity = .9;
        colorValueLabel.layer.shadowOffset = CGSizeZero;
        colorValueLabel.layer.masksToBounds = NO;
    }
    
    self.multiplier = 64/256.0;
    self.incrementValue = self.multiplier * 256;
    
    self.incrementSegmentedControl.selectedSegmentIndex = 3;
    
    self.colorWithRedFloat = 0.0;
    self.colorWithGreenFloat = 0.0;
    self.colorWithBlueFloat = 0.0;
    
    self.redInteger = 0;
    self.greenInteger = 0;
    self.blueInteger = 0;
    
    self.redBackgroundValueLabel.text = [NSString stringWithFormat:@"R: 0"];
    self.greenBackgroundValueLabel.text = [NSString stringWithFormat:@"G: 0"];
    self.blueBackgroundValueLabel.text = [NSString stringWithFormat:@"B: 0"];
    
    self.lessRedButton.enabled = YES;
    self.moreRedButton.enabled = YES;
    self.lessGreenButton.enabled = YES;
    self.moreGreenButton.enabled = YES;
    self.lessBlueButton.enabled = YES;
    self.moreBlueButton.enabled = YES;
}

- (void)changeBackgroundColor
{
    self.view.backgroundColor = [UIColor colorWithRed:self.colorWithRedFloat green:self.colorWithGreenFloat blue:self.colorWithBlueFloat alpha:1.0];
    
    self.redBackgroundValueLabel.text = [NSString stringWithFormat:@"R: %.0f", self.colorWithRedFloat*256];
    self.greenBackgroundValueLabel.text = [NSString stringWithFormat:@"G: %.0f", self.colorWithGreenFloat*256];
    self.blueBackgroundValueLabel.text = [NSString stringWithFormat:@"B: %.0f", self.colorWithBlueFloat*256];
}

- (IBAction)refreshViewButtonTapped:(id)sender
{
    [self setDefaultBackground];
}

- (IBAction)makeBackgroundMoreRedButtonTapped:(UIButton *)sender
{
    self.lessRedButton.enabled = YES;
    
    self.redInteger += self.incrementValue;
    
    if (self.redInteger >= 256)
    {
        self.redInteger = 256;
        sender.enabled = NO;
    }
    self.colorWithRedFloat = self.redInteger/256.0;
    
    [self postButtonActions];
}

- (IBAction)makeBackgroundLessRedButtonTapped:(UIButton *)sender
{
    self.moreRedButton.enabled = YES;
    
    self.redInteger -= self.incrementValue;
    
    if (self.redInteger <= 0)
    {
        self.redInteger = 0;
        sender.enabled = NO;
    }
    self.colorWithRedFloat = self.redInteger/256.0;
    
    [self postButtonActions];
}

- (IBAction)makeBackgroundMoreGreenButtonTapped:(UIButton *)sender
{
    self.lessGreenButton.enabled = YES;
    
    self.greenInteger += self.incrementValue;
    
    if (self.greenInteger >= 256)
    {
        self.greenInteger = 256;
        sender.enabled = NO;
    }
    self.colorWithGreenFloat = self.greenInteger/256.0;
    
    [self postButtonActions];
}

- (IBAction)makeBackgroundLessGreenButtonTapped:(UIButton *)sender
{
    self.moreGreenButton.enabled = YES;
    
    self.greenInteger -= self.incrementValue;
    
    if (self.greenInteger <= 0)
    {
        self.greenInteger = 0;
        sender.enabled = NO;
    }
    self.colorWithGreenFloat = self.greenInteger/256.0;
    
    [self postButtonActions];
}

- (IBAction)makeBackgroundMoreBlueButtonTapped:(UIButton *)sender
{
    self.lessBlueButton.enabled = YES;
    
    self.blueInteger += self.incrementValue;
    
    if (self.blueInteger >= 256)
    {
        self.blueInteger = 256;
        sender.enabled = NO;
    }
    self.colorWithBlueFloat = self.blueInteger/256.0;
    
    [self postButtonActions];
}

- (IBAction)makeBackgroundLessBlueButtonTapped:(UIButton *)sender
{
    self.moreBlueButton.enabled = YES;
    
    self.blueInteger -= self.incrementValue;
    
    if (self.blueInteger <= 0)
    {
        self.blueInteger = 0;
        sender.enabled = NO;
    }
    self.colorWithBlueFloat = self.blueInteger/256.0;
    
    [self postButtonActions];
}

- (IBAction)hideFeatureButtonTapped:(id)sender
{
    if ([self.hideFeatureButton.titleLabel.text isEqualToString:@"⚪️"])
    {
        self.refreshViewButton.hidden = YES;
        
        [self.hideFeatureButton setTitle:@"🔘" forState:UIControlStateNormal];
    }
    else if ([self.hideFeatureButton.titleLabel.text isEqualToString:@"🔘"])
    {
        self.redBackgroundValueLabel.hidden = YES;
        self.greenBackgroundValueLabel.hidden = YES;
        self.blueBackgroundValueLabel.hidden = YES;
        
        [self.hideFeatureButton setTitle:@"⚫️" forState:UIControlStateNormal];
    }
    else
    {
        self.refreshViewButton.hidden = NO;
        self.redBackgroundValueLabel.hidden = NO;
        self.greenBackgroundValueLabel.hidden = NO;
        self.blueBackgroundValueLabel.hidden = NO;
        
        [self.hideFeatureButton setTitle:@"⚪️" forState:UIControlStateNormal];
    }
}

- (void)postButtonActions
{
    [self changeBackgroundColor];
}

- (IBAction)incrementSegmentedControlValueChanged:(UISegmentedControl *)sender
{
    if (sender.selectedSegmentIndex == 0)
    {
        self.multiplier = 4/256.0;
    }
    else if (sender.selectedSegmentIndex == 1)
    {
        self.multiplier = 16/256.0;
    }
    else if (sender.selectedSegmentIndex == 2)
    {
        self.multiplier = 32/256.0;
    }
    else
    {
        self.multiplier = 64/256.0;
    }
    self.incrementValue = self.multiplier * 256;
}

/*
 Use Masonry to constrain this view properly to the parent...
 turn increments into base-64
 hook up segmentedControl
 adopt new Hide Feature system
 solidify autolayout once and for all
 refactor where possible
 fix button width to preserve gradient integrity
 make hide feature button the ? or !
 */

@end
