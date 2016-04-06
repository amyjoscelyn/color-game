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

@property (weak, nonatomic) IBOutlet UISegmentedControl *incrementSegmentedControl;

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

@property (nonatomic) NSInteger redInteger;
@property (nonatomic) NSInteger greenInteger;
@property (nonatomic) NSInteger blueInteger;

@property (nonatomic) NSUInteger tapCapMax;
@property (nonatomic) NSUInteger tapCapMin;
@property (nonatomic) CGFloat multiplier;
@property (nonatomic) NSInteger incrementValue;

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
    self.incrementValue = self.multiplier * 256;
    
    self.currentColor = [UIColor whiteColor];
    
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
    
    self.incrementSegmentedControl.tintColor = textColor;
    
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
    
    self.dismissModalButton.backgroundColor = color;
    self.dismissModalButton.titleLabel.textColor = textColor;
    self.dismissModalButton.layer.cornerRadius = 5;
    self.dismissModalButton.layer.borderWidth = 2.0f;
    self.dismissModalButton.layer.borderColor = textColor.CGColor;
//    self.dismissModalButton.tintColor = textColor;
    
    self.totalButtonTaps = 0;
    self.playerScoreLabel.text = [NSString stringWithFormat:@"Your Score: %lu", (unsigned long)self.totalButtonTaps];
    self.gameLabel.text = @"Match the color!";
    
    self.view.backgroundColor = [UIColor blackColor];
    
    [self setUpView];
}

- (void)setUpView
{    
    self.colorWithRedFloat = 0.0;
    self.colorWithGreenFloat = 0.0;
    self.colorWithBlueFloat = 0.0;
    
    self.redInteger = 0;
    self.greenInteger = 0;
    self.blueInteger = 0;
    
    self.numberOfTimesRedButtonTapped = self.colorWithRedFloat;
    self.numberOfTimesGreenButtonTapped = self.colorWithGreenFloat;
    self.numberOfTimesBlueButtonTapped = self.colorWithBlueFloat;
    
    self.tapCapMax = 256;
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
    
    if (self.store.mode == 0 || self.store.mode == 1)
    {
        self.incrementSegmentedControl.hidden = YES;
    }
    else if (self.store.mode == 2)
    {
        self.incrementSegmentedControl.hidden = NO;
        self.incrementSegmentedControl.selectedSegmentIndex = 1;
    }
    else if (self.store.mode == 3)
    {
        self.incrementSegmentedControl.hidden = NO;
        self.incrementSegmentedControl.selectedSegmentIndex = 0;
    }
    //maybe one day I can have a separate segmentedControl for each mode--mode 1 can just have 32 and 64, mode 2 can have 3, and 3 can have all four, the current segmentedControl.  Then I can just hide them appropriately and only show the one that's called for.
    else
    {
        NSLog(@"Somehow you've gotten off the rails. Pick an existing difficulty.");
    }
}

- (IBAction)incrementSegmentedControlValueChanged:(id)sender
{
    if (self.incrementSegmentedControl.selectedSegmentIndex == 0)
    {
        //this means increment == 4
        self.multiplier = 4/256.0;
    }
    else if (self.incrementSegmentedControl.selectedSegmentIndex == 1)
    {
        //this means increment == 16
        self.multiplier = 16/256.0;
    }
    else if (self.incrementSegmentedControl.selectedSegmentIndex == 2)
    {
        //this means increment == 32
        self.multiplier = 32/256.0;
    }
    else
    {
        //increment == 64
        self.multiplier = 64/256.0;
    }
    self.incrementValue = self.multiplier * 256;
    NSLog(@"incrementValue: %li || multiplier: %f", self.incrementValue, self.multiplier);
}

- (void)changeBackgroundColor
{
    NSLog(@"redFloat at changeBackgroundColor: %.2f", self.colorWithRedFloat);
    self.view.backgroundColor = [UIColor colorWithRed:self.colorWithRedFloat green:self.colorWithGreenFloat blue:self.colorWithBlueFloat alpha:1.0];
    
    CGFloat redBG, greenBG, blueBG, alphaBG;
    
    [self.view.backgroundColor getRed: &redBG
                                green: &greenBG
                                 blue: &blueBG
                                alpha: &alphaBG];
    NSLog(@"redBG at changeBackgroundColor: %.2f", redBG);
    self.redBackgroundValueLabel.text = [NSString stringWithFormat:@"R: %.0f", redBG*256];
    self.greenBackgroundValueLabel.text = [NSString stringWithFormat:@"G: %.0f", greenBG*256];
    self.blueBackgroundValueLabel.text = [NSString stringWithFormat:@"B: %.0f", blueBG*256];
    
    self.playerScoreLabel.text = [NSString stringWithFormat:@"Your Score: %lu", (unsigned long)self.totalButtonTaps];
}

