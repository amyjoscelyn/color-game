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

@property (weak, nonatomic) IBOutlet UISlider *incrementSlider;
@property (weak, nonatomic) IBOutlet UILabel *minimumIncrementLabel;
@property (weak, nonatomic) IBOutlet UILabel *maximumIncrementLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentIncrementLabel;

@property (weak, nonatomic) IBOutlet UILabel *playerScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *targetScoreLabel;
@property (weak, nonatomic) IBOutlet UIButton *hideFeatureButton;
@property (weak, nonatomic) IBOutlet UIButton *dismissModalButton;

@property (nonatomic) NSUInteger numberOfTimesRedButtonTapped;
@property (nonatomic) NSUInteger numberOfTimesGreenButtonTapped;
@property (nonatomic) NSUInteger numberOfTimesBlueButtonTapped;

@property (nonatomic) CGFloat colorWithRedFloat;
@property (nonatomic) CGFloat colorWithGreenFloat;
@property (nonatomic) CGFloat colorWithBlueFloat;

@property (nonatomic) NSUInteger tapCapMax;
@property (nonatomic) NSUInteger tapCapMin;
@property (nonatomic) CGFloat multiplier;

@property (nonatomic, strong) UIColor *currentColor;
@property (nonatomic) NSUInteger currentDifficulty; //is this important?
@property (nonatomic) NSUInteger totalButtonTaps;

@property (nonatomic, strong) AMYSharedDataStore *store;

@end

@implementation AMYColorGameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.store = [AMYSharedDataStore sharedDataStore];
    
    //set up mode
    //MULTIPLIER SYSTEM HAS CHANGED!!!!!!
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
    self.currentIncrementLabel.text = [NSString stringWithFormat:@"Increment: %.2f", self.multiplier];
    self.incrementSlider.value = self.incrementSlider.minimumValue;
    
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
    UIColor *colorChosen = [setup setColorWithMode:self.store.mode difficulty:self.store.difficulty];
    
    UIColor *white  = [UIColor whiteColor];
    self.currentColor = white;

    self.currentDifficulty = self.store.difficulty; //is this important?
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
    //Okay.  So here we have red, green, blue, and alpha all coming off of the target color.  It's coming to us in a format out of 1.0, not 256 like we're incrementing in.
    //What I need to do is turn that ##/1.0 value back into one out of 256.0
    //We should just be able to multiply it by 256, and it should be with us instantly!
    //Of course, floats are awful at math.  Rounding problems, remember?  Ugh...
    //Let's just try it anyway.  I do compensate later for rounding errors, and this is just a label anyway.  Besides, we shouldn't have any decimal places once we're finished.
    
    self.redGoalValueLabel.text = [NSString stringWithFormat:@"R: %.0f", red*256];
    self.greenGoalValueLabel.text = [NSString stringWithFormat:@"G: %.0f", green*256];
    self.blueGoalValueLabel.text = [NSString stringWithFormat:@"B: %.0f", blue*256];
    
    NSUInteger targetScore = (red + green + blue) * (1/self.multiplier);
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
        textColor = [UIColor colorWithRed:0.05 green:0.15 blue:0.05 alpha:1.0];
    } //So... this is working correctly, but the background of the label is too dark to be able to see the contrast against the black background.
    //BACKGROUND COLOR OF LABELS NEEDS TO BE CHECKED AND ADJUSTED!!!!!!!!!!!
    
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
    
    NSArray *gameLabels = @[ self.gameLabel, self.playerScoreLabel, self.targetScoreLabel, self.minimumIncrementLabel, self.maximumIncrementLabel, self.currentIncrementLabel ];
    
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
    
//    self.minimumIncrementLabel.textColor = textColor;
//    self.maximumIncrementLabel.textColor = textColor;
    
//    self.currentIncrementLabel.textColor = textColor;
//    self.currentIncrementLabel.layer.shadowColor = [textColor CGColor];
//    self.currentIncrementLabel.layer.shadowRadius = 4.0f;
//    self.currentIncrementLabel.layer.shadowOpacity = .9;
//    self.currentIncrementLabel.layer.shadowOffset = CGSizeZero;
//    self.currentIncrementLabel.layer.masksToBounds = NO;
    
    self.dismissModalButton.backgroundColor = color;
    self.dismissModalButton.titleLabel.textColor = textColor;
    self.dismissModalButton.layer.cornerRadius = 5;
    self.dismissModalButton.layer.borderWidth = 2.0f;
    self.dismissModalButton.layer.borderColor = textColor.CGColor;
    
    self.totalButtonTaps = 0;
    self.playerScoreLabel.text = [NSString stringWithFormat:@"Your Score: %lu", (unsigned long)self.totalButtonTaps];
    self.gameLabel.text = @"Match the color!";
    
    self.view.backgroundColor = [UIColor blackColor];
    
    [self setUpView];
}

