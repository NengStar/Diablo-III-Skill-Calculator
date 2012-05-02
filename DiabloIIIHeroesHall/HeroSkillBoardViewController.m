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
    }
    return self;
}

- (void)dealloc
{
    [heroAvatar release];
    [className release];
    [imageNameArray release];
    [classNameArray release];
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
    if (viewControllerWillTerminate) {
        [[[[UIApplication sharedApplication] keyWindow] viewWithTag:13811150829] removeFromSuperview];
        [self.navigationController popViewControllerAnimatedWithTransition:UIViewAnimationTransitionCurlDown];
    }
}

- (void)createHeroSkillDetailBoard
{
    switch (heroClass) {
        case 0:
            self.barbarianSkillBoard = [[[BarbarianSkillDetailViewController alloc] initWithNibName:@"BarbarianSkillDetailViewController" bundle:nil] autorelease];
            self.barbarianSkillBoard.view.frame = CGRectMake(0, 110, self.barbarianSkillBoard.view.frame.size.width, self.barbarianSkillBoard.view.frame.size.height);
            self.barbarianSkillBoard.view.tag = 13811150829;
            [self.barbarianSkillBoard setDelegate:self];
            [self.barbarianSkillBoard setVisible:NO];
            [[[UIApplication sharedApplication] keyWindow] addSubview:self.barbarianSkillBoard.view];
            currentSkillBoard = self.barbarianSkillBoard;
            break;
        case 1:
            self.demonhunterSkillBoard = [[[DemonHunterSkillDetailViewController alloc] initWithNibName:@"DemonHunterSkillDetailViewController" bundle:nil] autorelease];
            self.demonhunterSkillBoard.view.frame = CGRectMake(0, 110, self.demonhunterSkillBoard.view.frame.size.width, self.demonhunterSkillBoard.view.frame.size.height);
            self.demonhunterSkillBoard.view.tag = 13811150829;
            [self.demonhunterSkillBoard setDelegate:self];
            [self.demonhunterSkillBoard setVisible:NO];
            [[[UIApplication sharedApplication] keyWindow] addSubview:self.demonhunterSkillBoard.view];
            currentSkillBoard = self.demonhunterSkillBoard;
            break;
        case 2:
            self.monkSkillBoard = [[[MonkSkillDetailViewController alloc] initWithNibName:@"MonkSkillDetailViewController" bundle:nil] autorelease];
            self.monkSkillBoard.view.frame = CGRectMake(0, 110, self.monkSkillBoard.view.frame.size.width, self.monkSkillBoard.view.frame.size.height);
            self.monkSkillBoard.view.tag = 13811150829;
            [self.monkSkillBoard setDelegate:self];
            [self.monkSkillBoard setVisible:NO];
            [[[UIApplication sharedApplication] keyWindow] addSubview:self.monkSkillBoard.view];
            currentSkillBoard = self.monkSkillBoard;
            break;
        case 3:
            self.witchdoctorSkillBoard = [[[WitchDoctorSkillDetailViewController alloc] initWithNibName:@"WitchDoctorSkillDetailViewController" bundle:nil] autorelease];
            self.witchdoctorSkillBoard.view.frame = CGRectMake(0, 110, self.witchdoctorSkillBoard.view.frame.size.width, self.witchdoctorSkillBoard.view.frame.size.height);
            self.witchdoctorSkillBoard.view.tag = 13811150829;
            [self.witchdoctorSkillBoard setDelegate:self];
            [self.witchdoctorSkillBoard setVisible:NO];
            [[[UIApplication sharedApplication] keyWindow] addSubview:self.witchdoctorSkillBoard.view];
            currentSkillBoard = self.witchdoctorSkillBoard;
            break;
        case 4:
            self.wizardSkillBoard = [[[WizardSkillDetailViewController alloc] initWithNibName:@"WizardSkillDetailViewController" bundle:nil] autorelease];
            self.wizardSkillBoard.view.frame = CGRectMake(0, 110, self.wizardSkillBoard.view.frame.size.width, self.wizardSkillBoard.view.frame.size.height);
            self.wizardSkillBoard.view.tag = 13811150829;
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


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [heroAvatar setImage:[UIImage imageNamed:[imageNameArray objectAtIndex:(heroClass+5*heroSex)]]];
    [className setText:[classNameArray objectAtIndex:heroClass]];
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

- (IBAction)bt_mouseLeftPressed:(UIButton *)sender {
    [currentSkillBoard moveToRightSide];
}

- (IBAction)bt_mouseRightPressed:(UIButton *)sender {
    [currentSkillBoard moveToLeftSide];
}
@end
