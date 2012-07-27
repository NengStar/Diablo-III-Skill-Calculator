//
//  HeroSkillDetailViewController.m
//  DiabloIIIHerosHall
//
//  Created by  on 12-5-2.
//  Copyright (c) 2012年 Neng! Star. All rights reserved.
//

#import "WizardSkillDetailViewController.h"

@implementation WizardSkillDetailViewController
@synthesize initiative,passive;
@synthesize primary,secondary,defensive,force,conjuration,mastery;
@synthesize runeTips,runeTable,skillScroll,skillPage,numOfSlot;
//@synthesize runeList;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        UIButton *button = [[[UIButton alloc] init] autorelease];
        button.tag = -1;
        selectSkillButtonGroup = [[NSMutableArray alloc] initWithObjects:button,button,button,button,button,button, nil];
        selectPSkillButtonGroup = [[NSMutableArray alloc] initWithObjects:button,button,button, nil];
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
    [force release];
    [conjuration release];
    [mastery release];
    
    [runeTips release];
    [runeTable release];
    [skillPage release];
    [skillScroll release];
    [numOfSlot release];
    
    [selectSkillButtonGroup release];
    [selectPSkillButtonGroup release];
    
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
}

- (void)setSelfViewToInitiative
{
    initiative.hidden = NO;
    passive.hidden = YES;
    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, initiative.frame.size.width, 370);
    self.view = initiative;
}

- (void)addSkillViewToScroll
{
    CGRect bounds = skillScroll.frame;
    
    primary.frame = CGRectMake(bounds.size.width*primary.tag, 0, bounds.size.width, bounds.size.height);
    secondary.frame = CGRectMake(bounds.size.width*secondary.tag, 0, bounds.size.width, bounds.size.height);
    defensive.frame = CGRectMake(bounds.size.width*defensive.tag, 0, bounds.size.width, bounds.size.height);
    force.frame = CGRectMake(bounds.size.width*force.tag, 0, bounds.size.width, bounds.size.height);
    conjuration.frame = CGRectMake(bounds.size.width*conjuration.tag, 0, bounds.size.width, bounds.size.height);
    mastery.frame = CGRectMake(bounds.size.width*mastery.tag, 0, bounds.size.width, bounds.size.height);
    
    [skillScroll addSubview:primary];
    [skillScroll addSubview:secondary];
    [skillScroll addSubview:defensive];
    [skillScroll addSubview:force];
    [skillScroll addSubview:conjuration];
    [skillScroll addSubview:mastery];
}

- (void)setSelectedButtonGroup:(NSMutableArray *)viewPage withTagGroup:(NSMutableArray *)tagGroup
{
    for (int i=0; i<[viewPage count]; i++) {
        int viewTag = [[viewPage objectAtIndex:i] intValue];
        UIButton *button = (UIButton *)[[self.skillScroll viewWithTag:viewTag] viewWithTag:[[tagGroup objectAtIndex:i] intValue]];
        if (button) {
            [button setSelected:YES];
            [selectSkillButtonGroup removeObjectAtIndex:i];
            [selectSkillButtonGroup insertObject:button atIndex:i];
        }
    }
    for (int i=6; i<9; i++) {
        UIButton *button = (UIButton *)[self.passive viewWithTag:[[tagGroup objectAtIndex:i] intValue]];
        if (button) {
            [button setSelected:YES];
            [selectPSkillButtonGroup removeObjectAtIndex:i-6];
            [selectPSkillButtonGroup insertObject:button atIndex:i-6];
        }
    }
    [self setSkillTableVisible:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //    runeSelectedIndex = 0;
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
    //    NSLog(@"in scroll end\n");
    if ([scrollView isEqual:skillScroll]) {
        int page = skillScroll.contentOffset.x/skillScroll.frame.size.width;
        skillPage.currentPage = page;
        //        NSLog(@"in compare");
        if (lastPage!=skillPage.currentPage) {
            lastPage = skillPage.currentPage;
            [self removeDetailViewFromKeyWindow];
            //            NSLog(@"selectpage in scroll end     %d\n current page     %d\n",skillSelectedPage,skillPage.currentPage);
            if (skillSelectedPage == skillPage.currentPage&&selectedSkillButton.tag == skillButtonGroupTag) {
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
}

- (void)setDefaultCell:(NSInteger)index
{  
    NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:index inSection:0];
    [runeTable selectRowAtIndexPath:selectedIndexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
}

- (void)setDefaultPage:(NSInteger)page withSkillKey:(NSString *)skillKey withRuneKey:(NSString *)runeKey withButtonIndex:(NSInteger)index withTag:(NSInteger)tag
{
    skillSelectedPage = page;
    [skillScroll setContentOffset:CGPointMake(skillSelectedPage*skillScroll.frame.size.width, 0)];
    skillPage.currentPage = skillSelectedPage;
    lastPage = skillPage.currentPage;
    skillButtonGroupIndex = index;
    skillButtonGroupTag = tag;
    if ([skillKey isEqualToString:@"."]) {
        selectedSkillKey = skillKey;
        [self setSkillTableVisible:NO];
    }
    else {
        NSArray *runeList = [NSArray arrayWithObjects:@".",@"a",@"Z",@"b",@"Y",@"c",nil];
        for (int i=0; i<[runeList count]; i++) {
            if ([runeKey isEqualToString:[runeList objectAtIndex:i]]) {
                runeSelectedIndex = i;
                break;
            }
        }
        selectedRuneKey = runeKey;
        [self removeHighLightView];
        UIImageView *highlight = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"skillrect_highlight"]];
        highlight.tag = 200809;
        highlight.frame = CGRectMake(0, 0, 25, 25);
        selectedSkillButton = (UIButton *)[selectSkillButtonGroup objectAtIndex:skillButtonGroupIndex];
        selectedSkillKey = skillKey;
        [selectedSkillButton addSubview:highlight];
        [highlight release];
        [runeTable reloadData];
        [self setDefaultCell:runeSelectedIndex];
        [self setSkillTableVisible:YES];
    }
}

- (void)setPassiveBoard:(NSString *)pskillKey withButtonIndex:(NSInteger)index withTag:(NSInteger)tag
{
    selectedPSkillKey = pskillKey;
    pskillButtonGroupIndex = index;
    pskillButtonGroupTag = tag;
    
    [self removeHighLightView];
    UIImageView *highlight = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"skillround_highlight"]];
    highlight.tag = 908002;
    highlight.frame = CGRectMake(0, 0, 35, 35);
    selectedPSkillButton = (UIButton *)[selectPSkillButtonGroup objectAtIndex:pskillButtonGroupIndex];
    [selectedPSkillButton addSubview:highlight];
    [highlight release];
}

