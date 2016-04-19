//
//  AMYColorGameViewController.m
//  RandomFeaturesSequel
//
//  Created by Amy Joscelyn on 12/2/15.
//  Copyright © 2015 Amy Joscelyn. All rights reserved.
//

#import "AMYColorGameViewController.h"
#import "AMYSharedDataStore.h"
#import "AMYColorSetup.h"
#import <tgmath.h>

@interface AMYColorGameViewController ()

//make constants for border width (for both tapping buttons and game labels/buttons), corner radius (tapping buttons, goal circle), multipliers (4, 16, 32, 64, either out of 256.0 or not), store modes (0, 1, 2, 3), for 256 (the max amount of value RGorB can have), for 0 and 64 and 192 (when something is too dark or light enough or not involved in this current color target), for the .000001 difference or whatever in absolute value.  There are others, of course.  There are a lot of magic numbers in here... but a handful or two of constants should clear those right up!

@property (weak, nonatomic) IBOutlet UIView *colorGoalView;
@property (weak, nonatomic) IBOutlet UILabel *gameLabel;
@property (weak, nonatomic) IBOutlet UIButton *refreshGameButton;

@property (weak, nonatomic) IBOutlet UILabel *redGoalValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *greenGoalValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *blueGoalValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *redBackgroundValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *greenBackgroundValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *blueBackgroundValueLabel;

@property (weak, nonatomic) IBOutlet UIButton *lessRedButton;
@property (weak, nonatomic) IBOutlet UIButton *moreRedButton;
@property (weak, nonatomic) IBOutlet UIButton *lessGreenButton;
@property (weak, nonatomic) IBOutlet UIButton *moreGreenButton;
@property (weak, nonatomic) IBOutlet UIButton *lessBlueButton;
@property (weak, nonatomic) IBOutlet UIButton *moreBlueButton;

@property (weak, nonatomic) IBOutlet UISegmentedControl *basicIncrementSegmentedControl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *moderateIncrementSegmentedControl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *challengingIncrementSegmentedControl;

@property (weak, nonatomic) IBOutlet UILabel *playerScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *targetScoreLabel;
@property (weak, nonatomic) IBOutlet UIButton *hideFeatureButton;
@property (weak, nonatomic) IBOutlet UIButton *dismissModalButton;

@property (nonatomic) CGFloat colorWithRedFloat;
@property (nonatomic) CGFloat colorWithGreenFloat;
@property (nonatomic) CGFloat colorWithBlueFloat;

@property (nonatomic) NSInteger redInteger;
@property (nonatomic) NSInteger greenInteger;
@property (nonatomic) NSInteger blueInteger;

@property (nonatomic) CGFloat multiplier;
@property (nonatomic) NSInteger incrementValue;
@property (nonatomic) UISegmentedControl *currentSegmentedControl;

@property (nonatomic) NSUInteger totalButtonTaps;
@property (nonatomic, strong) UIColor *currentColor;
@property (nonatomic) NSUInteger hintButtonTaps;

@property (nonatomic, strong) AMYSharedDataStore *store;

@end

@implementation AMYColorGameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.store = [AMYSharedDataStore sharedDataStore];
    
    self.currentColor = [UIColor whiteColor];
    
    [self setUpMultiplier];
    [self chooseGoalColor];
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
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
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

- (void)setUpMultiplier
{
    if (self.store.mode == 0)
    {
        self.multiplier = 64/256.0;
    }
    else if (self.store.mode == 1)
    {
        self.multiplier = 32/256.0;
    }
    else if (self.store.mode == 2)
    {
        self.multiplier = 16/256.0;
    }
    else
    {
        self.multiplier = 4/256.0;
    }
    self.incrementValue = self.multiplier * 256;
    
    [self setCurrentIncrementSegmentedControl];
}

