//
//  HeroRiseViewController.m
//  DiabloIIIHerosHall
//
//  Created by  on 12-4-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HeroRiseViewController.h"


@implementation HeroRiseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        UIImage *backImg = [UIImage imageNamed:@"bt_back"];
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [backBtn setBackgroundImage:backImg forState:UIControlStateNormal];
        backBtn.frame = CGRectMake(0, 0, backImg.size.width, backImg.size.height);
        [backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        self.navigationItem.leftBarButtonItem = left;
        [left release];
        
        heroPage.currentPage = 0;
        currentClass = heroPage.currentPage;
        lastClass = currentClass;
        currentSex = 1;
        lastSex = currentSex;
        imageNameArray = [[NSArray alloc] initWithObjects:@"hero_bar_f",@"hero_dh_f",@"hero_monk_f",@"hero_wd_f",@"hero_wz_f",@"hero_bar_m",@"hero_dh_m",@"hero_monk_m",@"hero_wd_m",@"hero_wz_m",nil];
        classNameArray = [[NSArray alloc] initWithObjects:@"Barbarian", @"Demon Hunter",@"Monk",@"Witch Doctor",@"Wizard",nil];
        self.title = @"CHOOSE YOUR HERO";
    }
    return self;
}

- (void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
    [[[heroScroll subviews] objectAtIndex:0] loadData:nil MIMEType:nil textEncodingName:nil baseURL:nil];
    [[[heroScroll subviews] objectAtIndex:0] removeFromSuperview];
}

- (void)goRise
{
    HeroSkillBoardViewController *heroSkillBoard = [[HeroSkillBoardViewController alloc] initWithNibName:@"HeroSkillBoardViewController" bundle:nil];
    heroSkillBoard.heroClass = currentClass;
    heroSkillBoard.heroSex = currentSex;
    heroSkillBoard.needReset = YES;
    [heroSkillBoard setDelegate:[[self.navigationController viewControllers] objectAtIndex:0]];
    [self.navigationController pushViewController:heroSkillBoard animated:YES];
    [heroSkillBoard release];
}

- (void)loadGifView
{
    NSData *heroGifData = [[NSData alloc] initWithData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[imageNameArray objectAtIndex:(currentClass+5*currentSex)] ofType:@"gif"]]];
    UIWebView *heroStage = [[UIWebView alloc] initWithFrame:CGRectMake((currentClass+1)*124, 0, 124, 186)];
    heroStage.userInteractionEnabled = NO;
    heroStage.scalesPageToFit = YES;
    heroStage.backgroundColor = [UIColor clearColor];
    heroStage.delegate = self;
    heroStage.opaque = NO;    
    [heroScroll addSubview:heroStage];
    [heroStage release];
    [heroStage loadData:heroGifData MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
    [heroGifData release];
}

- (void)dealloc
{ 
    [heroInfo release];
    [heroClass release];
    [loadView release];
    [heroRect release];
    [heroScroll release];
    [heroPage release];
    [male release];
    [female release];
    [classNameArray release];
    [imageNameArray release];
    [super dealloc];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    //    [heroRect setHidden:YES];
    [loadView startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //    [heroRect setHidden:NO];
    [loadView stopAnimating];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [male setSelected:YES];
    [female setSelected:NO];
    [heroScroll setContentSize:CGSizeMake(heroScroll.frame.size.width*7, heroScroll.frame.size.height)];
    [heroScroll setContentOffset:CGPointMake(124, 0) animated:NO];
    heroRect.center = heroScroll.center;
    loadView.center = heroScroll.center;
    [self.view addSubview:loadView];
    [self.view addSubview:heroRect];
    [self loadGifView];
    [heroClass setText:NSLocalizedString([classNameArray objectAtIndex:currentClass],nil)]; 
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int page = scrollView.contentOffset.x/scrollView.frame.size.width;
    if (page < heroPage.numberOfPages+1 && page > 0) {
        [heroPage setCurrentPage:(page-1)];
    }
    else if (page == heroPage.numberOfPages+1){
        [heroPage setCurrentPage:0];
        [heroScroll setContentOffset:CGPointMake(124, 0) animated:NO];
    }
    else if (page == 0)
    {
        [heroPage setCurrentPage:(heroPage.numberOfPages-1)];
        [heroScroll setContentOffset:CGPointMake(124*5, 0) animated:NO];
    }
    currentClass = heroPage.currentPage;
    if(currentClass==lastClass)
        return;
    [[[heroScroll subviews] objectAtIndex:0] removeFromSuperview];
    [self loadGifView];
    lastClass = currentClass;
    [heroClass setText:NSLocalizedString([classNameArray objectAtIndex:currentClass],nil)];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
}

- (IBAction)maleSelected:(UIButton *)sender {
    [male setHighlighted:YES];
    [male setSelected:YES];
    [female setHighlighted:NO];
    [female setSelected:NO];
    currentSex = 1;
    if (currentSex != lastSex) {
        [[[heroScroll subviews] objectAtIndex:0] removeFromSuperview];
        [self loadGifView];
        lastSex = currentSex;
    }
}

- (IBAction)femaleSelected:(UIButton *)sender {
    [male setHighlighted:NO];
    [male setSelected:NO];
    [female setHighlighted:YES];
    [female setSelected:YES];
    currentSex = 0;
    if (currentSex != lastSex) {
        [[[heroScroll subviews] objectAtIndex:0] removeFromSuperview];
        [self loadGifView];
        lastSex = currentSex;
    }
}

- (IBAction)nextPage:(UIButton *)sender {
    [self goRise];
}
@end