- (IBAction)skillButtonPressed:(UIButton *)sender {
    NSString *selectSkillDetailKey;
    if ([selectedSkillButton isEqual:sender]) {
        [self setDefaultCell:runeSelectedIndex];
        [self setSkillTableVisible:YES];
    }
    else {
        BOOL select = YES;
        for (int i=0; i<[selectSkillButtonGroup count]; i++) {
            UIButton *button = (UIButton *)[selectSkillButtonGroup objectAtIndex:i];
            if (sender.tag == button.tag) {
                select = NO;
                break;
            }
        }
        if (select) {
            selectedSkillButton = (UIButton *)[selectSkillButtonGroup objectAtIndex:skillButtonGroupIndex];
            [selectedSkillButton setSelected:NO];
            [self removeHighLightView];
            [selectSkillButtonGroup removeObjectAtIndex:skillButtonGroupIndex];
            UIImageView *highlight = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"skillrect_highlight"]];
            highlight.tag = 200809;
            highlight.frame = CGRectMake(0, 0, 25, 25);
            selectedSkillButton = sender;
            [selectedSkillButton setSelected:YES];
            [selectedSkillButton addSubview:highlight];
            [highlight release];
            [selectSkillButtonGroup insertObject:selectedSkillButton atIndex:skillButtonGroupIndex];
            selectedSkillKey = selectedSkillButton.titleLabel.text;
            skillButtonGroupTag = selectedSkillButton.tag;
            skillSelectedPage = skillPage.currentPage;
            //            NSLog(@"selectpage in button pressed     %d\n",skillSelectedPage);
            runeSelectedIndex = 0;
            [runeTable reloadData];
            [self setDefaultCell:runeSelectedIndex];
            [self setSkillTableVisible:YES];
            [delegate initiativeSkillSelected:heroClassString withSkillKey:selectedSkillKey withPage:[NSNumber numberWithInt:skillSelectedPage] withTag:[NSNumber numberWithInt:sender.tag]];
            NSArray *runeList = [NSArray arrayWithObjects:@".",@"a",@"Z",@"b",@"Y",@"c",nil];
            selectedRuneKey = [runeList objectAtIndex:runeSelectedIndex];
            [delegate runeSelected:heroClassString withSkillKey:selectedSkillKey withRuneKey:selectedRuneKey];
        }
        else {
            [self setSkillTableVisible:NO];
        }
    }
    selectSkillDetailKey = sender.titleLabel.text;
    [self addDetailViewToKeyWindow:heroClassString skillType:@"Initiative" skillKey:selectSkillDetailKey hasStory:NO];
}