- (void)setCurrentIncrementSegmentedControl
{
    //maybe this should be reworked so that mode 0 should be the else?
    if (self.store.mode == 0)
    {
        self.basicIncrementSegmentedControl.hidden = YES;
        self.moderateIncrementSegmentedControl.hidden = YES;
        self.challengingIncrementSegmentedControl.hidden = YES;
    }
    else if (self.store.mode == 1)
    {
        self.basicIncrementSegmentedControl.hidden = NO;
        self.moderateIncrementSegmentedControl.hidden = YES;
        self.challengingIncrementSegmentedControl.hidden = YES;
        
        self.currentSegmentedControl = self.basicIncrementSegmentedControl;
    }
    else if (self.store.mode == 2)
    {
        self.basicIncrementSegmentedControl.hidden = YES;
        self.moderateIncrementSegmentedControl.hidden = NO;
        self.challengingIncrementSegmentedControl.hidden = YES;
        
        self.currentSegmentedControl = self.moderateIncrementSegmentedControl;
    }
    else if (self.store.mode == 3)
    {
        self.basicIncrementSegmentedControl.hidden = YES;
        self.moderateIncrementSegmentedControl.hidden = YES;
        self.challengingIncrementSegmentedControl.hidden = NO;
        
        self.currentSegmentedControl = self.challengingIncrementSegmentedControl;
    }
    else
    {
        NSLog(@"Somehow you've gotten off the rails. Pick an existing difficulty.");
    }
    self.currentSegmentedControl.selectedSegmentIndex = 0;
}

- (void)chooseGoalColor
{
    AMYColorSetup *setup = [[AMYColorSetup alloc] init];
    
    UIColor *colorChosen = [setup setColorWithMode:self.store.mode difficulty:self.store.difficulty currentColor:self.currentColor];
    
    [self setUpGameWithGoalColor:colorChosen];
}

- (void)setUpGameWithGoalColor:(UIColor *)color
{
    //-------------------------------------------
    //setting the color and breaking it down into components
    //this belongs right here
    self.colorGoalView.backgroundColor = color;
    self.currentColor = color;
    
    CGFloat red, green, blue, alpha;
    [color    getRed: &red
               green: &green
                blue: &blue
               alpha: &alpha ];
    
    self.redGoalValueLabel.text = [NSString stringWithFormat:@"R: %.0f", red*256];
    self.greenGoalValueLabel.text = [NSString stringWithFormat:@"G: %.0f", green*256];
    self.blueGoalValueLabel.text = [NSString stringWithFormat:@"B: %.0f", blue*256];
    //-------------------------------------------
    
    //this handles the minimum score for goal color
    NSUInteger targetScore = [self calculateTargetScoreWithRed:red green:green blue:blue];
    self.targetScoreLabel.text = [NSString stringWithFormat:@"Target Score: %lu", (unsigned long)targetScore];
    
    //this determines the textColor
    UIColor *textColor = [self textColorBasedOnGoalColorRed:red green:green];
    
    //this is all about the refreshGameButton, hidden in the goal color circle
    //it uses textColor
    //maybe the portions that do not need textColor can be in setUpView?
    [self.refreshGameButton setTitleColor:textColor forState:UIControlStateNormal];
    self.refreshGameButton.layer.borderColor = textColor.CGColor;
    self.refreshGameButton.layer.borderWidth = 2.0f;
    self.refreshGameButton.hidden = YES;
    
    //this sets the segmented control with the textColor
    //uses textColor
    self.currentSegmentedControl.tintColor = textColor;
    
    //'''''''''''''''''''''''''''''''''''''''''''''''''
    //this is all for the backButton
    //top part uses nothing, maybe good for setUpView?
    //middle uses red, green, and blue, returns local BOOL
    //bottom uses textColor and color
    
    BOOL inverse;
    
    if (red == 0 && green == 0 && blue <= 192/256.0)
    {
        inverse = YES;
    }
    else if (red + green <= 64/256.0 && blue <= 192/256.0)
    {
        inverse = YES;
    }
    else if (red <= 64/256.0 && green <= 64/256.0 && blue == 0)
    {
        inverse = YES;
    }
    else
    {
        inverse = NO;
    }
    
    if (inverse)
    {
        self.dismissModalButton.backgroundColor = textColor;
        self.dismissModalButton.layer.borderColor = color.CGColor;
    }
    else
    {
        self.dismissModalButton.backgroundColor = color;
        self.dismissModalButton.layer.borderColor = textColor.CGColor;
    }
    //''''''''''''''''''''''''''''''''''''''''''''''''
    
    [self setUpView];
}

- (UIColor *)textColorBasedOnGoalColorRed:(CGFloat)red green:(CGFloat)green
{
    if (red > 180/256.0 && green > 180/256.0)
    {
        return [UIColor colorWithRed:0.35 green:0.35 blue:0.35 alpha:1.0];
    }
    else
    {
        return [UIColor whiteColor];
    }
}

