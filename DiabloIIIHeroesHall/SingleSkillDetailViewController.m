//
//  SingleSkillDetailViewController.m
//  DiabloIIIHeroesHall
//
//  Created by  on 12-5-4.
//  Copyright (c) 2012年 Neng! Star. All rights reserved.
//

#import "SingleSkillDetailViewController.h"

@implementation SingleSkillDetailViewController
@synthesize isSingleSkillDetailShown;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    isSingleSkillDetailShown = YES;
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

- (IBAction)closeButtonPressed:(UIButton *)sender {
    [self.view removeFromSuperview];
    isSingleSkillDetailShown = NO;
}
@end
