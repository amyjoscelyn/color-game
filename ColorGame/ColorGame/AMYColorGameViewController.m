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
@property (nonatomic) BOOL firstColor;

@property (nonatomic) NSUInteger totalButtonTaps;
@property (nonatomic, strong) UIColor *currentColor;

@property (nonatomic, strong) AMYSharedDataStore *store;

@end

@implementation AMYColorGameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.store = [AMYSharedDataStore sharedDataStore];
    
    //set up mode
    if (self.store.mode == 0) //simple
    {
        self.multiplier = 64/256.0;
    }
    else if (self.store.mode == 1) //basic
    {
        self.multiplier = 32/256.0;
    }
    else if (self.store.mode == 2) //moderate
    {
        self.multiplier = 16/256.0;
    }
    else                            //challenging
    {
        self.multiplier = 4/256.0;
    }
    self.incrementValue = self.multiplier * 256;
    
    self.currentColor = [UIColor whiteColor];
    self.firstColor = YES;
//    NSLog(@"(VIEW DID LOAD) firstColor? %d", self.firstColor);
    
    [self chooseGoalColor];
    
    self.colorGoalView.layer.cornerRadius = self.colorGoalView.frame.size.height/2;
    self.colorGoalView.clipsToBounds = YES;
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

- (void)chooseGoalColor
{
    AMYColorSetup *setup = [[AMYColorSetup alloc] init];
    
    UIColor *colorChosen = [setup setColorWithMode:self.store.mode difficulty:self.store.difficulty currentColor:self.currentColor];

    [self setUpGameWithGoalColor:colorChosen];
}