- (void)setLabelsWithTextColor:(UIColor *)color
{
    NSArray *colorValueLabels = @[ self.redGoalValueLabel,
                                   self.greenGoalValueLabel,
                                   self.blueGoalValueLabel,
                                   self.redBackgroundValueLabel,
                                   self.greenBackgroundValueLabel,
                                   self.blueBackgroundValueLabel];
    
    NSArray *gameLabels = @[ self.gameLabel,
                             self.playerScoreLabel,
                             self.targetScoreLabel ];
    
    [self setLabelPropertiesWithArray:colorValueLabels color:color];
    [self setLabelPropertiesWithArray:gameLabels color:color];
}

- (void)setLabelPropertiesWithArray:(NSArray *)labels color:(UIColor *)color
{
    for (UILabel *label in labels)
    {
        label.textColor = color;
        label.layer.shadowColor = color.CGColor;
        label.layer.shadowRadius = 4.0f;
        label.layer.shadowOpacity = .9;
        label.layer.shadowOffset = CGSizeZero;
        label.layer.masksToBounds = NO;
    }
}

- (NSUInteger)calculateTargetScoreWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue
{
    NSUInteger targetScore;
    
    if (self.store.mode == 0)
    {
        targetScore = (red + green + blue) * (1/self.multiplier);
    }
    else
    {
        NSInteger redScore = 0;
        NSInteger greenScore = 0;
        NSInteger blueScore = 0;
        
        if (red != 0) //if red is a color at all, then we need to figure out the score
        {
            redScore = [self calculateScoreOfMinimumTapsForColor:red];
        }
        
        if (green != 0)
        {
            greenScore = [self calculateScoreOfMinimumTapsForColor:green];
        }
        
        if (blue != 0)
        {
            blueScore = [self calculateScoreOfMinimumTapsForColor:blue];
        }
        
        targetScore = redScore + greenScore + blueScore;
        
        //it needs to be made clear that score is the minimum amount of taps needed
    }
    return targetScore;
}

- (NSInteger)calculateScoreOfMinimumTapsForColor:(CGFloat)redGreenOrBlue
{
    CGFloat color = redGreenOrBlue * 256;
    
    NSUInteger sixtyFour = 64;
    NSUInteger thirtyTwo = 32;
    NSUInteger sixteen = 16;
    NSUInteger four = 4;
    
    NSInteger resultOne = 0;
    NSInteger resultTwo = 0;
    NSInteger resultThree = 0;
    NSInteger resultFour = 0;
    
    NSInteger moduloOne;
    NSInteger moduloTwo;
    NSInteger moduloThree;
    
    resultOne = color / sixtyFour;
    moduloOne = fmodf(color, sixtyFour);
    
    if (!(moduloOne == 0))
    {
        resultTwo = moduloOne / thirtyTwo;
        moduloTwo = fmodf(moduloOne, thirtyTwo);
        
        if (!(moduloTwo == 0))
        {
            resultThree = moduloTwo / sixteen;
            moduloThree = fmodf(moduloTwo, sixteen);
            
            if (!(moduloThree == 0))
            {
                resultFour = moduloThree / four;
            }
        }
    }
    return resultOne + resultTwo + resultThree + resultFour;
}

- (void)setUpView
{
    //this is about the goal circle
    self.colorGoalView.layer.cornerRadius = self.colorGoalView.frame.size.height/2;
    self.colorGoalView.clipsToBounds = YES;
    
    self.dismissModalButton.layer.cornerRadius = 5;
    self.dismissModalButton.layer.borderWidth = 2.0f;
    
    [self resetGameProperties];
    
    self.playerScoreLabel.text = [NSString stringWithFormat:@"Your Score: %lu", (unsigned long)self.totalButtonTaps];
    self.gameLabel.text = @"Match the color!";
    self.view.backgroundColor = [UIColor blackColor];
    
    //color adjusting buttons enabled
    self.lessRedButton.enabled = YES;
    self.moreRedButton.enabled = YES;
    self.lessGreenButton.enabled = YES;
    self.moreGreenButton.enabled = YES;
    self.lessBlueButton.enabled = YES;
    self.moreBlueButton.enabled = YES;
}

