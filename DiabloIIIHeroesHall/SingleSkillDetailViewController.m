//
//  SingleSkillDetailViewController.m
//  DiabloIIIHeroesHall
//
//  Created by  on 12-5-4.
//  Copyright (c) 2012年 Neng! Star. All rights reserved.
//

#import "SingleSkillDetailViewController.h"
#import "AppDelegate.h"

#define DETAIL_BOARD_WIDTH 160.0f
#define DETAIL_CONTENT_MARGIN 7.0f
#define SKILL_NAME_RECT_HEIGHT  23.0f
#define SKILL_IMAGE_SIZE 30.0f

#define SKILL_NAME_FONT_SIZE  12.0f
#define SKILL_DETAIL_FONT_SIZE 9.0f

#define STORY_FONT_SIZE 10.0f

@implementation SingleSkillDetailViewController
@synthesize isSingleSkillDetailShown;
@synthesize heroClass,skillKey,skillType,hasStory;

- (void)dealloc
{
    [heroClass release];
    [skillKey release];
    [skillType release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    isSingleSkillDetailShown = YES;
    CGSize storySize = CGSizeZero;
    NSString *story = nil;
    AppDelegate *mainDelegate = [[UIApplication sharedApplication] delegate];
    NSDictionary *heroClass_ = [mainDelegate.heroSkillDataSource objectForKey:heroClass];
    NSDictionary *skillType_ = [heroClass_ objectForKey:skillType];
    NSDictionary *skill = [skillType_ objectForKey:skillKey];
    CGSize constraintWithBoard = CGSizeMake(DETAIL_BOARD_WIDTH - (DETAIL_CONTENT_MARGIN * 2), MAXFLOAT);
    CGSize constraintWithDetail = CGSizeMake(DETAIL_BOARD_WIDTH - (DETAIL_CONTENT_MARGIN * 2) - SKILL_IMAGE_SIZE - DETAIL_CONTENT_MARGIN, MAXFLOAT);
    
    NSString *skillName = NSLocalizedString([skill objectForKey:@"name"], nil);
    NSString *skillDetail = NSLocalizedString([skill objectForKey:@"detail"], nil);
    CGFloat skillNameHeight = SKILL_NAME_RECT_HEIGHT;
    
    CGSize skillDetailSize = [skillDetail sizeWithFont:[UIFont systemFontOfSize:SKILL_DETAIL_FONT_SIZE] constrainedToSize:constraintWithDetail lineBreakMode:UILineBreakModeWordWrap];
    
    CGFloat height = skillNameHeight + DETAIL_CONTENT_MARGIN + MAX(skillDetailSize.height,SKILL_IMAGE_SIZE) + DETAIL_CONTENT_MARGIN;
    if (hasStory) {
        story = NSLocalizedString([skill objectForKey:@"story"],nil);
        storySize = [story sizeWithFont:[UIFont fontWithName:@"Baskerville-Italic" size:STORY_FONT_SIZE] constrainedToSize:constraintWithBoard lineBreakMode:UILineBreakModeWordWrap];
        height += storySize.height + DETAIL_CONTENT_MARGIN;
    }
    [self.view setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, 160, height)];
    UIImage *mash_area = [[UIImage imageNamed:@"bg_singleskilldetailboard"] resizableImageWithCapInsets:UIEdgeInsetsMake(23, 8, 8, 1)];
    UIImageView *mash_view = [[[UIImageView alloc] initWithImage:mash_area] autorelease];
    [mash_view setFrame:self.view.frame];
    [self.view addSubview:mash_view];
    //name
    UILabel *skillNameLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 160, 23)] autorelease];
    [skillNameLabel setBackgroundColor:[UIColor clearColor]];
    [skillNameLabel setFont:[UIFont fontWithName:@"American Typewriter" size:SKILL_NAME_FONT_SIZE]];
    [skillNameLabel setTextAlignment:UITextAlignmentCenter];
    [skillNameLabel setTextColor:[UIColor colorWithRed:220.0f/255.0f green:220.0f/255.0f blue:200.0f/255.0f alpha:1.0f]];
    [skillNameLabel setText:skillName];
    [self.view addSubview:skillNameLabel];
    //image
    UIImageView *skillImage = [[[UIImageView alloc] initWithFrame:CGRectMake(DETAIL_CONTENT_MARGIN, SKILL_NAME_RECT_HEIGHT + DETAIL_CONTENT_MARGIN, SKILL_IMAGE_SIZE, SKILL_IMAGE_SIZE)] autorelease];
    [skillImage setBackgroundColor:[UIColor clearColor]];
    [skillImage setImage:[UIImage imageNamed:[skill objectForKey:@"image"]]];
    [self.view addSubview:skillImage];
    //detail
    cnvUILabel *skillDetailLabel = [[cnvUILabel alloc] initWithFrame:CGRectMake(DETAIL_CONTENT_MARGIN*2 + SKILL_IMAGE_SIZE, SKILL_NAME_RECT_HEIGHT + DETAIL_CONTENT_MARGIN, constraintWithDetail.width, skillDetailSize.height)];
    [skillDetailLabel setLineBreakMode:UILineBreakModeWordWrap];
    [skillDetailLabel setNumberOfLines:0];
    [skillDetailLabel setTextAlignment:UITextAlignmentLeft];
    [skillDetailLabel cnv_setUILabelText:skillDetail andKeyWord:@"0123456789%"];
    [skillDetailLabel setBackgroundColor:[UIColor clearColor]];
    [skillDetailLabel setFont:[UIFont systemFontOfSize:SKILL_DETAIL_FONT_SIZE]];
    [skillDetailLabel cnv_setUIlabelTextColor:[UIColor colorWithRed:190.0/255.0 green:170.0/255.0 blue:100.0/255.0 alpha:1.0] andKeyWordColor:[UIColor greenColor]];
    [self.view addSubview:skillDetailLabel];
    [skillDetailLabel release];
    //story
    if (hasStory) {
        UILabel *storyLabel = [[[UILabel alloc] initWithFrame:CGRectMake(DETAIL_CONTENT_MARGIN, SKILL_NAME_RECT_HEIGHT + DETAIL_CONTENT_MARGIN*2 + skillDetailSize.height, constraintWithBoard.width, storySize.height)] autorelease];
        [storyLabel setLineBreakMode:UILineBreakModeWordWrap];
        [storyLabel setBackgroundColor:[UIColor clearColor]];
        [storyLabel setMinimumFontSize:STORY_FONT_SIZE];
        [storyLabel setNumberOfLines:0];
        [storyLabel setFont:[UIFont systemFontOfSize:STORY_FONT_SIZE]];
        [storyLabel setBackgroundColor:[UIColor clearColor]];
        [storyLabel setTextAlignment:UITextAlignmentLeft];
        [storyLabel setFont:[UIFont fontWithName:@"Baskerville-Italic" size:STORY_FONT_SIZE]];
        [storyLabel setTextColor:[UIColor colorWithRed:160.0/255.0 green:126.0/255.0 blue:86.0/255.0 alpha:1.0]];
        [storyLabel setText:story];
        [self.view addSubview:storyLabel];
        UIImageView *line = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"line_singleskilldetailline"]];
        line.frame = CGRectMake(0, SKILL_NAME_RECT_HEIGHT + DETAIL_CONTENT_MARGIN + skillDetailSize.height, DETAIL_BOARD_WIDTH, 1);
        [self.view addSubview:line];
        [line release];
    }
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

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    
    if ([touch view] != nil) {
        if (isSingleSkillDetailShown) {
            [self.view removeFromSuperview];
            isSingleSkillDetailShown = NO;
        }
    }
}
@end
