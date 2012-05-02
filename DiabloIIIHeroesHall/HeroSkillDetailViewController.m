//
//  HeroSkillDetailViewController.m
//  DiabloIIIHerosHall
//
//  Created by  on 12-5-2.
//  Copyright (c) 2012年 Neng! Star. All rights reserved.
//

#import "HeroSkillDetailViewController.h"

@implementation HeroSkillDetailViewController
@synthesize isHeroSkillDetailShown;
@synthesize delegate;

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

#pragma mark -
#pragma mark Other methods

// restore view location
- (void)restoreViewLocation {
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
                         UIControl *overView = (UIControl *)[[[UIApplication sharedApplication] keyWindow] viewWithTag:9618088];
                         [overView removeFromSuperview];
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
                         UIControl *overView = [[UIControl alloc] init];
                         overView.tag = 9618088;
                         overView.backgroundColor = [UIColor clearColor];
                         if (self.view.center.x<160.0f) {
                             overView.frame = CGRectMake(self.view.frame.size.width, self.view.frame.origin.y, 320.0f - self.view.frame.size.width, self.view.frame.size.height);
                         }
                         else {
                             overView.frame = CGRectMake(0.0f, self.view.frame.origin.y, 320.0f - self.view.frame.size.width, self.view.frame.size.height);
                         }
                         [overView addTarget:self action:@selector(restoreViewLocation) forControlEvents:UIControlEventTouchDown];
                         [[[UIApplication sharedApplication] keyWindow] addSubview:overView];
                         [overView release];
                     }];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