- (IBAction)incrementSegmentedControlValueChanged:(UISegmentedControl *)sender
{
    if (sender == self.basicIncrementSegmentedControl)
    {
        if (sender.selectedSegmentIndex == 0)
        {
            self.multiplier = 32/256.0;
        }
        else
        {
            self.multiplier = 64/256.0;
        }
    }
    else if (sender == self.moderateIncrementSegmentedControl)
    {
        if (sender.selectedSegmentIndex == 0)
        {
            self.multiplier = 16/256.0;
        }
        else if (sender.selectedSegmentIndex == 1)
        {
            self.multiplier = 32/256.0;
        }
        else
        {
            self.multiplier = 64/256.0;
        }
    }
    else if (sender == self.challengingIncrementSegmentedControl)
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
    }
    else
    {
        NSLog(@"We have a segment out of control here!");
    }
    
    self.incrementValue = self.multiplier * 256;
}

- (void)changeBackgroundColor
{
    self.view.backgroundColor = [UIColor colorWithRed:self.colorWithRedFloat green:self.colorWithGreenFloat blue:self.colorWithBlueFloat alpha:1.0];
    
    self.redBackgroundValueLabel.text = [NSString stringWithFormat:@"R: %.0f", self.colorWithRedFloat*256];
    self.greenBackgroundValueLabel.text = [NSString stringWithFormat:@"G: %.0f", self.colorWithGreenFloat*256];
    self.blueBackgroundValueLabel.text = [NSString stringWithFormat:@"B: %.0f", self.colorWithBlueFloat*256];
    
    self.playerScoreLabel.text = [NSString stringWithFormat:@"Your Score: %lu", (unsigned long)self.totalButtonTaps];
}

- (void)resetGameProperties
{
    self.colorWithRedFloat = 0.0;
    self.colorWithGreenFloat = 0.0;
    self.colorWithBlueFloat = 0.0;
    
    self.redInteger = 0;
    self.greenInteger = 0;
    self.blueInteger = 0;
    
    //backgroundVLs set
    self.redBackgroundValueLabel.text = [NSString stringWithFormat:@"R: 0"];
    self.greenBackgroundValueLabel.text = [NSString stringWithFormat:@"G: 0"];
    self.blueBackgroundValueLabel.text = [NSString stringWithFormat:@"B: 0"];
    
    self.totalButtonTaps = 0;
    
    [self.hideFeatureButton setTitle:@"❔" forState:UIControlStateNormal];
    
    [self hideValueLabels];
}

- (void)hideValueLabels
{
    self.redGoalValueLabel.hidden = YES;
    self.greenGoalValueLabel.hidden = YES;
    self.blueGoalValueLabel.hidden = YES;
    self.redBackgroundValueLabel.hidden = YES;
    self.greenBackgroundValueLabel.hidden = YES;
    self.blueBackgroundValueLabel.hidden = YES;
    
    self.hintButtonTaps = 0;
}

- (IBAction)makeBackgroundMoreRedButtonTapped:(UIButton *)sender
{
    self.lessRedButton.enabled = YES;
    
    self.redInteger += self.incrementValue;
    self.colorWithRedFloat = self.redInteger/256.0;
    
    if (self.redInteger >= 256)
    {
        self.redInteger = 256;
        sender.enabled = NO;
    }
    [self postButtonActions];
}

- (IBAction)makeBackgroundLessRedButtonTapped:(UIButton *)sender
{
    self.moreRedButton.enabled = YES;
    
    self.redInteger -= self.incrementValue;
    self.colorWithRedFloat = self.redInteger/256.0;
    
    if (self.redInteger <= 0)
    {
        self.redInteger = 0;
        sender.enabled = NO;
    }
    [self postButtonActions];
}

- (IBAction)makeBackgroundMoreGreenButtonTapped:(UIButton *)sender
{
    self.lessGreenButton.enabled = YES;
    
    self.greenInteger += self.incrementValue;
    self.colorWithGreenFloat = self.greenInteger/256.0;
    
    if (self.greenInteger >= 256)
    {
        self.greenInteger = 256;
        sender.enabled = NO;
    }
    [self postButtonActions];
}

- (IBAction)makeBackgroundLessGreenButtonTapped:(UIButton *)sender
{
    self.moreGreenButton.enabled = YES;
    
    self.greenInteger -= self.incrementValue;
    self.colorWithGreenFloat = self.greenInteger/256.0;
    
    if (self.greenInteger <= 0)
    {
        self.greenInteger = 0;
        sender.enabled = NO;
    }
    [self postButtonActions];
}

