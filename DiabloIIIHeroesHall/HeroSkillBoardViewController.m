//
//  HeroSkillBoardViewController.m
//  DiabloIIIHerosHall
//
//  Created by  on 12-5-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HeroSkillBoardViewController.h"

@implementation HeroSkillBoardViewController
@synthesize heroClass;
@synthesize heroSex;

@synthesize barbarianSkillBoard = _barbarianSkillBoard;
@synthesize demonhunterSkillBoard = _demonhunterSkillBoard;
@synthesize monkSkillBoard = _monkSkillBoard;
@synthesize witchdoctorSkillBoard = _witchdoctorSkillBoard;
@synthesize wizardSkillBoard = _wizardSkillBoard;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        UIImage *backImg = [UIImage imageNamed:@"bt_back"];
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [backBtn setBackgroundImage:backImg forState:UIControlStateNormal];
        backBtn.frame = CGRectMake(0, 0, backImg.size.width, backImg.size.height);
        [backBtn addTarget:self action:@selector(goHall) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        self.navigationItem.leftBarButtonItem = left;
        [left release];
        viewControllerWillTerminate = NO;
        
        imageNameArray = [[NSArray alloc] initWithObjects:@"avatar_bar_f",@"avatar_dh_f",@"avatar_monk_f",@"avatar_wd_f",@"avatar_wz_f",@"avatar_bar_m",@"avatar_dh_m",@"avatar_monk_m",@"avatar_wd_m",@"avatar_wz_m",nil];
        classNameArray = [[NSArray alloc] initWithObjects:@"Barbarian", @"Demon Hunter",@"Monk",@"Witch Doctor",@"Winzard",nil];
        skillSystemNameArray = [[NSArray alloc] initWithObjects:@"Might",@"Tactics",@"Rage",@"Hunting",@"Devices",@"Archery",@"Techniques",@"Focus",@"Mantras",@"Terror",@"Decay",@"Voodoo",@"Force",@"Conjuration",@"Mastery",@"Primary",@"Secondary",@"Defensive",nil];
        
        
        //init or reset
        initiative = [[NSMutableArray alloc] initWithObjects:@".",@".",@".",@".",@".",@".", nil];
        passive = [[NSMutableArray alloc] initWithObjects:@".",@".",@".", nil];
        runes = [[NSMutableArray alloc] initWithObjects:@".",@".",@".",@".",@".",@".", nil];
        pages = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:0],[NSNumber numberWithInt:1],[NSNumber numberWithInt:2],[NSNumber numberWithInt:3],[NSNumber numberWithInt:4],[NSNumber numberWithInt:5], nil];
        tags = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:-1],[NSNumber numberWithInt:-1],[NSNumber numberWithInt:-1],[NSNumber numberWithInt:-1],[NSNumber numberWithInt:-1],[NSNumber numberWithInt:-1],[NSNumber numberWithInt:-1],[NSNumber numberWithInt:-1],[NSNumber numberWithInt:-1], nil];
    }
    return self;
}

- (void)dealloc
{
    [heroAvatar release];
    [className release];
    
    [mouseLeftSkill release];
    [mouseRightSkill release];
    [numOneSkill release];
    [numTwoSkill release];
    [numThreeSkill release];
    [numFourSkill release];
    
    //name label
    [mouseLeftSkillName release];
    [mouseRightSkillName release];
    [numOneSkillName release];
    [numTwoSkillName release];
    [numThreeSkillName release];
    [numFourSkillName release];
    //rune label
    [mouseLeftRuneName release];
    [mouseRightRuneName release];
    [numOneRuneName release];
    [numTwoRuneName release];
    [numThreeRuneName release];
    [numFourRuneName release];
    //pskill label
    [passiveSkillOneName release];
    [passiveSkillTwoName release];
    [passiveSkillThreeName release];
    //skill image
    [mouseLeftSkillImage release];
    [mouseRightSkillImage release];
    [numOneSkillImage release];
    [numTwoSkillImage release];
    [numThreeSkillImage release];
    [numFourSkillImage release];
    //rune image
    [mouseLeftRuneImage release];
    [mouseRightRuneImage release];
    [numOneRuneImage release];
    [numTwoRuneImage release];
    [numThreeRuneImage release];
    [numFourRuneImage release];
    //pskill image
    [passiveSkillOneImage release];
    [passiveSkillTwoImage release];
    [passiveSkillThreeImage release];
    
    [initiative release];
    [passive release];
    [runes release];
    [pages release];
    [tags release];
    
    [imageNameArray release];
    [classNameArray release];
    [skillSystemNameArray release];
    
    [_barbarianSkillBoard release];
    [_demonhunterSkillBoard release];
    [_monkSkillBoard release];
    [_witchdoctorSkillBoard release];
    [_wizardSkillBoard release];
    [super dealloc];
}

