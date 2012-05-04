//
//  DemonHunterSkillDetailViewController.m
//  DiabloIIIHerosHall
//
//  Created by  on 12-5-2.
//  Copyright (c) 2012年 Neng! Star. All rights reserved.
//

#import "DemonHunterSkillDetailViewController.h"

@implementation DemonHunterSkillDetailViewController
@synthesize initiative;
@synthesize passive;

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
    [super dealloc];
}

- (void)setSelfViewToPassive
{
    initiative.hidden = YES;
    passive.hidden = NO;
    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, passive.frame.size.width, passive.frame.size.height);
    self.view = passive;
    [super setSelfViewToPassive];
}

- (void)setSelfViewToInitiative
{
    initiative.hidden = NO;
    passive.hidden = YES;
    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, initiative.frame.size.width, initiative.frame.size.height);
    self.view = initiative;
    [super setSelfViewToInitiative];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSString *str = NSLocalizedString(@"rune_pulverize_detail", nil);
    
    CGSize labelSize = [str sizeWithFont:[UIFont systemFontOfSize:10.0f]
                       constrainedToSize:CGSizeMake(160, MAXFLOAT) 
                           lineBreakMode:UILineBreakModeCharacterWrap];   // str是要显示的字符串
    UILabel *patternLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, labelSize.width, labelSize.height)];    
    
    patternLabel.text = str;
    patternLabel.backgroundColor = [UIColor clearColor];
    patternLabel.font = [UIFont systemFontOfSize:10.0f];
    patternLabel.numberOfLines = 0;     // 不可少Label属性之一
    patternLabel.lineBreakMode = UILineBreakModeCharacterWrap;    // 不可少Label属性之二
    [self.view addSubview:patternLabel];
    [patternLabel release];
    
    
    /*
     - (UIImage *)stretchableImageWithLeftCapWidth:(NSInteger)leftCapWidth topCapHeight:(NSInteger)topCapHeight
     
     - (UIImage *)resizableImageWithCapInsets:(UIEdgeInsets)capInsets     
     */
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

@end
