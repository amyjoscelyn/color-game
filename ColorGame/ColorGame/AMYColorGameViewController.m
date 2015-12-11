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
@property (weak, nonatomic) IBOutlet UILabel *alphaGoalValueLabel;

@property (weak, nonatomic) IBOutlet UILabel *redBackgroundValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *greenBackgroundValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *blueBackgroundValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *alphaBackgroundValueLabel;

@property (weak, nonatomic) IBOutlet UIButton *lessRedButton;
@property (weak, nonatomic) IBOutlet UIButton *moreRedButton;
@property (weak, nonatomic) IBOutlet UIButton *lessGreenButton;
@property (weak, nonatomic) IBOutlet UIButton *moreGreenButton;
@property (weak, nonatomic) IBOutlet UIButton *lessBlueButton;
@property (weak, nonatomic) IBOutlet UIButton *moreBlueButton;
@property (weak, nonatomic) IBOutlet UIButton *lessAlphaButton;
@property (weak, nonatomic) IBOutlet UIButton *moreAlphaButton;

@property (weak, nonatomic) IBOutlet UILabel *playerScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *targetScoreLabel;
@property (weak, nonatomic) IBOutlet UIButton *hideFeatureButton;
@property (weak, nonatomic) IBOutlet UIButton *dismissModalButton;

@property (nonatomic) NSUInteger numberOfTimesRedButtonTapped;
@property (nonatomic) NSUInteger numberOfTimesGreenButtonTapped;
@property (nonatomic) NSUInteger numberOfTimesBlueButtonTapped;
@property (nonatomic) NSUInteger numberOfTimesAlphaButtonTapped;

@property (nonatomic) CGFloat colorWithRedFloat;
@property (nonatomic) CGFloat colorWithGreenFloat;
@property (nonatomic) CGFloat colorWithBlueFloat;
@property (nonatomic) CGFloat alphaFloat;

@property (nonatomic) NSUInteger tapCapMax;
@property (nonatomic) NSUInteger tapCapMin;
@property (nonatomic) CGFloat multiplier;

@property (nonatomic, strong) UIColor *currentColor;
@property (nonatomic) NSUInteger currentDifficulty;
@property (nonatomic) NSUInteger totalButtonTaps;

@property (nonatomic, strong) NSArray *veryEasyColors;
@property (nonatomic, strong) NSArray *easyColors;
@property (nonatomic, strong) NSArray *mediumColors;
@property (nonatomic, strong) NSArray *hardColors;
@property (nonatomic, strong) NSArray *masterColors;

@property (nonatomic, strong) AMYSharedDataStore *store;

@end

@implementation AMYColorGameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.store = [AMYSharedDataStore sharedDataStore];
    [self setGoalColors];
    
    //set up mode
    if (self.store.mode == 0) //simple
    {
        [self hideAlpha];
        self.multiplier = 0.25;
    }
    else if (self.store.mode == 1) //basic
    {
        [self hideAlpha];
        self.multiplier = 0.1;
    }
    else if (self.store.mode == 2) //moderate
    {
        [self hideAlpha];
        self.multiplier = 0.05;
    }
    else
    {
        self.multiplier = 0.01;
    }
    
    
    
    
    
    
    [self chooseGoalColor];
    
    self.colorGoalView.layer.cornerRadius = self.colorGoalView.frame.size.height/2;
    self.colorGoalView.clipsToBounds = YES;
}

- (void)hideAlpha
{
    self.lessAlphaButton.hidden = YES;
    self.moreAlphaButton.hidden = YES;
    self.alphaGoalValueLabel.hidden = YES;
    self.alphaBackgroundValueLabel.hidden = YES;
    self.alphaFloat = 1;
}

- (void)setGoalColors
{
    NSArray *arrayOfColorArrays = [AMYColorSetup setColorArraysWithMode:self.store.mode];
    
    self.veryEasyColors = arrayOfColorArrays[0];
    self.easyColors = arrayOfColorArrays[1];
    self.mediumColors = arrayOfColorArrays[2];
    self.hardColors = arrayOfColorArrays[3];
    self.masterColors = arrayOfColorArrays[4];
    
    UIColor *white  = [UIColor whiteColor];     // 1|1|1|1
    self.currentColor = white;
}