- (void)goHall
{
    if(currentSkillBoard.isHeroSkillDetailShown)
    {
        [currentSkillBoard restoreViewLocation];
        viewControllerWillTerminate = YES;
    }
    else {
        [[[[UIApplication sharedApplication] keyWindow] viewWithTag:13811150829] removeFromSuperview];
        [self.navigationController popViewControllerAnimatedWithTransition:UIViewAnimationTransitionCurlDown];
    }
}

- (void)skillBoardDidFinishClosing
{
    [self makeButtonUnSelected];
    if (viewControllerWillTerminate) {
        [[[[UIApplication sharedApplication] keyWindow] viewWithTag:13811150829] removeFromSuperview];
        [self.navigationController popViewControllerAnimatedWithTransition:UIViewAnimationTransitionCurlDown];
    }
}

- (void)initiativeSkillSelected:(NSString *)heroClasses withSkillKey:(NSString *)skillKey withPage:(NSNumber *)page withTag:(NSNumber *)tag
{
    AppDelegate *mainDelegate = [[UIApplication sharedApplication] delegate];
    NSDictionary *class = [mainDelegate.heroSkillDataSource objectForKey:heroClasses];
    NSDictionary *type = [class objectForKey:@"Initiative"];
    NSDictionary *skill = [type objectForKey:skillKey];
    NSString *skillName = NSLocalizedString([skill objectForKey:@"name"],nil);
    NSString *skillSystem = NSLocalizedString([skill objectForKey:@"system"],nil);
    UIImage *skillImage = [UIImage imageNamed:[skill objectForKey:@"image"]];
    UIColor *color = [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:210.0/255.0 alpha:1.0];
    switch (selectedButton.tag) {
        case 660:
            [mouseLeftSkill setText:skillSystem];
            [mouseLeftSkillName setTextColor:color];
            [mouseLeftSkillName setText:skillName];
            [mouseLeftSkillImage setImage:skillImage];
            [initiative removeObjectAtIndex:0];
            [initiative insertObject:skillKey atIndex:0];
            [pages removeObjectAtIndex:0];
            [pages insertObject:page atIndex:0];
            [tags removeObjectAtIndex:0];
            [tags insertObject:tag atIndex:0];
            break;
        case 661:
            [mouseRightSkill setText:skillSystem];
            [mouseRightSkillName setTextColor:color];
            [mouseRightSkillName setText:skillName];
            [mouseRightSkillImage setImage:skillImage];
            [initiative removeObjectAtIndex:1];
            [initiative insertObject:skillKey atIndex:1];
            [pages removeObjectAtIndex:1];
            [pages insertObject:page atIndex:1];
            [tags removeObjectAtIndex:1];
            [tags insertObject:tag atIndex:1];
            break;
        case 662:
            [numOneSkill setText:skillSystem];
            [numOneSkillName setTextColor:color];
            [numOneSkillName setText:skillName];
            [numOneSkillImage setImage:skillImage];
            [initiative removeObjectAtIndex:2];
            [initiative insertObject:skillKey atIndex:2];
            [pages removeObjectAtIndex:2];
            [pages insertObject:page atIndex:2];
            [tags removeObjectAtIndex:2];
            [tags insertObject:tag atIndex:2];
            break;
        case 663:
            [numTwoSkill setText:skillSystem];
            [numTwoSkillName setTextColor:color];
            [numTwoSkillName setText:skillName];
            [numTwoSkillImage setImage:skillImage];
            [initiative removeObjectAtIndex:3];
            [initiative insertObject:skillKey atIndex:3];
            [pages removeObjectAtIndex:3];
            [pages insertObject:page atIndex:3];
            [tags removeObjectAtIndex:3];
            [tags insertObject:tag atIndex:3];
            break;
        case 664:
            [numThreeSkill setText:skillSystem];
            [numThreeSkillName setTextColor:color];
            [numThreeSkillName setText:skillName];
            [numThreeSkillImage setImage:skillImage];
            [initiative removeObjectAtIndex:4];
            [initiative insertObject:skillKey atIndex:4];
            [pages removeObjectAtIndex:4];
            [pages insertObject:page atIndex:4];
            [tags removeObjectAtIndex:4];
            [tags insertObject:tag atIndex:4];
            break;
        case 665:
            [numFourSkill setText:skillSystem];
            [numFourSkillName setTextColor:color];
            [numFourSkillName setText:skillName];
            [numFourSkillImage setImage:skillImage];
            [initiative removeObjectAtIndex:5];
            [initiative insertObject:skillKey atIndex:5];
            [pages removeObjectAtIndex:5];
            [pages insertObject:page atIndex:5];
            [tags removeObjectAtIndex:5];
            [tags insertObject:tag atIndex:5];
            break;
    }
}

