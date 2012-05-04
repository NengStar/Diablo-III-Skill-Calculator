//
//  HeroSkillDetailViewController.m
//  DiabloIIIHerosHall
//
//  Created by  on 12-5-2.
//  Copyright (c) 2012年 Neng! Star. All rights reserved.
//

#import "HeroSkillDetailViewController.h"

@implementation HeroSkillDetailViewController
@synthesize lastPage,skillSelectedPage;
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

- (void)addDetailViewToKeyWindow
{
    if (self.singleSkillDetailViewController.isSingleSkillDetailShown) {
        
    }
    else {
        self.singleSkillDetailViewController = [[[SingleSkillDetailViewController alloc] initWithNibName:@"SingleSkillDetailViewController" bundle:nil] autorelease];
        self.view.center.x<160?
        [self.singleSkillDetailViewController.view setFrame:CGRectMake(150, 45, self.singleSkillDetailViewController.view.frame.size.width, self.singleSkillDetailViewController.view.frame.size.height)]:
        [self.singleSkillDetailViewController.view setFrame:CGRectMake(10, 45, self.singleSkillDetailViewController.view.frame.size.width, self.singleSkillDetailViewController.view.frame.size.height)];
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


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"HeroesHall";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryNone;
	}
    cell.backgroundColor = [UIColor clearColor];
//    cell.backgroundView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bt_hero"]] autorelease];
//    cell.selectedBackgroundView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bt_hero_s"]] autorelease];
    return cell;
}

@end