- (void)setUpView
{
    CGFloat x = 2.56 / self.multiplier; //I HAVE CHANGED THIS AS WELL
    
    self.colorWithRedFloat = 0.0;
    self.colorWithGreenFloat = 0.0;
    self.colorWithBlueFloat = 0.0;
    
    self.numberOfTimesRedButtonTapped = self.colorWithRedFloat;
    self.numberOfTimesGreenButtonTapped = self.colorWithGreenFloat;
    self.numberOfTimesBlueButtonTapped = self.colorWithBlueFloat;
    
    self.tapCapMax = x;
    self.tapCapMin = 0;
    
    self.redBackgroundValueLabel.text = [NSString stringWithFormat:@"R:"];
    self.greenBackgroundValueLabel.text = [NSString stringWithFormat:@"G:"];
    self.blueBackgroundValueLabel.text = [NSString stringWithFormat:@"B:"];
    
    self.lessRedButton.enabled = YES;
    self.moreRedButton.enabled = YES;
    self.lessGreenButton.enabled = YES;
    self.moreGreenButton.enabled = YES;
    self.lessBlueButton.enabled = YES;
    self.moreBlueButton.enabled = YES;
    
    if (self.store.mode == 0)
    {
        self.incrementSlider.hidden = YES;
        self.minimumIncrementLabel.hidden = YES;
        self.maximumIncrementLabel.hidden = YES;
    }
    else if (self.store.mode == 1)
    {
        self.incrementSlider.hidden = NO;
        self.minimumIncrementLabel.hidden = NO;
        self.maximumIncrementLabel.hidden = NO;
        //I NEED TO CHANGE THESE AT SOME POINT... WE'RE ON A .4 SCALE NOW!
        self.minimumIncrementLabel.text = @"0.10";
        self.maximumIncrementLabel.text = @"1.0";
    }
    else if (self.store.mode == 2)
    {
        self.incrementSlider.hidden = NO;
        self.minimumIncrementLabel.hidden = NO;
        self.maximumIncrementLabel.hidden = NO;
        
        self.minimumIncrementLabel.text = @"0.05";
        self.maximumIncrementLabel.text = @"1.0";
    }
    else if (self.store.mode == 3)
    {
        self.incrementSlider.hidden = NO;
        self.minimumIncrementLabel.hidden = NO;
        self.maximumIncrementLabel.hidden = NO;
        
        self.minimumIncrementLabel.text = @"0.01";
        self.maximumIncrementLabel.text = @"1.0";
    }
    else
    {
        NSLog(@"Somehow you've gotten off the rails. Pick an existing difficulty.");
    }
}

- (void)changeBackgroundColor
{
    self.view.backgroundColor = [UIColor colorWithRed:self.colorWithRedFloat green:self.colorWithGreenFloat blue:self.colorWithBlueFloat alpha:1.0];
    
    CGFloat redBG, greenBG, blueBG, alphaBG;
    
    [self.view.backgroundColor getRed: &redBG
                                green: &greenBG
                                 blue: &blueBG
                                alpha: &alphaBG];
    self.redBackgroundValueLabel.text = [NSString stringWithFormat:@"R: %.0f", redBG*256];
    self.greenBackgroundValueLabel.text = [NSString stringWithFormat:@"G: %.0f", greenBG*256];
    self.blueBackgroundValueLabel.text = [NSString stringWithFormat:@"B: %.0f", blueBG*256];
    
    self.playerScoreLabel.text = [NSString stringWithFormat:@"Your Score: %lu", (unsigned long)self.totalButtonTaps];
}

- (IBAction)makeBackgroundMoreRedButtonTapped:(UIButton *)sender
{
    if (self.numberOfTimesRedButtonTapped == self.tapCapMax)
    {
        sender.enabled = NO;
        return;
    }
    self.numberOfTimesRedButtonTapped++;
    self.lessRedButton.enabled = YES;
    
    self.colorWithRedFloat = self.numberOfTimesRedButtonTapped * self.multiplier;

    [self postButtonActions];
}