- (void)runeSelected:(NSString *)heroClasses withSkillKey:(NSString *)skillKey withRuneKey:(NSString *)runeKey{
    AppDelegate *mainDelegate = [[UIApplication sharedApplication] delegate];
    NSDictionary *class = [mainDelegate.heroSkillDataSource objectForKey:heroClasses];
    NSDictionary *type = [class objectForKey:@"Initiative"];
    NSDictionary *skill = [type objectForKey:skillKey];
    NSDictionary *rune = [[skill objectForKey:@"runes"] objectForKey:runeKey];
    NSString *runeName = NSLocalizedString([rune objectForKey:@"name"],nil);
    UIImage *runeImage = [UIImage imageNamed:[rune objectForKey:@"image"]];
    if ([runeKey isEqualToString:@"."]) {
        runeName = nil;
        runeImage = nil;
    }
    switch (selectedButton.tag) {
        case 660:
            [mouseLeftRuneName setText:runeName];
            [mouseLeftRuneImage setImage:runeImage];
            [runes removeObjectAtIndex:0];
            [runes insertObject:runeKey atIndex:0];
            break;
        case 661:
            [mouseRightRuneName setText:runeName];
            [mouseRightRuneImage setImage:runeImage];
            [runes removeObjectAtIndex:1];
            [runes insertObject:runeKey atIndex:1];
            break;
        case 662:
            [numOneRuneName setText:runeName];
            [numOneRuneImage setImage:runeImage];
            [runes removeObjectAtIndex:2];
            [runes insertObject:runeKey atIndex:2];
            break;
        case 663:
            [numTwoRuneName setText:runeName];
            [numTwoRuneImage setImage:runeImage];
            [runes removeObjectAtIndex:3];
            [runes insertObject:runeKey atIndex:3];
            break;
        case 664:
            [numThreeRuneName setText:runeName];
            [numThreeRuneImage setImage:runeImage];
            [runes removeObjectAtIndex:4];
            [runes insertObject:runeKey atIndex:4];
            break;
        case 665:
            [numFourRuneName setText:runeName];
            [numFourRuneImage setImage:runeImage];
            [runes removeObjectAtIndex:5];
            [runes insertObject:runeKey atIndex:5];
            break;
    }
}

- (void)passiveSkillSelected:(NSString *)heroClasses withPSkillKey:(NSString *)pskillKey withTag:(NSNumber *)tag
{
    AppDelegate *mainDelegate = [[UIApplication sharedApplication] delegate];
    NSDictionary *class = [mainDelegate.heroSkillDataSource objectForKey:heroClasses];
    NSDictionary *type = [class objectForKey:@"Passive"];
    NSDictionary *pskill = [type objectForKey:pskillKey];
    NSString *pskillName = NSLocalizedString([pskill objectForKey:@"name"],nil);
    UIImage *pskillImage = [UIImage imageNamed:[pskill objectForKey:@"image"]];
    UIColor *color = [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:210.0/255.0 alpha:1.0];
    switch (selectedButton.tag) {
        case 880:
            [passiveSkillOneName setTextColor:color];
            [passiveSkillOneName setText:pskillName];
            [passiveSkillOneImage setImage:pskillImage];
            [passive removeObjectAtIndex:0];
            [passive insertObject:pskillKey atIndex:0];
            [tags removeObjectAtIndex:6];
            [tags insertObject:tag atIndex:6];
            break;
        case 881:
            [passiveSkillTwoName setTextColor:color];
            [passiveSkillTwoName setText:pskillName];
            [passiveSkillTwoImage setImage:pskillImage];
            [passive removeObjectAtIndex:1];
            [passive insertObject:pskillKey atIndex:1];
            [tags removeObjectAtIndex:7];
            [tags insertObject:tag atIndex:7];
            break;
        case 882:
            [passiveSkillThreeName setTextColor:color];
            [passiveSkillThreeName setText:pskillName];
            [passiveSkillThreeImage setImage:pskillImage];
            [passive removeObjectAtIndex:2];
            [passive insertObject:pskillKey atIndex:2];
            [tags removeObjectAtIndex:8];
            [tags insertObject:tag atIndex:8];
            break;
    }
}