- (IBAction)makeBackgroundMoreBlueButtonTapped:(UIButton *)sender
{
    self.lessBlueButton.enabled = YES;
    
    self.blueInteger += self.incrementValue;
    self.colorWithBlueFloat = self.blueInteger/256.0;
    
    if (self.blueInteger >= 256)
    {
        self.blueInteger = 256;
        sender.enabled = NO;
    }
    [self postButtonActions];
}

- (IBAction)makeBackgroundLessBlueButtonTapped:(UIButton *)sender
{
    self.moreBlueButton.enabled = YES;
    
    self.blueInteger -= self.incrementValue;
    self.colorWithBlueFloat = self.blueInteger/256.0;
    
    if (self.blueInteger <= 0)
    {
        self.blueInteger = 0;
        sender.enabled = NO;
    }
    [self postButtonActions];
}

- (void)postButtonActions
{
    self.totalButtonTaps++;
    [self changeBackgroundColor];
    [self hasWon:([self winningConditions])];
}

- (BOOL)winningConditions
{
    CGFloat red1, green1, blue1, alpha1;
    
    [self.view.backgroundColor getRed: &red1
                                green: &green1
                                 blue: &blue1
                                alpha: &alpha1];
    
    CGFloat red2, green2, blue2, alpha2;
    
    [self.colorGoalView.backgroundColor getRed: &red2
                                         green: &green2
                                          blue: &blue2
                                         alpha: &alpha2];
    
    CGFloat a = red1 - red2;
    CGFloat aDifference = fabs(a) - 0;
    BOOL aOK = aDifference < 0.000001;
    
    CGFloat b = green1 - green2;
    CGFloat bDifference = fabs(b) - 0;
    BOOL bOK = bDifference < 0.000001;
    
    CGFloat c = blue1 - blue2;
    CGFloat cDifference = fabs(c) - 0;
    BOOL cOK = cDifference < 0.000001;
    
    CGFloat d = alpha1 - alpha2;
    CGFloat dDifference = fabs(d) - 0;
    BOOL dOK = dDifference < 0.000001;
    
    if (aOK && bOK && cOK && dOK)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

- (void)hasWon:(BOOL)boolean
{
    if (boolean)
    {
        self.gameLabel.text = @"Winner!";
        self.refreshGameButton.hidden = NO;
        
        self.lessRedButton.enabled = NO;
        self.moreRedButton.enabled = NO;
        self.lessGreenButton.enabled = NO;
        self.moreGreenButton.enabled = NO;
        self.lessBlueButton.enabled = NO;
        self.moreBlueButton.enabled = NO;
    }
}

- (IBAction)refreshGameButtonTapped:(id)sender
{
//    self.firstColor = NO;
    [self chooseGoalColor];
}

- (IBAction)hideFeatureButtonTapped:(id)sender
{
    if (self.hintButtonTaps == 0)
    {
        self.redGoalValueLabel.hidden = NO;
        self.greenGoalValueLabel.hidden = NO;
        self.blueGoalValueLabel.hidden = NO;
        
        self.hintButtonTaps++;
    }
    else if (self.hintButtonTaps == 1)
    {
        self.redBackgroundValueLabel.hidden = NO;
        self.greenBackgroundValueLabel.hidden = NO;
        self.blueBackgroundValueLabel.hidden = NO;
        
        self.hintButtonTaps++;
    }
    else
    {
        [self hideValueLabels];
    }
    
    //    if ([self.hideFeatureButton.titleLabel.text isEqualToString:@"⚪️"])
    //    {
    //        self.redBackgroundValueLabel.hidden = YES;
    //        self.greenBackgroundValueLabel.hidden = YES;
    //        self.blueBackgroundValueLabel.hidden = YES;
    //
    //        [self.hideFeatureButton setTitle:@"🔘" forState:UIControlStateNormal];
    //    }
    //    else if ([self.hideFeatureButton.titleLabel.text isEqualToString:@"🔘"])
    //    {
    //        self.redGoalValueLabel.hidden = YES;
    //        self.greenGoalValueLabel.hidden = YES;
    //        self.blueGoalValueLabel.hidden = YES;
    //
    //        [self.hideFeatureButton setTitle:@"⚫️" forState:UIControlStateNormal];
    //    }
    //    else
    //    {
    //        self.redBackgroundValueLabel.hidden = NO;
    //        self.greenBackgroundValueLabel.hidden = NO;
    //        self.blueBackgroundValueLabel.hidden = NO;
    //
    //        self.redGoalValueLabel.hidden = NO;
    //        self.greenGoalValueLabel.hidden = NO;
    //        self.blueGoalValueLabel.hidden = NO;
    //
    //        [self.hideFeatureButton setTitle:@"⚪️" forState:UIControlStateNormal];
    //    }
}

- (IBAction)dismissModalButtonTapped:(id)sender
{
    [self.delegate AMYColorGameViewControllerDidCancel:self];
}

/*
 more advanced stuff/issues:
 check out how it looks on other devices
 set up options for difficulty and hiding fields.  an options screen?
 randomize starter color--that can be another option (instead of default black background), maybe for a crRaaAAazY level!
 Make cool background for difficulty selection screen
 Make everything look nice
 maybe the color buttons can change text based on mode.  text can say, "Red +/- incrementValue", eg "Red +.25" or "Blue -.05".  This means I can include a slider somewhere on there to control the increment value, and the increment can show up on the button text.  This can be a change in Basic mode, as compared to Simple.  By Moderate, there should be the ability to change it from 0.1 to 0.25, and in Complex they can change it from 0.05 to 0.1 to 0.25.
 
 set this project up with multiple classes so it's not all on the VC--IS THIS POSSIBLE?
 */

/*
 things to hide:
 current background values
 goal color values
 target score (for those who want to see for themselves how low the number can go)
 your score
 "clean look"--all unnecessary labels, all text (buttons should say nothing on them, just "")
 
 options:
 hide things
 change difficulty
 start "light"--with white instead of black
 whether to show the color value labels automatically upon matching the color or not
 */

/*
 Future stuff to work on (2.0?):
 
 Make the menu screens into one menu: one column for complexity, one for difficulty.
 I can still have them change colors, but it can be in a different way--maybe everytime the menu is returned to the button gradients change?
 
 Change the way the hint/reveal values work.
 ❔❓❕❗️   ‼️⁉️
 It should be a grayed out question mark at the beginning.
 If their total taps exceeds the minimum taps by like 5 or so, the gray ? should become the red one, to hint to them that they can get some help.
 They can tap it once, to see the target color values.  The question mark can go gray again for some time... but if it takes them like ten more taps the question mark can go red again and show them this time the background color values as well.  It goes gray again and should show an ! instead.
 When the ! is tapped, it should hide everything again.
 This should reset with each new color.
 The ? is always tappable and will always reveal what it's supposed to reveal.  Turning red only reminds them that they can get help before they get frustrated.
 
 The amount of taps should differ base on difficulty.  The more difficult and complex, the more taps I should let them try out before I remind them of the ? because they might not always be using the most efficient increment value.  Gotta keep that in mind!
 
 For the very future, the red ? can flash in an animated way to get their attention.
 I might have to put the ? on a colored background in order to ensure it's always visible against the phone's background.
 
 
 A settings menu should pop out, where they can toggle whether the score should show, whether the hints (color values) should be revealed in an inverse manner--always show unless the ? button is tapped.  It should also determine whether the colors are inverse all the way--that you start with a white screen and you need to take away color from the background in order to match the color.  This inverse of theme color should also turn the menu screens black.
 
 Maybe the levels should be based on merit--all of the complexities are locked except for the easiest one.  Inside that complexity, all of the difficulties are locked except for the first one.  It should go through the basics with you, and once you've done like six colors, then it should congratulate you and say you've opened up the next difficulty.  This lends more forward progression to the game, plus it can tell you whether you're any good at this game.
 I would need persistence for this.  I would also need checks to make sure the person really is improving--maybe they need to match at least 10 colors, 7 of which must be accomplished without using the hint button at all.  Or maybe you just need to go through 10 colors without the hint button.
 Maybe the amount you need to match is based on how many color options there are--half the total amount of options without using the hint button might be a good way of determining your "mastery", as it is, of that difficulty.  Then you go on to the next one, or if you've finished the Master, you are told you've opened up the next complexity.  Of course, you're able to play as much as you like of the current level until you Go Back and select the next hardest level to play.
 How does that sound?  Totally do-able, but would it be appropriate for a game like this?  When the colors get reeaaally difficulty, it might be virtually impossible to get to the hardest levels.
 Score should have nothing to do with progression.  It's whether you can do it on your own, not how fast you can do it.
 If I do decide to keep track of score, the only ones that should "count" are the ones that were achieved without any hints.
 
 I guess it's possible to change the amount of segments in segmentedControls.  So instead of having three separate ones that I reveal and hide, I can just change the number of segments and set them appropriately based on the mode.
 */

@end