- (IBAction)makeBackgroundLessRedButtonTapped:(UIButton *)sender
{
    if (self.numberOfTimesRedButtonTapped == self.tapCapMin)
    {
        sender.enabled = NO;
        return;
    }
    self.numberOfTimesRedButtonTapped--;
    self.moreRedButton.enabled = YES;
    
    self.colorWithRedFloat = self.numberOfTimesRedButtonTapped * self.multiplier;
    
    [self postButtonActions];
}

- (IBAction)makeBackgroundMoreGreenButtonTapped:(UIButton *)sender
{
    if (self.numberOfTimesGreenButtonTapped == self.tapCapMax)
    {
        sender.enabled = NO;
        return;
    }
    self.numberOfTimesGreenButtonTapped++;
    self.lessGreenButton.enabled = YES;
    
    self.colorWithGreenFloat = self.numberOfTimesGreenButtonTapped * self.multiplier;
    
    [self postButtonActions];
}

- (IBAction)makeBackgroundLessGreenButtonTapped:(UIButton *)sender
{
    if (self.numberOfTimesGreenButtonTapped == self.tapCapMin)
    {
        sender.enabled = NO;
        return;
    }
    self.numberOfTimesGreenButtonTapped--;
    self.moreGreenButton.enabled = YES;
    
    self.colorWithGreenFloat = self.numberOfTimesGreenButtonTapped * self.multiplier;
    
    [self postButtonActions];
}

- (IBAction)makeBackgroundMoreBlueButtonTapped:(UIButton *)sender
{
    if (self.numberOfTimesBlueButtonTapped == self.tapCapMax)
    {
        sender.enabled = NO;
        return;
    }
    self.numberOfTimesBlueButtonTapped++;
    self.lessBlueButton.enabled = YES;
    
    self.colorWithBlueFloat = self.numberOfTimesBlueButtonTapped * self.multiplier;
    
    [self postButtonActions];
}

- (IBAction)makeBackgroundLessBlueButtonTapped:(UIButton *)sender
{
    if (self.numberOfTimesBlueButtonTapped == self.tapCapMin)
    {
        sender.enabled = NO;
        return;
    }
    self.numberOfTimesBlueButtonTapped--;
    self.moreBlueButton.enabled = YES;
    
    self.colorWithBlueFloat = self.numberOfTimesBlueButtonTapped * self.multiplier;
    
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

- (IBAction)incrementSliderValueChanged:(UISlider *)slider
{
    CGFloat increment = self.multiplier;
    
    if (slider.value == slider.minimumValue)
    {
        increment = self.minimumIncrementLabel.text.floatValue;
        self.multiplier = increment;
    }
    
    if (slider.value == slider.maximumValue)
    {
        increment = self.maximumIncrementLabel.text.floatValue;
        self.multiplier = increment;
    }
    
    if (self.store.mode == 1)
    {
        if (slider.value > slider.minimumValue && slider.value < slider.maximumValue / 2)
        {
            increment = 0.25;
            self.multiplier = increment;
        }
        else if (slider.value > slider.maximumValue / 2 && slider.value < slider.maximumValue)
        {
            increment = 0.5;
            self.multiplier = increment;
        }
    }
    else if (self.store.mode == 2)
    {
        if (slider.value > slider.minimumValue && slider.value < slider.maximumValue / 3)
        {
            increment = 0.1;
            self.multiplier = increment;
        }
        else if (slider.value > slider.maximumValue / 3 && slider.value < slider.maximumValue * 2 / 3)
        {
            increment = 0.25;
            self.multiplier = increment;
        }
        else if (slider.value > slider.maximumValue * 2 / 3 && slider.value < slider.maximumValue)
        {
            increment = 0.5;
            self.multiplier = increment;
        }
    }
    else
    {
        if (slider.value > slider.minimumValue && slider.value < slider.maximumValue / 4)
        {
            increment = 0.05;
            self.multiplier = increment;
        }
        else if (slider.value > slider.maximumValue / 4 && slider.value < slider.maximumValue / 2)
        {
            increment = 0.1;
            self.multiplier = increment;
        }
        else if (slider.value > slider.maximumValue / 2 && slider.value < slider.maximumValue * 3 / 4)
        {
            increment = 0.25;
            self.multiplier = increment;
        }
        else if (slider.value > slider.maximumValue * 3 / 4 && slider.value < slider.maximumValue)
        {
            increment = 0.5;
            self.multiplier = increment;
        }
    }
    self.currentIncrementLabel.text = [NSString stringWithFormat:@"Increment: %.2f", increment];
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

@end