- (void)setSkillSystemLabel
{
    [mouseLeftSkill setText:[skillSystemNameArray objectAtIndex:15]];
    [mouseRightSkill setText:[skillSystemNameArray objectAtIndex:16]];
    [numOneSkill setText:[skillSystemNameArray objectAtIndex:17]];
    [numTwoSkill setText:[skillSystemNameArray objectAtIndex:heroClass*3]];
    [numThreeSkill setText:[skillSystemNameArray objectAtIndex:(heroClass*3+1)]];
    [numFourSkill setText:[skillSystemNameArray objectAtIndex:(heroClass*3+2)]];
}

- (void)setInitiativeSkillName
{
    UIColor *color = [UIColor colorWithRed:128.0/255.0 green:118.0/255.0 blue:103.0/255.0 alpha:1.0];
    [mouseLeftSkillName setTextColor:color];
    [mouseLeftSkillName setText:@"Choose Skill"];
    [mouseRightSkillName setTextColor:color];
    [mouseRightSkillName setText:@"Choose Skill"];
    [numOneSkillName setTextColor:color];
    [numOneSkillName setText:@"Choose Skill"];
    [numTwoSkillName setTextColor:color];
    [numTwoSkillName setText:@"Choose Skill"];
    [numThreeSkillName setTextColor:color];
    [numThreeSkillName setText:@"Choose Skill"];
    [numFourSkillName setTextColor:color];
    [numFourSkillName setText:@"Choose Skill"];
}

- (void)setRuneName
{
    [mouseLeftRuneName setText:@""];
    [mouseRightRuneName setText:@""];
    [numOneRuneName setText:@""];
    [numTwoRuneName setText:@""];
    [numThreeRuneName setText:@""];
    [numFourRuneName setText:@""];
}

- (void)setPassiveSkillName
{
    UIColor *color = [UIColor colorWithRed:128.0/255.0 green:118.0/255.0 blue:103.0/255.0 alpha:1.0];
    [passiveSkillOneName setTextColor:color];
    [passiveSkillOneName setText:@"Choose Skill"];
    [passiveSkillTwoName setTextColor:color];
    [passiveSkillTwoName setText:@"Choose Skill"];
    [passiveSkillThreeName setTextColor:color];
    [passiveSkillThreeName setText:@"Choose Skill"];
}