- (void)chooseGoalColor
{
    NSMutableArray *colorsArray = [[NSMutableArray alloc] init];
    
    if (self.store.difficulty == 0)
    {
        colorsArray = [self.veryEasyColors mutableCopy];
    }
    else if (self.store.difficulty == 1)
    {
        colorsArray = [self.easyColors mutableCopy];
    }
    else if (self.store.difficulty == 2)
    {
        colorsArray = [self.mediumColors mutableCopy];
    }
    else if (self.store.difficulty == 3)
    {
        colorsArray = [self.hardColors mutableCopy];
    }
    else
    {
        colorsArray = [self.masterColors mutableCopy];
    }
    
    NSUInteger i = 0;
    do
    {
        i = arc4random_uniform((int)colorsArray.count);
    }
    while (colorsArray[i] == self.currentColor);
    
    NSLog(@"difficulty in store: %lu", self.store.difficulty);
    self.currentDifficulty = self.store.difficulty;
    [self setUpGameWithGoalColor:colorsArray[i]];
}

- (void)setUpGameWithGoalColor:(UIColor *)color
{
    self.colorGoalView.backgroundColor = color;
    self.gameLabel.backgroundColor = color;
    self.playerScoreLabel.backgroundColor = color;
    self.targetScoreLabel.backgroundColor = color;
    self.currentColor = color;
    
    NSArray *colorValueLabels = @[ self.redGoalValueLabel,
                                   self.greenGoalValueLabel,
                                   self.blueGoalValueLabel,
                                   self.alphaGoalValueLabel,
                                   self.redBackgroundValueLabel,
                                   self.greenBackgroundValueLabel,
                                   self.blueBackgroundValueLabel,
                                   self.alphaBackgroundValueLabel];
    CGFloat red, green, blue, alpha;
    [color    getRed: &red
               green: &green
                blue: &blue
               alpha: &alpha ];
    
    self.redGoalValueLabel.text = [NSString stringWithFormat:@"R: %.2f", red];
    self.greenGoalValueLabel.text = [NSString stringWithFormat:@"G: %.2f", green];
    self.blueGoalValueLabel.text = [NSString stringWithFormat:@"B: %.2f", blue];
    self.alphaGoalValueLabel.text = [NSString stringWithFormat:@"A: %.2f", alpha];
    
    //SCORE NO LONGER ACCURATE
    NSUInteger targetScore = (red + green + blue) * 10;
    // this is a really rudimentary score algorithm.  It works only when the increment is .1
    // ideally this algorithm would have access to the multiplier to plug in instead of the magic number
    // but once there are options of switching between multiple increments, the score gets a lot harder to calculate
    // I would hate to have to figure them out for every single color and plug them in based on that color :(
    self.targetScoreLabel.text = [NSString stringWithFormat:@"Target Score: %lu", targetScore];
    
    UIColor *textColor = [UIColor whiteColor];
    
    if (red > .7 && green > .7)
    {
        textColor = [UIColor blackColor];
    }
    
    for (UILabel *colorValueLabel in colorValueLabels)
    {
        colorValueLabel.backgroundColor = color;
        [colorValueLabel setTextColor:textColor];
    }
    [self.refreshGameButton setTitleColor:textColor forState:UIControlStateNormal];
    self.refreshGameButton.layer.borderWidth = 2.0f;
    self.refreshGameButton.layer.borderColor = textColor.CGColor;
    self.refreshGameButton.hidden = YES;
    
    self.gameLabel.textColor = textColor;
    self.playerScoreLabel.textColor = textColor;
    self.targetScoreLabel.textColor = textColor;
    
    self.totalButtonTaps = 0;
    self.playerScoreLabel.text = [NSString stringWithFormat:@"Your Score: %lu", self.totalButtonTaps];
    self.gameLabel.text = @"Match the color!";
    
    self.view.backgroundColor = [UIColor blackColor];
    
    [self setUpView];
}