- (IBAction)makeBackgroundMoreRedButtonTapped:(UIButton *)sender
{
    if (self.redInteger >= self.tapCapMax)
    {
        sender.enabled = NO;
        return;
    }
    self.numberOfTimesRedButtonTapped++;
    self.lessRedButton.enabled = YES;
    
    self.redInteger += self.incrementValue;
    self.colorWithRedFloat = self.redInteger/256.0;
    
    if (self.redInteger >= 256)
    {
        self.redInteger = 256;
    }
    /*
     okay.  here's my inherent problem with the way this is already set up:
     to set the background color, the method is inputting the .colorWith%@Float for each colorValue
     that property is being set by multiplying the number of times that particular button has been tapped by the .multiplier
     the multiplier is supposed to be variable
     unfortunately, the number of times the button is able to be tapped is static
     it is set to the multiplier in viewDidLoad (I'm pretty sure), once the difficulty is set for the game
     if we change the multiplier halfway through, the button doesn't know and will still try to let the button be tapped, even though it theoretically should be past the tapCapMax
     so if we try to increase or decrease the colorValue, even though the multiplier might be correct, the number of times the button has been tapped might be skewed off because of the adjusted increment/multiplier
     this is probably why when i would max out the color to 1.0, when i tried to decrease at a different multiplier, the number would go down waaaay differently from what i expected it to
     this is just a surmise, but it sounds like it's what it was
     
     so how to fix this?
     well, i think there needs to be a new way to read each colorValue
     if we have a colorValue property, we can do math off of that to adjust the values for the method
     the maxCap can be whether it == or is > than 256, since that's the highest
     in the same way, the minCap can be 0
     instead of calculating the current value by the amount of taps on that specific button, we can do math directly on the .colorValue, based off the multiplier, which is set by the segmented control
     if the max/minCap is reached, then it can turn interaction off until the other button is tapped
     I'm going to need to find a new way to keep score anyway... wouldn't it make more sense to just have a general buttonTapped property that keeps track of ALL taps, and only use that in relation to score, and not the background color?
     i think it does, anyway.
     And that's what matters!
     
     So, in short:
     I need to know .incrementValue (from segmentedControl)
     .multiplier (from .incrementValue... they're really kind of the same thing)
     .tapCapMax which should now be an integer value == 256
     .tapCapMin which should be 0
     new methods to turn off interaction if tapCap is reached or exceeded
     redValue, greenValue, and blueValue for straight up calculating the backgroundColor.  these are the numbers the multiplier will add or subtract from
     OOH.  okay, so .multiplier should be gotten straight from the incrementSegCon, and .increment should be .multipler * 10(0?) so that math can be done with .increment and .%@Value, no need for any more taps being tracked
     a single .totalTaps for general taps taken in this current game.  It can only increase, and is read straight to the score label, nothing else.  it should be reset with each new color
     
     Everything?  Let's hope!  And let's do this!
    */

    [self postButtonActions];
}

- (IBAction)makeBackgroundLessRedButtonTapped:(UIButton *)sender
{
    if (self.redInteger <= self.tapCapMin)
    {
        sender.enabled = NO;
        return;
    }
    self.numberOfTimesRedButtonTapped--;
    self.moreRedButton.enabled = YES;
    
    self.redInteger -= self.incrementValue;
    self.colorWithRedFloat = self.redInteger/256.0;
    
    if (self.redInteger <= 0)
    {
        self.redInteger = 0;
    }
    
    [self postButtonActions];
}

- (IBAction)makeBackgroundMoreGreenButtonTapped:(UIButton *)sender
{
    if (self.greenInteger >= self.tapCapMax)
    {
        sender.enabled = NO;
        return;
    }
    self.numberOfTimesGreenButtonTapped++;
    self.lessGreenButton.enabled = YES;
    
    self.greenInteger += self.incrementValue;
    self.colorWithGreenFloat = self.greenInteger/256.0;
    
    if (self.greenInteger >= 256)
    {
        self.greenInteger = 256;
    }
    
    [self postButtonActions];
}

- (IBAction)makeBackgroundLessGreenButtonTapped:(UIButton *)sender
{
    if (self.greenInteger <= self.tapCapMin)
    {
        sender.enabled = NO;
        return;
    }
    self.numberOfTimesGreenButtonTapped--;
    self.moreGreenButton.enabled = YES;
    
    self.greenInteger -= self.incrementValue;
    self.colorWithGreenFloat = self.greenInteger/256.0;
    
    if (self.greenInteger <= 0)
    {
        self.greenInteger = 0;
    }
    
    [self postButtonActions];
}

- (IBAction)makeBackgroundMoreBlueButtonTapped:(UIButton *)sender
{
    if (self.blueInteger >= self.tapCapMax)
    {
        sender.enabled = NO;
        return;
    }
    self.numberOfTimesBlueButtonTapped++;
    self.lessBlueButton.enabled = YES;
    
    self.blueInteger += self.incrementValue;
    self.colorWithBlueFloat = self.blueInteger/256.0;
    
    if (self.blueInteger >= 256)
    {
        self.blueInteger = 256;
    }
    
    [self postButtonActions];
}

- (IBAction)makeBackgroundLessBlueButtonTapped:(UIButton *)sender
{
    if (self.blueInteger <= self.tapCapMin)
    {
        sender.enabled = NO;
        return;
    }
    self.numberOfTimesBlueButtonTapped--;
    self.moreBlueButton.enabled = YES;
    
    self.blueInteger -= self.incrementValue;
    self.colorWithBlueFloat = self.blueInteger/256.0;
    
    if (self.blueInteger <= 0)
    {
        self.blueInteger = 0;
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
{/*
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
    self.currentIncrementLabel.text = [NSString stringWithFormat:@"Increment: %.2f", increment];*/
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