- (void)createHeroSkillDetailBoard
{
    switch (heroClass) {
        case 0:
            self.barbarianSkillBoard = [[[BarbarianSkillDetailViewController alloc] initWithNibName:@"BarbarianSkillDetailViewController" bundle:nil] autorelease];
            self.barbarianSkillBoard.view.frame = CGRectMake(0, 110, self.barbarianSkillBoard.view.frame.size.width, self.barbarianSkillBoard.view.frame.size.height);
            self.barbarianSkillBoard.view.tag = 13811150829;
            self.barbarianSkillBoard.heroClassString = @"Barbarian";
            [self.barbarianSkillBoard setDelegate:self];
            [self.barbarianSkillBoard setVisible:NO];
            [[[UIApplication sharedApplication] keyWindow] addSubview:self.barbarianSkillBoard.view];
            currentSkillBoard = self.barbarianSkillBoard;
            [currentSkillBoard setSelectedButtonGroup:pages withTagGroup:tags];
            break;
        case 1:
            self.demonhunterSkillBoard = [[[DemonHunterSkillDetailViewController alloc] initWithNibName:@"DemonHunterSkillDetailViewController" bundle:nil] autorelease];
            self.demonhunterSkillBoard.view.frame = CGRectMake(0, 110, self.demonhunterSkillBoard.view.frame.size.width, self.demonhunterSkillBoard.view.frame.size.height);
            self.demonhunterSkillBoard.view.tag = 13811150829;
            self.demonhunterSkillBoard.heroClassString = @"DemonHunter";
            [self.demonhunterSkillBoard setDelegate:self];
            [self.demonhunterSkillBoard setVisible:NO];
            [[[UIApplication sharedApplication] keyWindow] addSubview:self.demonhunterSkillBoard.view];
            currentSkillBoard = self.demonhunterSkillBoard;
            break;
        case 2:
            self.monkSkillBoard = [[[MonkSkillDetailViewController alloc] initWithNibName:@"MonkSkillDetailViewController" bundle:nil] autorelease];
            self.monkSkillBoard.view.frame = CGRectMake(0, 110, self.monkSkillBoard.view.frame.size.width, self.monkSkillBoard.view.frame.size.height);
            self.monkSkillBoard.view.tag = 13811150829;
            self.monkSkillBoard.heroClassString = @"Monk";
            [self.monkSkillBoard setDelegate:self];
            [self.monkSkillBoard setVisible:NO];
            [[[UIApplication sharedApplication] keyWindow] addSubview:self.monkSkillBoard.view];
            currentSkillBoard = self.monkSkillBoard;
            break;
        case 3:
            self.witchdoctorSkillBoard = [[[WitchDoctorSkillDetailViewController alloc] initWithNibName:@"WitchDoctorSkillDetailViewController" bundle:nil] autorelease];
            self.witchdoctorSkillBoard.view.frame = CGRectMake(0, 110, self.witchdoctorSkillBoard.view.frame.size.width, self.witchdoctorSkillBoard.view.frame.size.height);
            self.witchdoctorSkillBoard.view.tag = 13811150829;
            self.witchdoctorSkillBoard.heroClassString = @"WitchDoctor";
            [self.witchdoctorSkillBoard setDelegate:self];
            [self.witchdoctorSkillBoard setVisible:NO];
            [[[UIApplication sharedApplication] keyWindow] addSubview:self.witchdoctorSkillBoard.view];
            currentSkillBoard = self.witchdoctorSkillBoard;
            break;
        case 4:
            self.wizardSkillBoard = [[[WizardSkillDetailViewController alloc] initWithNibName:@"WizardSkillDetailViewController" bundle:nil] autorelease];
            self.wizardSkillBoard.view.frame = CGRectMake(0, 110, self.wizardSkillBoard.view.frame.size.width, self.wizardSkillBoard.view.frame.size.height);
            self.wizardSkillBoard.view.tag = 13811150829;
            self.wizardSkillBoard.heroClassString = @"Wizard";
            [self.wizardSkillBoard setDelegate:self];
            [self.wizardSkillBoard setVisible:NO];
            [[[UIApplication sharedApplication] keyWindow] addSubview:self.wizardSkillBoard.view];
            currentSkillBoard = self.wizardSkillBoard;
            break;
        default:
            NSLog(@"you got a heroClass num error");
            break;
    }
}

- (void)makeButtonSelected:(UIButton *)button
{
    selectedButton = button;
    [selectedButton setSelected:YES];
}

- (void)makeButtonUnSelected
{
    [selectedButton setSelected:NO];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [heroAvatar setImage:[UIImage imageNamed:[imageNameArray objectAtIndex:(heroClass+5*heroSex)]]];
    [className setText:[classNameArray objectAtIndex:heroClass]];
    [self setSkillSystemLabel];
    [self setInitiativeSkillName];
    [self setRuneName];
    [self setPassiveSkillName];
    [self createHeroSkillDetailBoard];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)bt_initiativeSkillLeftPressed:(UIButton *)sender {
    if (currentSkillBoard.isHeroSkillDetailShown) {
        if ([sender isEqual:selectedButton]) {
            
        }
        else {
            //remove single detail view
            [currentSkillBoard removeDetailViewFromKeyWindow];
            [currentSkillBoard removeHighLightView];
            //if last view is different
            if (selectedButton.tag > 700) {
                //make change
                [currentSkillBoard setSelfViewToInitiative];
                [currentSkillBoard setDefaultPage:[[pages objectAtIndex:(sender.tag%660)] intValue] withSkillKey:[initiative objectAtIndex:(sender.tag%660)] withRuneKey:[runes objectAtIndex:(sender.tag%660)] withButtonIndex:(sender.tag%660) withTag:[[tags objectAtIndex:(sender.tag%660)] intValue]];
            }
            else {
                [currentSkillBoard setDefaultPage:[[pages objectAtIndex:(sender.tag%660)] intValue] withSkillKey:[initiative objectAtIndex:(sender.tag%660)] withRuneKey:[runes objectAtIndex:(sender.tag%660)] withButtonIndex:(sender.tag%660) withTag:[[tags objectAtIndex:(sender.tag%660)] intValue]];
            }
            [self makeButtonUnSelected];
        }
    }
    else {
        [currentSkillBoard removeHighLightView];
        [currentSkillBoard setDefaultPage:[[pages objectAtIndex:(sender.tag%660)] intValue] withSkillKey:[initiative objectAtIndex:(sender.tag%660)] withRuneKey:[runes objectAtIndex:(sender.tag%660)] withButtonIndex:(sender.tag%660) withTag:[[tags objectAtIndex:(sender.tag%660)] intValue]];
        [currentSkillBoard setSelfViewToInitiative];
        [currentSkillBoard moveToRightSide];
    }
    [self makeButtonSelected:sender];
}