- (void)setUpView
{
//    if (self.store.difficulty == 0 || self.store.difficulty == 1)
//    {
//        self.multiplier = 0.25;
//        self.alphaFloat = 1; //i should probably just hide the alpha buttons
//    }
//    else if (self.store.difficulty == 2)
//    {
//        self.multiplier = 0.05;
//        self.alphaFloat = 1;
//    }
//    else if (self.store.difficulty == 3)
//    {
//        self.multiplier = 0.05;
//        self.alphaFloat = 0.5;
//    }
//    else
//    {
//        self.multiplier = 0.01;
//        self.alphaFloat = 0;
//    }
    
    CGFloat x = 1 / self.multiplier;
    
    self.colorWithRedFloat = 0.0;
    self.colorWithGreenFloat = 0.0;
    self.colorWithBlueFloat = 0.0;
    
    self.numberOfTimesRedButtonTapped = self.colorWithRedFloat;
    self.numberOfTimesGreenButtonTapped = self.colorWithGreenFloat;
    self.numberOfTimesBlueButtonTapped = self.colorWithBlueFloat;
    self.numberOfTimesAlphaButtonTapped = self.alphaFloat * x;
    
    self.tapCapMax = x;
    self.tapCapMin = 0;
    
    self.redBackgroundValueLabel.text = [NSString stringWithFormat:@"R:"];
    self.greenBackgroundValueLabel.text = [NSString stringWithFormat:@"G:"];
    self.blueBackgroundValueLabel.text = [NSString stringWithFormat:@"B:"];
    self.alphaBackgroundValueLabel.text = [NSString stringWithFormat:@"A:"];
    
    self.lessRedButton.enabled = YES;
    self.moreRedButton.enabled = YES;
    self.lessGreenButton.enabled = YES;
    self.moreGreenButton.enabled = YES;
    self.lessBlueButton.enabled = YES;
    self.moreBlueButton.enabled = YES;
    self.lessAlphaButton.enabled = YES;
    self.moreAlphaButton.enabled = YES;
}

- (void)changeBackgroundColor
{
    self.view.backgroundColor = [UIColor colorWithRed:self.colorWithRedFloat green:self.colorWithGreenFloat blue:self.colorWithBlueFloat alpha:self.alphaFloat];
    
    CGFloat redBG, greenBG, blueBG, alphaBG;
    
    [self.view.backgroundColor getRed: &redBG
                                green: &greenBG
                                 blue: &blueBG
                                alpha: &alphaBG];
    self.redBackgroundValueLabel.text = [NSString stringWithFormat:@"R: %.2f", redBG];
    self.greenBackgroundValueLabel.text = [NSString stringWithFormat:@"G: %.2f", greenBG];
    self.blueBackgroundValueLabel.text = [NSString stringWithFormat:@"B: %.2f", blueBG];
    self.alphaBackgroundValueLabel.text = [NSString stringWithFormat:@"A: %.2f", alphaBG];
    
    self.playerScoreLabel.text = [NSString stringWithFormat:@"Your Score: %lu", self.totalButtonTaps];
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

- (IBAction)addAlphaToBackgroundButtonTapped:(UIButton *)sender
{
    if (self.numberOfTimesAlphaButtonTapped == self.tapCapMax)
    {
        sender.enabled = NO;
        return;
    }
    self.numberOfTimesAlphaButtonTapped++;
    self.lessAlphaButton.enabled = YES;
    
    self.alphaFloat = self.numberOfTimesAlphaButtonTapped * self.multiplier;
    
    [self postButtonActions];
}

- (IBAction)takeAwayAlphaFromBackgroundButtonTapped:(UIButton *)sender
{
    if (self.numberOfTimesAlphaButtonTapped == self.tapCapMin)
    {
        sender.enabled = NO;
        return;
    }
    self.numberOfTimesAlphaButtonTapped--;
    self.moreAlphaButton.enabled = YES;
    
    self.alphaFloat = self.numberOfTimesAlphaButtonTapped * self.multiplier;
    
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
    CGColorRef color1 = [self.colorGoalView.backgroundColor CGColor];
    CGColorRef color2 = [self.view.backgroundColor CGColor];
    
    //the chunk of code below might be able to become a method in a new class: `- (BOOL)compareBackgroundColor:(UIColor *)color1 withGoal:(UIColor *)color2;`, with YES being COLORS MATCH and NO being THEY DON'T.
    if (CGColorGetColorSpace(color1) == CGColorGetColorSpace(color2))
    {
        NSUInteger componentsNumber = CGColorGetNumberOfComponents(color1);
        CGFloat tolerance = 0.0001;
        
        const CGFloat *components1 = CGColorGetComponents(color1);
        const CGFloat *components2 = CGColorGetComponents(color2);
        
        for (NSUInteger i = 0; i < componentsNumber; i++)
        {
            CGFloat quotient = components1[i] / components2[i];
            if ((fabs(quotient) - 1) > tolerance)
            {
                return NO;
            }
        }
    }
    return YES;
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
        self.lessAlphaButton.enabled = NO;
        self.moreAlphaButton.enabled = NO;
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
        self.alphaBackgroundValueLabel.hidden = YES;
        
        [self.hideFeatureButton setTitle:@"🔘" forState:UIControlStateNormal];
    }
    else if ([self.hideFeatureButton.titleLabel.text isEqualToString:@"🔘"])
    {
        self.redGoalValueLabel.hidden = YES;
        self.greenGoalValueLabel.hidden = YES;
        self.blueGoalValueLabel.hidden = YES;
        self.alphaGoalValueLabel.hidden = YES;
        
        [self.hideFeatureButton setTitle:@"⚫️" forState:UIControlStateNormal];
    }
    else //I need to make sure alpha is no longer hidden only for the modes that show alpha.  otherwise, it stays hidden!
    {
        self.redBackgroundValueLabel.hidden = NO;
        self.greenBackgroundValueLabel.hidden = NO;
        self.blueBackgroundValueLabel.hidden = NO;
        self.alphaBackgroundValueLabel.hidden = NO;
        self.redGoalValueLabel.hidden = NO;
        self.greenGoalValueLabel.hidden = NO;
        self.blueGoalValueLabel.hidden = NO;
        self.alphaGoalValueLabel.hidden = NO;
        
        [self.hideFeatureButton setTitle:@"⚪️" forState:UIControlStateNormal];
    }
}

