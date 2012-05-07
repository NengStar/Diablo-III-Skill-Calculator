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
    int page = skillScroll.contentOffset.x/skillScroll.frame.size.width;
    skillPage.currentPage = page;
    if (lastPage!=skillPage.currentPage) {
        lastPage = skillPage.currentPage;
        [self removeDetailViewFromKeyWindow];
        if (skillSelectedPage == skillPage.currentPage) {
            // do -> skilltable load data

            //[runeTable reloadData];
            [self setDefaultCell:runeSelectedIndex];
            [self setSkillTableVisible:YES];
        }
        else {
            [self setSkillTableVisible:NO];
        }
    }
}

- (void)setDefaultCell:(NSInteger)index
{  
    NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:index inSection:0];
    
    [runeTable selectRowAtIndexPath:selectedIndexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
    runeSelectedIndex = index;
}

- (IBAction)skillButtonPressed:(UIButton *)sender {
    if ([selectedSkillButton isEqual:sender]) {

    }
    else {
        [selectedSkillButton setSelected:NO];
        selectedSkillButton = sender;
        [selectedSkillButton setSelected:YES];
        selectedSkillKey = selectedSkillButton.titleLabel.text;
        skillSelectedPage = skillPage.currentPage;
        [runeTable reloadData];
        [self setDefaultCell:0];
        [self setSkillTableVisible:YES];
    }
    [self addDetailViewToKeyWindow:@"Initiative" skillKey:selectedSkillKey];
}

- (IBAction)pskillButtonPressed:(UIButton *)sender {
    if ([selectedPSkillButton isEqual:sender]) {
        
    }
    else {
        [selectedPSkillButton setEnabled:YES];
        selectedPSkillButton = sender;
        [selectedPSkillButton setEnabled:NO];
        selectedPSkillKey = selectedPSkillButton.titleLabel.text;
    }
    [self addDetailViewToKeyWindow:@"Passive" skillKey:selectedPSkillKey];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    runeSelectedIndex = [indexPath row];
    NSLog(@"...........");
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"enter height");
    NSArray *runeList = [NSArray arrayWithObjects:@".",@"a",@"Z",@"b",@"Y",@"c",nil];
    AppDelegate *mainDelegate = [[UIApplication sharedApplication] delegate];
    NSDictionary *heroClass = [mainDelegate.heroSkillDataSource objectForKey:@"Barbarian"];
    NSDictionary *skillType = [heroClass objectForKey:@"Initiative"];
    NSDictionary *skill = [skillType objectForKey:selectedSkillKey];
    NSDictionary *rune = [[skill objectForKey:@"runes"] objectForKey:[runeList objectAtIndex:[indexPath row]]];
    NSString *name = NSLocalizedString([rune objectForKey:@"name"], nil); 
    
    NSString *detail = NSLocalizedString([rune objectForKey:@"detail"], nil);
    
    
    CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
    
    CGSize sizeName = [name sizeWithFont:[UIFont fontWithName:@"American Typewriter" size:NAME_FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    
    CGSize sizeDetail = [detail sizeWithFont:[UIFont systemFontOfSize:DETAIL_FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    
    CGFloat height = (sizeName.height+sizeDetail.height+CELL_CONTENT_MARGIN);
    
    return height + (CELL_CONTENT_MARGIN * 2);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UILabel *lb_name = nil;
    UILabel *lb_detail = nil;
    UIImageView *img_rune = nil;
    NSArray *runeList = [NSArray arrayWithObjects:@".",@"a",@"Z",@"b",@"Y",@"c",nil];
    NSString *CellIdentifier = [runeList objectAtIndex:[indexPath row]];
    UIImage *mash_area = [[UIImage imageNamed:@"mash_selected_area"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    UIImageView *mash_view = [[[UIImageView alloc] initWithImage:mash_area] autorelease];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        [cell setFrame:CGRectZero];
        [cell setBackgroundColor:[UIColor clearColor]];
        [cell setSelectedBackgroundView:mash_view];
        
        lb_name = [[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
        [lb_name setLineBreakMode:UILineBreakModeWordWrap];
        [lb_name setBackgroundColor:[UIColor clearColor]];
        [lb_name setTextColor:[UIColor colorWithRed:110.0/255.0 green:0.0 blue:0.0 alpha:1.0]];
        [lb_name setMinimumFontSize:NAME_FONT_SIZE];
        [lb_name setNumberOfLines:0];
        [lb_name setFont:[UIFont fontWithName:@"American Typewriter" size:NAME_FONT_SIZE]];
        [lb_name setTag:1];
        
        lb_detail = [[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
        [lb_detail setLineBreakMode:UILineBreakModeWordWrap];
        [lb_detail setBackgroundColor:[UIColor clearColor]];
        [lb_detail setMinimumFontSize:DETAIL_FONT_SIZE];
        [lb_detail setNumberOfLines:0];
        [lb_detail setFont:[UIFont systemFontOfSize:DETAIL_FONT_SIZE]];
        [lb_detail setTag:2];
        
        img_rune = [[[UIImageView alloc] initWithFrame:CGRectZero] autorelease];
        [img_rune setBackgroundColor:[UIColor clearColor]];
        [img_rune setOpaque:NO];
        [img_rune setTag:3];
        
        [[cell contentView] addSubview:lb_name];
        [[cell contentView] addSubview:lb_detail];
        [[cell contentView] addSubview:img_rune];
        
    }
    
    AppDelegate *mainDelegate = [[UIApplication sharedApplication] delegate];
    NSDictionary *heroClass = [mainDelegate.heroSkillDataSource objectForKey:@"Barbarian"];
    NSDictionary *skillType = [heroClass objectForKey:@"Initiative"];
    NSDictionary *skill = [skillType objectForKey:selectedSkillKey];
    NSDictionary *rune = [[skill objectForKey:@"runes"] objectForKey:[runeList objectAtIndex:[indexPath row]]];
    NSString *name = NSLocalizedString([rune objectForKey:@"name"], nil); 
    
    NSString *detail = NSLocalizedString([rune objectForKey:@"detail"], nil);
    
    NSString *image = [rune objectForKey:@"image"];
    
    
    CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
    
    CGSize sizeName = [name sizeWithFont:[UIFont fontWithName:@"American Typewriter" size:NAME_FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    
    CGSize sizeDetail = [detail sizeWithFont:[UIFont systemFontOfSize:DETAIL_FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    
    if (lb_name == nil)
    {
        lb_name = (UILabel*)[cell viewWithTag:1];
    }
    [lb_name setText:name];
    [lb_name setFrame:CGRectMake(CELL_CONTENT_MARGIN, CELL_CONTENT_MARGIN, CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), sizeName.height)];
    if (lb_detail == nil)
    {
        lb_detail = (UILabel*)[cell viewWithTag:2];
    }
    [lb_detail setText:detail];
    [lb_detail setFrame:CGRectMake(CELL_CONTENT_MARGIN, CELL_CONTENT_MARGIN*2+sizeName.height, CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), sizeDetail.height)];
    if (img_rune == nil) {
        img_rune = (UIImageView *)[cell viewWithTag:3];
    }
    [img_rune setImage:[UIImage imageNamed:image]];
    [img_rune setFrame:CGRectMake(CELL_CONTENT_WIDTH - CELL_CONTENT_MARGIN - RUNE_IMAGE_WIDTH, CELL_CONTENT_MARGIN*2, RUNE_IMAGE_WIDTH, RUNE_IMAGE_HEIGHT)];
    
    return cell;
}
@end