- (void)setUpGameWithGoalColor:(UIColor *)color
{
    self.colorGoalView.backgroundColor = color;
    self.currentColor = color;
//    self.gameLabel.backgroundColor = color;
//    self.playerScoreLabel.backgroundColor = color;
//    self.targetScoreLabel.backgroundColor = color;
    
    NSArray *colorValueLabels = @[ self.redGoalValueLabel,
                                   self.greenGoalValueLabel,
                                   self.blueGoalValueLabel,
                                   self.redBackgroundValueLabel,
                                   self.greenBackgroundValueLabel,
                                   self.blueBackgroundValueLabel];
    CGFloat red, green, blue, alpha;
    [color    getRed: &red
               green: &green
                blue: &blue
               alpha: &alpha ];
    
    self.redGoalValueLabel.text = [NSString stringWithFormat:@"R: %.0f", red*256];
    self.greenGoalValueLabel.text = [NSString stringWithFormat:@"G: %.0f", green*256];
    self.blueGoalValueLabel.text = [NSString stringWithFormat:@"B: %.0f", blue*256];
    
    NSUInteger targetScore;
    
    if (self.store.mode == 0)
    {
        targetScore = (red + green + blue) * (1/self.multiplier);
    }
    else
    {
        //maybe i can set up different NSUInt objects for 64/256.0 and each other, so i don't have to have those ugly ##s and it will be tab-completed for me
//        NSUInteger sixtyFour = 64/256.0;
//        NSUInteger thirtyTwo = 32/356.0;
//        NSUInteger sixteen = 16/256.0;
//        NSUInteger four = 4/256.0;
        
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
    
    // once there are options of switching between multiple increments, the score gets a lot harder to calculate
    // I would hate to have to figure them out for every single color, optimized, and plug them in based on that color :(
    // unless I can make an algorithm based on comparable division:
    /*
     if (value > .25)
     {  divide it by .25
        collect the remainder
     }
     if (remainder > .1)
        divide by .1, collect r
     and so on, adding the dividens together to get the score
     }
     */
    self.targetScoreLabel.text = [NSString stringWithFormat:@"Target Score: %lu", (unsigned long)targetScore];
    
    UIColor *textColor = [UIColor whiteColor];
    
    if (red > 180/256.0 && green > 180/256.0)
    {
        textColor = [UIColor colorWithRed:0.35 green:0.35 blue:0.35 alpha:1.0];
    }
    
    for (UILabel *colorValueLabel in colorValueLabels)
    {
//        colorValueLabel.backgroundColor = color;
//        [colorValueLabel setTextColor:textColor];
        colorValueLabel.textColor = textColor;
        colorValueLabel.layer.shadowColor = textColor.CGColor;
        colorValueLabel.layer.shadowRadius = 4.0f;
        colorValueLabel.layer.shadowOpacity = .9;
        colorValueLabel.layer.shadowOffset = CGSizeZero;
        colorValueLabel.layer.masksToBounds = NO;
    }
    [self.refreshGameButton setTitleColor:textColor forState:UIControlStateNormal];
    self.refreshGameButton.layer.borderWidth = 2.0f;
    self.refreshGameButton.layer.borderColor = textColor.CGColor;
    self.refreshGameButton.hidden = YES;
    
    [self setUpView];
    
    self.currentSegmentedControl.tintColor = textColor;
    
    NSArray *gameLabels = @[ self.gameLabel, self.playerScoreLabel, self.targetScoreLabel ];
    
    for (UILabel *label in gameLabels)
    {
        label.textColor = textColor;
        label.layer.shadowColor = textColor.CGColor;
        label.layer.shadowRadius = 4.0f;
        label.layer.shadowOpacity = .9;
        label.layer.shadowOffset = CGSizeZero;
        label.layer.masksToBounds = NO;
    }
    
//    self.gameLabel.textColor = textColor;
//    self.playerScoreLabel.textColor = textColor;
//    self.targetScoreLabel.textColor = textColor;
    
    self.dismissModalButton.layer.cornerRadius = 5;
    self.dismissModalButton.layer.borderWidth = 2.0f;
    //maybe if the color is too dark, i can set the background as the textColor and the border as the color instead; inverse what's above
    
    BOOL inverse;
    
//    if (red + green + blue <= 64/256.0) //1
//    { //this one might be covered by 2 and 4
//        inverse = YES;
//    }
    if (red == 0 && green == 0 && blue <= 192/256.0) //2
    {
        inverse = YES;
    }
    else if (red + green <= 64/256.0 && blue <= 192/256.0) //3
    {
        inverse = YES;
    }
    else if (red <= 64/256.0 && green <= 64/256.0 && blue == 0) //4
    {
        inverse = YES;
    }
    else
    {
        inverse = NO;
    }
    
    /*
     if red, green, or blue are by themselves and below 64, make inverse
     if blue is by itself and less than 192, inverse
     if blue is with green or red (which are less than 64), and blue is 192 or less, inverse
     if red and green are together and 64 or less, inverse
     the rest are normal
     */
    
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
    /* NORMAL
     self.dismissModalButton.backgroundColor = color;
     self.dismissModalButton.layer.borderColor = textColor.CGColor;
     */
    
    /* INVERSE
     self.dismissModalButton.backgroundColor = textColor;
     self.dismissModalButton.layer.borderColor = color.CGColor;
     */
    
    /*
     too dark when:
     R/B are 64
     R is 64, B is 192
     B is 192, 128, 64
     G is 64
     
     borderline when:
     G is 64, B is 192
     R/G are 64
     R is 128
     
     ok when:
     G is 64, B is 256
     R is 256, B is 64
     G is 128, B is 64
     R is 192, B is 64
     R is 192, B is 192
     G is 128
     R is 128, B is 128
     G is 128, B is 128
     R is 128, G is 128
     */
    
    self.totalButtonTaps = 0;
    self.playerScoreLabel.text = [NSString stringWithFormat:@"Your Score: %lu", (unsigned long)self.totalButtonTaps];
    self.gameLabel.text = @"Match the color!";
    
    self.view.backgroundColor = [UIColor blackColor];
}

- (NSInteger)calculateScoreOfMinimumTapsForColor:(CGFloat)redGreenOrBlue
{
    CGFloat color = redGreenOrBlue * 256;
//    NSLog(@"color: %.2f", color);
//    NSUInteger sixtyFour = 64/256.0;
//    NSUInteger thirtyTwo = 32/356.0;
//    NSUInteger sixteen = 16/256.0;
//    NSUInteger four = 4/256.0;
    NSUInteger sixtyFour = 64;
    NSUInteger thirtyTwo = 32;
    NSUInteger sixteen = 16;
    NSUInteger four = 4;
    
    NSInteger remainderOne = 0;
    NSInteger remainderTwo = 0;
    NSInteger remainderThree = 0;
    NSInteger remainderFour = 0;
    
    NSInteger moduloOne;
    NSInteger moduloTwo;
    NSInteger moduloThree;
//    NSInteger moduloFour;
//    NSInteger modulo;
    //start with 64
    remainderOne = color / sixtyFour;
    moduloOne = fmodf(color, sixtyFour);
//    NSLog(@"remainderOne: %li, modulo: %li", remainderOne, moduloOne);
    if (!(moduloOne == 0))
    {
        //now 32
        remainderTwo = moduloOne / thirtyTwo;
        moduloTwo = fmodf(moduloOne, thirtyTwo);
//        NSLog(@"remainderTwo: %li, modulo: %li", remainderTwo, moduloTwo);
        if (!(moduloTwo == 0))
        {
            //now 16
            remainderThree = moduloTwo / sixteen;
            moduloThree = fmodf(moduloTwo, sixteen);
//            NSLog(@"remainderThree: %li, modulo: %li", remainderThree, moduloThree);
            if (!(moduloThree == 0))
            {
                //now 4
                remainderFour = moduloThree / four;
//                modulo = fmodf(color, four); //don't need modulo for smallest multiplier value
//                NSLog(@"remainderFour: %li", remainderFour);
            }
        }
    }
//    NSLog(@"total score: %li", remainderOne + remainderThree + remainderTwo + remainderFour);
    return remainderOne + remainderTwo + remainderThree + remainderFour;
}

- (void)setUpView
{
    self.colorWithRedFloat = 0.0;
    self.colorWithGreenFloat = 0.0;
    self.colorWithBlueFloat = 0.0;
    
    self.redInteger = 0;
    self.greenInteger = 0;
    self.blueInteger = 0;
    
    self.redBackgroundValueLabel.text = [NSString stringWithFormat:@"R:"];
    self.greenBackgroundValueLabel.text = [NSString stringWithFormat:@"G:"];
    self.blueBackgroundValueLabel.text = [NSString stringWithFormat:@"B:"];
    
    self.lessRedButton.enabled = YES;
    self.moreRedButton.enabled = YES;
    self.lessGreenButton.enabled = YES;
    self.moreGreenButton.enabled = YES;
    self.lessBlueButton.enabled = YES;
    self.moreBlueButton.enabled = YES;
    
//    NSLog(@"(BEFORE CHECK) firstColor? %d", self.firstColor);
    if (self.firstColor)
    {
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
}

- (IBAction)incrementSegmentedControlValueChanged:(UISegmentedControl *)sender
{
    if (sender == self.basicIncrementSegmentedControl)
    {
        if (sender.selectedSegmentIndex == 0)
        {
            //this means increment == 32
            self.multiplier = 32/256.0;
        }
        else
        {
            //increment == 64
            self.multiplier = 64/256.0;
        }
    }
    else if (sender == self.moderateIncrementSegmentedControl)
    {
        if (sender.selectedSegmentIndex == 0)
        {
            //this means increment == 16
            self.multiplier = 16/256.0;
        }
        else if (sender.selectedSegmentIndex == 1)
        {
            //this means increment == 32
            self.multiplier = 32/256.0;
        }
        else
        {
            //increment == 64
            self.multiplier = 64/256.0;
        }
    }
    else if (sender == self.challengingIncrementSegmentedControl)
    {
        if (sender.selectedSegmentIndex == 0)
        {
            //this means increment == 4
            self.multiplier = 4/256.0;
            //        self.selectedSegment = 0;
        }
        else if (sender.selectedSegmentIndex == 1)
        {
            //this means increment == 16
            self.multiplier = 16/256.0;
        }
        else if (sender.selectedSegmentIndex == 2)
        {
            //this means increment == 32
            self.multiplier = 32/256.0;
        }
        else
        {
            //increment == 64
            self.multiplier = 64/256.0;
        }
    }
    else
    {
        NSLog(@"We have a segment out of control here!");
    }
    
    self.incrementValue = self.multiplier * 256;
//    NSLog(@"incrementValue: %li || multiplier: %f", self.incrementValue, self.multiplier);
}

- (void)changeBackgroundColor
{
//    NSLog(@"redFloat at changeBackgroundColor: %.2f", self.colorWithRedFloat);
    self.view.backgroundColor = [UIColor colorWithRed:self.colorWithRedFloat green:self.colorWithGreenFloat blue:self.colorWithBlueFloat alpha:1.0];
    
    CGFloat redBG, greenBG, blueBG, alphaBG;
    
    [self.view.backgroundColor getRed: &redBG
                                green: &greenBG
                                 blue: &blueBG
                                alpha: &alphaBG];
//    NSLog(@"redBG at changeBackgroundColor: %.2f", redBG);
    self.redBackgroundValueLabel.text = [NSString stringWithFormat:@"R: %.0f", redBG*256];
    self.greenBackgroundValueLabel.text = [NSString stringWithFormat:@"G: %.0f", greenBG*256];
    self.blueBackgroundValueLabel.text = [NSString stringWithFormat:@"B: %.0f", blueBG*256];
    
    self.playerScoreLabel.text = [NSString stringWithFormat:@"Your Score: %lu", (unsigned long)self.totalButtonTaps];
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
    self.firstColor = NO;
    [self chooseGoalColor];
}

- (IBAction)hideFeatureButtonTapped:(id)sender
{
    if ([self.hideFeatureButton.titleLabel.text isEqualToString:@"⚪️"])
    {
        self.redBackgroundValueLabel.hidden = YES;
        self.greenBackgroundValueLabel.hidden = YES;
        self.blueBackgroundValueLabel.hidden = YES;
        
        [self.hideFeatureButton setTitle:@"🔘" forState:UIControlStateNormal];
    }
    else if ([self.hideFeatureButton.titleLabel.text isEqualToString:@"🔘"])
    {
        self.redGoalValueLabel.hidden = YES;
        self.greenGoalValueLabel.hidden = YES;
        self.blueGoalValueLabel.hidden = YES;
        
        [self.hideFeatureButton setTitle:@"⚫️" forState:UIControlStateNormal];
    }
    else
    {
        self.redBackgroundValueLabel.hidden = NO;
        self.greenBackgroundValueLabel.hidden = NO;
        self.blueBackgroundValueLabel.hidden = NO;
        
        self.redGoalValueLabel.hidden = NO;
        self.greenGoalValueLabel.hidden = NO;
        self.blueGoalValueLabel.hidden = NO;
        
        [self.hideFeatureButton setTitle:@"⚪️" forState:UIControlStateNormal];
    }
}

- (IBAction)dismissModalButtonTapped:(id)sender
{
    [self.delegate AMYColorGameViewControllerDidCancel:self];
}

/*
 So something I noticed: whenever I increase by a 1.0 increment, and then try to decrease it by something less, it decreases it by the entire 1.0 amount.
 I THINK I need to adjust the way the increment counts--it should subtract straight from the current amount stated on the label--the valueLabel--and not on the current multiplier or increment.
 */

/*
 Things I want to implement:
 round out the stacks so they look prettier... can stacks be rounded?
 disable difficulties that are 'coming soon!' so I don't need to focus on them yet
 make button for "go back" prettier, maybe just an arrow?  it can be the same color as the goal color at first, and then it can change to white or black, depending on how light the goal/background color is, once they match; make it "appear" just like the 'new color' button does
 
 more advanced stuff/issues:
 check out how it looks on other devices
 set up options for difficulty and hiding fields.  an options screen?
 randomize starter color--that can be another option (instead of default black background), maybe for a crRaaAAazY level!
 a slider to control increment value for higher levels
 fill arrays with colors!
 Make cool background for difficulty selection screen
 Make those buttons look nice
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
 */

/*
    There can be a medium mode, which is more about mixing colors straightaway, now that you understand how the colors interact with each other.  This the increment value can change as you "level up", so it starts off at .1 and then goes to .05, meaning only .# values are possible at the start, and then .## values that are divisible by 5 by the end. //THIS MIGHT NEED TO BE SPLIT INTO TWO LEVELS, ONE FOR JUST .1, AND ONE FOR JUST .05
    The highest level can be the challenging setting, where you have a choice of your increment, from 1 all the way to .01.  This should be a slider, with set amounts--like it paginates to those values--and the amount listed above the slider so you're well aware of what you're incrementing by.  The colors start off easy here as well, to get you used to changing the increment yourself, so I can basically reuse the colors from the earlier settings, although I'll probably smush all of the colors from the easy one into the first difficulty level, then from the medium ones into the next few, and then a brand new amount of colors with .## values of ANY number.
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
 */

@end