- (IBAction)dismissModalButtonTapped:(id)sender
{
    [self.delegate AMYColorGameViewControllerDidCancel:self];
}

/*
 Things I want to implement:
 round out the stacks so they look prettier... can stacks be rounded?
 disable difficulties that are 'coming soon!' so I don't need to focus on them yet
 
 more advanced stuff/issues:
 check out how it looks on other devices
 set up options for difficulty and hiding fields.  an options screen?
 randomize starter color--that can be another option (instead of default black background), maybe for a crRaaAAazY level!
 a slider to control increment value for higher levels
 possible multiple views, one for each difficulty, so that I can customize the appearance and spacing for what's pertinent on each
 fill arrays with colors!
 take away alpha button for easy and medium colors
 I can add an even more zen mode, where there is no target and you just press the buttons to make colors
 Make cool background for difficulty selection screen
 Make those buttons look nice
 Make everything look nice
 maybe the very easiest level should have an increment of .25, easy with .1, and then so on and on
 
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
 
 if I don't have the alpha buttons, then I don't need the labels saying what the alpha is supposed to be, either
 
 when I do have alpha, it should be an increment of .25, so that it can only be .25, .5, .75, 1.  Maybe one day I can make an EXTREME mode that has alpha of harder values.
 */

/*
 Maaaaaayyyybe the difficulty levels shouldn't be so cut and dry: maybe there can be an easy mode, where it still levels up, but the increment stays pretty high--.25--but you mix more and more of the colors together within those increments (0, .25, .5, .75, 1 are the only possible values)
    There can be a medium mode, which is more about mixing colors straightaway, now that you understand how the colors interact with each other.  This the increment value can change as you "level up", so it starts off at .1 and then goes to .05, meaning only .# values are possible at the start, and then .## values that are divisible by 5 by the end. //THIS MIGHT NEED TO BE SPLIT INTO TWO LEVELS, ONE FOR JUST .1, AND ONE FOR JUST .05
    The highest level can be the challenging setting, where you have a choice of your increment, from 1 all the way to .01.  This should be a slider, with set amounts--like it paginates to those values--and the amount listed above the slider so you're well aware of what you're incrementing by.  The colors start off easy here as well, to get you used to changing the increment yourself, so I can basically reuse the colors from the earlier settings, although I'll probably smush all of the colors from the easy one into the first difficulty level, then from the medium ones into the next few, and then a brand new amount of colors with .## values of ANY number.
    THESE SHOULD ALL BE CALLED COMPLEXITY SETTINGS, or COMPLEXITY LEVELS or something.  Complexity mode?
    There can ALSO be a zen mode!!!  This doesn't score and doesn't give you a goal, but you're able to play around and make colors just to see what it can do.
 
 You can make any setting or mode or whatever zen by hiding your score/target score.  Those options are exclusively togglable, since you might only want to hide the target but keep your own score.
 */

@end
