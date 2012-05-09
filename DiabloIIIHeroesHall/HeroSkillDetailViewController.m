//
//  HeroSkillDetailViewController.m
//  DiabloIIIHerosHall
//
//  Created by  on 12-5-2.
//  Copyright (c) 2012年 Neng! Star. All rights reserved.
//

#import "HeroSkillDetailViewController.h"

@implementation HeroSkillDetailViewController
@synthesize lastPage,skillSelectedPage,runeSelectedIndex,heroClassString,skillButtonGroupIndex,skillButtonGroupTag,pskillButtonGroupIndex,pskillButtonGroupTag;
//@synthesize selectSkillButtonGroup,selectPSkillButtonGroup;
@synthesize isHeroSkillDetailShown;
@synthesize delegate;
@synthesize singleSkillDetailViewController = _singleSkillDetailViewController;

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
    [_singleSkillDetailViewController release];
    [heroClassString release];
//    [skillScroll release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)setVisible:(BOOL)visible
{
    self.view.hidden = !visible;
    isHeroSkillDetailShown = visible;
}


- (void)setSelfViewToPassive
{
    
}

- (void)setSelfViewToInitiative
{
    
}

- (void)setDefaultCell:(NSInteger)index
{
    
}

- (void)setDefaultPage:(NSInteger)page withSkillKey:(NSString *)skillKey withRuneKey:(NSString *)runeKey withButtonIndex:(NSInteger)index withTag:(NSInteger)tag
{

}

- (void)setPassiveBoard:(NSString *)pskillKey withButtonIndex:(NSInteger)index withTag:(NSInteger)tag
{

}

- (void)setSelectedButtonGroup:(NSMutableArray *)viewPage withTagGroup:(NSMutableArray *)tagGroup
{
    
}

- (void)addDetailViewToKeyWindow:(NSString *)heroClass skillType:(NSString *)skillType skillKey:(NSString *)skillKey hasStory:(BOOL)hasStory
{
    if (self.singleSkillDetailViewController.isSingleSkillDetailShown) {
        [self.singleSkillDetailViewController.view removeFromSuperview];
        self.singleSkillDetailViewController.isSingleSkillDetailShown = NO;
        [self addDetailViewToKeyWindow:heroClass skillType:skillType skillKey:skillKey hasStory:hasStory];
    }
    else {
        self.singleSkillDetailViewController = [[[SingleSkillDetailViewController alloc] init] autorelease];
        self.singleSkillDetailViewController.heroClass = heroClass;
        self.singleSkillDetailViewController.skillType = skillType;
        self.singleSkillDetailViewController.skillKey = skillKey;
        self.singleSkillDetailViewController.hasStory = hasStory;
        self.view.center.x<160?
        [self.singleSkillDetailViewController.view setFrame:CGRectMake(149, 100, self.singleSkillDetailViewController.view.frame.size.width, self.singleSkillDetailViewController.view.frame.size.height)]:
        [self.singleSkillDetailViewController.view setFrame:CGRectMake(11, 100, self.singleSkillDetailViewController.view.frame.size.width, self.singleSkillDetailViewController.view.frame.size.height)];
        [[[UIApplication sharedApplication] keyWindow] addSubview:self.singleSkillDetailViewController.view];
        self.singleSkillDetailViewController.isSingleSkillDetailShown = YES;
    }
}

- (void)removeDetailViewFromKeyWindow
{
    if (self.singleSkillDetailViewController.isSingleSkillDetailShown) {
        [self.singleSkillDetailViewController.view removeFromSuperview];
        self.singleSkillDetailViewController.isSingleSkillDetailShown = NO;
    }
}

//- (void)setDetailViewShown:(BOOL)shown
//{
//
//}

#pragma mark -
#pragma mark Other methods

// restore view location
- (void)restoreViewLocation {
//    [self setDetailViewShown:NO];
    [self removeDetailViewFromKeyWindow];
    [UIView animateWithDuration:0.3 
                     animations:^{
                         if (self.view.center.x<160.0f) {
                             self.view.frame = CGRectMake(0.0f - self.view.frame.size.width, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
                         }
                         else {
                             self.view.frame = CGRectMake(320.0f, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
                         }
                     } 
                     completion:^(BOOL finished){
                         //设置非绘制区域是否响应时间，否则点击重置绘制区域
                         //UIControl *overView = (UIControl *)[[[UIApplication sharedApplication] keyWindow] viewWithTag:9618088];
                         //[overView removeFromSuperview];
                         [self removeHighLightView];
                         [self setVisible:NO];
                         [delegate skillBoardDidFinishClosing];
                     }];
}

// move view to left side
- (void)moveToLeftSide {
    self.view.frame = CGRectMake(0.0f - self.view.frame.size.width, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
    [self animateHomeViewToSide:CGRectMake(0.0f, 
                                           self.view.frame.origin.y, 
                                           self.view.frame.size.width, 
                                           self.view.frame.size.height)];
}

// move view to right side
- (void)moveToRightSide {
    self.view.frame = CGRectMake(320.0f, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
    [self animateHomeViewToSide:CGRectMake(160.0f, 
                                           self.view.frame.origin.y, 
                                           self.view.frame.size.width, 
                                           self.view.frame.size.height)];
}

// animate home view to side rect
- (void)animateHomeViewToSide:(CGRect)newViewRect {
    [self setVisible:YES];
    [UIView animateWithDuration:0.2 
                     animations:^{
                         self.view.frame = newViewRect;
                     } 
                     completion:^(BOOL finished){
                         //设置非绘制区域是否响应时间，否则点击重置绘制区域
                         //UIControl *overView = [[UIControl alloc] init];
                         //overView.tag = 9618088;
                         //overView.backgroundColor = [UIColor clearColor];
                         //if (self.view.center.x<160.0f) {
                         //    overView.frame = CGRectMake(self.view.frame.size.width, self.view.frame.origin.y, 320.0f - self.view.frame.size.width, self.view.frame.size.height);
                         //}
                         //else {
                         //    overView.frame = CGRectMake(0.0f, self.view.frame.origin.y, 320.0f - self.view.frame.size.width, self.view.frame.size.height);
                         //}
                         //[overView addTarget:self action:@selector(restoreViewLocation) forControlEvents:UIControlEventTouchDown];
                         //[[[UIApplication sharedApplication] keyWindow] addSubview:overView];
                         //[overView release];
                     }];
}

- (void)removeHighLightView
{
    UIImageView *highlight = (UIImageView *)[selectedSkillButton viewWithTag:200809];
    if(highlight){
        [highlight removeFromSuperview];
    }
    UIImageView *highround = (UIImageView *)[selectedPSkillButton viewWithTag:908002];
    if (highround) {
        [highround removeFromSuperview];
    }
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
