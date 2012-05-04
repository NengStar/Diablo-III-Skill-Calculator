//
//  HeroSkillDetailViewController.m
//  DiabloIIIHerosHall
//
//  Created by  on 12-5-2.
//  Copyright (c) 2012年 Neng! Star. All rights reserved.
//

#import "BarbarianSkillDetailViewController.h"

@implementation BarbarianSkillDetailViewController

@synthesize initiative,passive;
@synthesize primary,secondary,defensive,might,tactics,rage;
@synthesize runeTips,runeTable,skillScroll,skillPage;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [initiative release];
    [passive release];
//    [detail release];
    
    [primary release];
    [secondary release];
    [defensive release];
    [might release];
    [tactics release];
    [rage release];
    
    [runeTips release];
    [runeTable release];
    [skillPage release];
    [skillScroll release];
    [super dealloc];
}

- (void)setSkillTableVisible:(BOOL)visible
{
    [runeTips setHidden:visible];
    [runeTable setHidden:!visible];
}

- (void)setSelfViewToPassive
{
    initiative.hidden = YES;
    passive.hidden = NO;
    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, passive.frame.size.width, 270);
    self.view = passive;
    [super setSelfViewToPassive];
}

- (void)setSelfViewToInitiative
{
    initiative.hidden = NO;
    passive.hidden = YES;
    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, initiative.frame.size.width, 370);
    self.view = initiative;
    [super setSelfViewToInitiative];
}

- (void)addSkillViewToScroll
{
    CGRect bounds = skillScroll.frame;
    
    primary.frame = CGRectMake(bounds.size.width*primary.tag, 0, bounds.size.width, bounds.size.height);
    secondary.frame = CGRectMake(bounds.size.width*secondary.tag, 0, bounds.size.width, bounds.size.height);
    defensive.frame = CGRectMake(bounds.size.width*defensive.tag, 0, bounds.size.width, bounds.size.height);
    might.frame = CGRectMake(bounds.size.width*might.tag, 0, bounds.size.width, bounds.size.height);
    tactics.frame = CGRectMake(bounds.size.width*tactics.tag, 0, bounds.size.width, bounds.size.height);
    rage.frame = CGRectMake(bounds.size.width*rage.tag, 0, bounds.size.width, bounds.size.height);
    
    [skillScroll addSubview:primary];
    [skillScroll addSubview:secondary];
    [skillScroll addSubview:defensive];
    [skillScroll addSubview:might];
    [skillScroll addSubview:tactics];
    [skillScroll addSubview:rage];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [skillScroll setContentSize:CGSizeMake(skillScroll.frame.size.width*6, skillScroll.frame.size.height)];
    [self addSkillViewToScroll];
    [self setSkillTableVisible:NO];
    lastPage = skillPage.currentPage;
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

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int page = scrollView.contentOffset.x/scrollView.frame.size.width;
    skillPage.currentPage = page;
    if (lastPage!=skillPage.currentPage) {
        lastPage = skillPage.currentPage;
        [self removeDetailViewFromKeyWindow];
        if (skillSelectedPage == skillPage.currentPage) {
            // do -> skilltable load data
            [self setSkillTableVisible:YES];
        }
        else {
            [self setSkillTableVisible:NO];
        }
    }
}

- (IBAction)skillButtonPressed:(UIButton *)sender {
    if ([selectedSkillButton isEqual:sender]) {

    }
    else {
        [selectedSkillButton setSelected:NO];
        selectedSkillButton = sender;
        [selectedSkillButton setSelected:YES];
    }
    skillSelectedPage = skillPage.currentPage;
    [self addDetailViewToKeyWindow];
    // do -> skilltable load data
    [self setSkillTableVisible:YES];
}
@end