- (IBAction)pskillButtonPressed:(UIButton *)sender {
    NSString *selectPSkillDetailKey;
    if ([selectedPSkillButton isEqual:sender]) {
        
    }
    else {
        BOOL select = YES;
        for (int i=0; i<[selectPSkillButtonGroup count]; i++) {
            UIButton *button = (UIButton *)[selectPSkillButtonGroup objectAtIndex:i];
            if (sender.tag == button.tag) {
                select = NO;
                break;
            }
        }
        if (select) {
            selectedPSkillButton = (UIButton *)[selectPSkillButtonGroup objectAtIndex:pskillButtonGroupIndex];
            [selectedPSkillButton setSelected:NO];
            [self removeHighLightView];
            [selectPSkillButtonGroup removeObjectAtIndex:pskillButtonGroupIndex];
            UIImageView *highlight = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"skillround_highlight"]];
            highlight.tag = 908002;
            highlight.frame = CGRectMake(0, 0, 35, 35);
            selectedPSkillButton = sender;
            [selectedPSkillButton setSelected:YES];
            [selectedPSkillButton addSubview:highlight];
            [highlight release];
            [selectPSkillButtonGroup insertObject:selectedPSkillButton atIndex:pskillButtonGroupIndex];
            selectedPSkillKey = selectedPSkillButton.titleLabel.text;
            [delegate passiveSkillSelected:heroClassString withPSkillKey:selectedPSkillKey withTag:[NSNumber numberWithInt:sender.tag]];
            NSInteger num = 0;
            for (int i=0; i<[selectPSkillButtonGroup count]; i++) {
                UIButton *button = (UIButton *)[selectPSkillButtonGroup objectAtIndex:i];
                if (button.tag!=-1) {
                    num++;
                }
            }
            [numOfSlot setText:[NSString stringWithFormat:@"%d",num]];
        }
    }
    selectPSkillDetailKey = sender.titleLabel.text;
    [self addDetailViewToKeyWindow:heroClassString skillType:@"Passive" skillKey:selectPSkillDetailKey hasStory:YES];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *runeList = [NSArray arrayWithObjects:@".",@"a",@"Z",@"b",@"Y",@"c",nil];
    runeSelectedIndex = [indexPath row];
    selectedRuneKey = [runeList objectAtIndex:runeSelectedIndex];
    [delegate runeSelected:heroClassString withSkillKey:selectedSkillKey withRuneKey:selectedRuneKey];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *runeList = [NSArray arrayWithObjects:@".",@"a",@"Z",@"b",@"Y",@"c",nil];
    AppDelegate *mainDelegate = [[UIApplication sharedApplication] delegate];
    NSDictionary *heroClass = [mainDelegate.heroSkillDataSource objectForKey:heroClassString];
    NSDictionary *skillType = [heroClass objectForKey:@"Initiative"];
    NSDictionary *skill = [skillType objectForKey:selectedSkillKey];
    NSDictionary *rune = [[skill objectForKey:@"runes"] objectForKey:[runeList objectAtIndex:[indexPath row]]];
    NSString *name = NSLocalizedString([rune objectForKey:@"name"], nil); 
    
    NSString *detail = NSLocalizedString([rune objectForKey:@"detail"], nil);
    
    
    CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), MAXFLOAT);
    
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
    
    NSArray *runeList = [NSArray arrayWithObjects:@".",@"a",@"Z",@"b",@"Y",@"c",nil];
    UILabel *lb_name = nil;
    UILabel *lb_detail = nil;
    UIImageView *img_rune = nil;
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
    NSDictionary *heroClass = [mainDelegate.heroSkillDataSource objectForKey:@"Wizard"];
    NSDictionary *skillType = [heroClass objectForKey:@"Initiative"];
    NSDictionary *skill = [skillType objectForKey:selectedSkillKey];
    NSDictionary *rune = [[skill objectForKey:@"runes"] objectForKey:[runeList objectAtIndex:[indexPath row]]];
    NSString *name = NSLocalizedString([rune objectForKey:@"name"], nil); 
    
    NSString *detail = NSLocalizedString([rune objectForKey:@"detail"], nil);
    
    CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), MAXFLOAT);
    
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
    [img_rune setImage:[UIImage imageNamed:[rune objectForKey:@"image"]]];
    [img_rune setFrame:CGRectMake(CELL_CONTENT_WIDTH - CELL_CONTENT_MARGIN - RUNE_IMAGE_SIZE, CELL_CONTENT_MARGIN*2, RUNE_IMAGE_SIZE, RUNE_IMAGE_SIZE)];
    
    return cell;
}
@end