- (IBAction)bt_initiativeSkillRightPressed:(UIButton *)sender {
    if (currentSkillBoard.isHeroSkillDetailShown) {
        if ([sender isEqual:selectedButton]) {
            
        }
        else {
            [currentSkillBoard removeDetailViewFromKeyWindow];
            [currentSkillBoard removeHighLightView];
            if (selectedButton.tag > 700) {
                [currentSkillBoard setSelfViewToInitiative];
                [currentSkillBoard setDefaultPage:[[pages objectAtIndex:(sender.tag%660)] intValue] withSkillKey:[initiative objectAtIndex:(sender.tag%660)] withRuneKey:[runes objectAtIndex:(sender.tag%660)] withButtonIndex:(sender.tag%660) withTag:[[tags objectAtIndex:(sender.tag%660)] intValue]];
            }
            else {
                [currentSkillBoard setDefaultPage:[[pages objectAtIndex:(sender.tag%660)] intValue] withSkillKey:[initiative objectAtIndex:(sender.tag%660)] withRuneKey:[runes objectAtIndex:(sender.tag%660)] withButtonIndex:(sender.tag%660) withTag:[[tags objectAtIndex:(sender.tag%660)] intValue]];
            }
            [self makeButtonUnSelected];
        }
    }
    else {
        [currentSkillBoard removeHighLightView];
        [currentSkillBoard setDefaultPage:[[pages objectAtIndex:(sender.tag%660)] intValue] withSkillKey:[initiative objectAtIndex:(sender.tag%660)] withRuneKey:[runes objectAtIndex:(sender.tag%660)] withButtonIndex:(sender.tag%660) withTag:[[tags objectAtIndex:(sender.tag%660)] intValue]];
        [currentSkillBoard setSelfViewToInitiative];
        [currentSkillBoard moveToLeftSide];
    }
    [self makeButtonSelected:sender];
}

- (IBAction)bt_passiveSkillPressed:(UIButton *)sender {    
    if(currentSkillBoard.isHeroSkillDetailShown)
    {
        if ([sender isEqual:selectedButton]) {
            
        }
        else {
            [currentSkillBoard removeDetailViewFromKeyWindow];
            [currentSkillBoard removeHighLightView];
            if (selectedButton.tag < 700) {
                [currentSkillBoard setSelfViewToPassive];
                [currentSkillBoard setPassiveBoard:[passive objectAtIndex:(sender.tag%880)] withButtonIndex:(sender.tag%880) withTag:[[tags objectAtIndex:(6 + (sender.tag%880))] intValue]];
            }
            else {
                [currentSkillBoard setPassiveBoard:[passive objectAtIndex:(sender.tag%880)] withButtonIndex:(sender.tag%880) withTag:[[tags objectAtIndex:(6 + (sender.tag%880))] intValue]];
            }
            [self makeButtonUnSelected];
        }
    }
    else {
        [currentSkillBoard removeHighLightView];
        [currentSkillBoard setPassiveBoard:[passive objectAtIndex:(sender.tag%880)] withButtonIndex:(sender.tag%880) withTag:[[tags objectAtIndex:(6 + (sender.tag%880))] intValue]];
        [currentSkillBoard setSelfViewToPassive];
        [currentSkillBoard moveToRightSide];
    }
    [self makeButtonSelected:sender];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    
    if ([touch view] != heroAvatar) {
        if (currentSkillBoard.isHeroSkillDetailShown) {
            [currentSkillBoard restoreViewLocation];
        }
    }
}

@end
