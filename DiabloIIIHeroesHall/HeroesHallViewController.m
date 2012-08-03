//
//  HeroesHallViewController.m
//  DiabloIIIHerosHall
//
//  Created by  on 12-4-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HeroesHallViewController.h"


@implementation HeroesHallViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)createHero
{
    HeroRiseViewController *heroRiseViewController = [[HeroRiseViewController alloc] initWithNibName:@"HeroRiseViewController" bundle:nil];
    [self.navigationController pushViewController:heroRiseViewController animated:YES];
    [heroRiseViewController release];
}

- (void)dealloc
{
    [hallTable release];
    [rectImage release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self moveIntoScreen:rectImage from:CGRectMake(0.0f, 0.0f - rectImage.frame.size.height, rectImage.frame.size.width, rectImage.frame.size.height) to:CGRectMake(0.0f, 0.0f,rectImage.frame.size.width,rectImage.frame.size.height)];
    [self moveIntoScreen:hallTable from:CGRectMake(21.0f, 73.0f - rectImage.frame.size.height, hallTable.frame.size.width, hallTable.frame.size.height) to:CGRectMake(21.0f, 73.0f,hallTable.frame.size.width,hallTable.frame.size.height)];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    AppDelegate *mainDelegate = [[UIApplication sharedApplication] delegate];
    return [mainDelegate.savedData count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSString *)loadSelectData:(NSInteger)index
{
    AppDelegate *mainDelegate = [[UIApplication sharedApplication] delegate];
    return (NSString *)[mainDelegate.savedData objectAtIndex:index];
}

- (void)didFinishSaving
{
    NSLog(@"reload data");
    [hallTable reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        //load data
        //if data == nil
        //push to hero rise viewcontroller
        //else push to heroskillboard viewcontroller
        
        //data = @"key|class|sex|name|battletag|server|skilldata"
        //key:time 
        //class:0,1,2,3,4,5
        //sex:0(female),1(male)
        //name:string
        //battletag:string
        //server:0(na),1(eu),2(as)
        //skilldata:initiative!passive!rune(ex:abcdef!abc!abcdef)
    
    HeroSkillBoardViewController *heroSkillBoard = [[HeroSkillBoardViewController alloc] initWithNibName:@"HeroSkillBoardViewController" bundle:nil];
    [heroSkillBoard setDelegate:self];
    [heroSkillBoard loadHeroData:[self loadSelectData:[indexPath row]] withIndex:[indexPath row]];
    [self.navigationController pushViewController:heroSkillBoard animated:YES];
    [heroSkillBoard release];
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        AppDelegate *mainDelegate = [[UIApplication sharedApplication] delegate];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];//获取当前应用程序的文件目录
        NSString *Path = [NSString stringWithFormat:@"%@/SaveData.plist",documentsDirectory];
        for (int i = 0; i < [mainDelegate.savedData count]; i ++) {
            if ([indexPath row] == i) {
                [mainDelegate.savedData removeObjectAtIndex:i];
                [mainDelegate.savedData writeToFile:Path atomically:NO];
            }
        }
        [hallTable deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }     
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [UIImage imageNamed:@"bt_hero"].size.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate *mainDelegate = [[UIApplication sharedApplication] delegate];
    NSString *data = (NSString *)[mainDelegate.savedData objectAtIndex:[indexPath row]];
    NSArray *dataArray = [data componentsSeparatedByString:@"|"];
    NSString *CellIdentifier = (NSString *)[dataArray objectAtIndex:0];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
//        NSLog(@"========nil========");
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryNone;
	}
    cell.backgroundColor = [UIColor clearColor];
    cell.backgroundView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bt_hero"]] autorelease];
    cell.selectedBackgroundView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bt_hero_s"]] autorelease];
    NSArray *imageNameArray = [[NSArray alloc] initWithObjects:@"avatar_bar_f",@"avatar_dh_f",@"avatar_monk_f",@"avatar_wd_f",@"avatar_wz_f",@"avatar_bar_m",@"avatar_dh_m",@"avatar_monk_m",@"avatar_wd_m",@"avatar_wz_m",nil];
    NSInteger class = [[dataArray objectAtIndex:1] intValue];
    NSInteger sex = [[dataArray objectAtIndex:2] intValue];
//    UIImage
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[imageNameArray objectAtIndex:(5*sex+class)]]];
    [image setFrame:CGRectMake(0, 3, 44, 44)];
    [cell addSubview:image];
    [image release];
    [imageNameArray release];
    return cell;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)createHero:(id)sender {
    [self createHero];
}

// move view to right side
- (void)moveIntoScreen:(UIView *)view from:(CGRect)begin to:(CGRect)end{
    view.frame = begin;
    [self animateHomeViewToSide:view rect:end];
}

// animate home view to side rect
- (void)animateHomeViewToSide:(UIView *)view rect:(CGRect)newViewRect {
    [UIView animateWithDuration:0.7 
                     animations:^{
                         view.frame = newViewRect;
                     } 
                     completion:^(BOOL finished){
                         //finished,do sth
                     }];
}

@end
