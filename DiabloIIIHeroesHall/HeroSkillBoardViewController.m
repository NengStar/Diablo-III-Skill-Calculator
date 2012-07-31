//
//  HeroSkillBoardViewController.m
//  DiabloIIIHerosHall
//
//  Created by  on 12-5-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HeroSkillBoardViewController.h"

@implementation HeroSkillBoardViewController

@synthesize delegate;
@synthesize heroClass;
@synthesize heroSex;
@synthesize needReset;

@synthesize barbarianSkillBoard = _barbarianSkillBoard;
@synthesize demonhunterSkillBoard = _demonhunterSkillBoard;
@synthesize monkSkillBoard = _monkSkillBoard;
@synthesize witchdoctorSkillBoard = _witchdoctorSkillBoard;
@synthesize wizardSkillBoard = _wizardSkillBoard;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        UIImage *backImg = [UIImage imageNamed:@"bt_back"];
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [backBtn setBackgroundImage:backImg forState:UIControlStateNormal];
        backBtn.frame = CGRectMake(0, 0, backImg.size.width, backImg.size.height);
        [backBtn addTarget:self action:@selector(goHall) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        self.navigationItem.leftBarButtonItem = left;
        [left release];
        UIImage *forwardImg = [UIImage imageNamed:@"bt_forward"];
        UIButton *forwardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [forwardBtn setBackgroundImage:forwardImg forState:UIControlStateNormal];
        forwardBtn.frame = CGRectMake(0, 0, forwardImg.size.width, forwardImg.size.height);
        [forwardBtn addTarget:self action:@selector(saveHeroData) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:forwardBtn];
        self.navigationItem.rightBarButtonItem = right;
        [right release];
        viewControllerWillTerminate = NO;
        viewControllerWillPopToRoot = NO;
        dataArray = nil;
        dataIndex = -1;
        imageNameArray = [[NSArray alloc] initWithObjects:@"avatar_bar_f",@"avatar_dh_f",@"avatar_monk_f",@"avatar_wd_f",@"avatar_wz_f",@"avatar_bar_m",@"avatar_dh_m",@"avatar_monk_m",@"avatar_wd_m",@"avatar_wz_m",nil];
        classNameArray = [[NSArray alloc] initWithObjects:@"Barbarian", @"Demon Hunter",@"Monk",@"Witch Doctor",@"Wizard",nil];
        skillSystemNameArray = [[NSArray alloc] initWithObjects:@"Might",@"Tactics",@"Rage",@"Hunting",@"Devices",@"Archery",@"Techniques",@"Focus",@"Mantras",@"Terror",@"Decay",@"Voodoo",@"Force",@"Conjuration",@"Mastery",@"Primary",@"Secondary",@"Defensive",nil];
        [self resetBoard];
    }
    return self;
}

- (void)dealloc
{
    [heroAvatar release];
    [className release];
    
    [mouseLeftSkill release];
    [mouseRightSkill release];
    [numOneSkill release];
    [numTwoSkill release];
    [numThreeSkill release];
    [numFourSkill release];
    
    //name label
    [mouseLeftSkillName release];
    [mouseRightSkillName release];
    [numOneSkillName release];
    [numTwoSkillName release];
    [numThreeSkillName release];
    [numFourSkillName release];
    //rune label
    [mouseLeftRuneName release];
    [mouseRightRuneName release];
    [numOneRuneName release];
    [numTwoRuneName release];
    [numThreeRuneName release];
    [numFourRuneName release];
    //pskill label
    [passiveSkillOneName release];
    [passiveSkillTwoName release];
    [passiveSkillThreeName release];
    //skill image
    [mouseLeftSkillImage release];
    [mouseRightSkillImage release];
    [numOneSkillImage release];
    [numTwoSkillImage release];
    [numThreeSkillImage release];
    [numFourSkillImage release];
    //rune image
    [mouseLeftRuneImage release];
    [mouseRightRuneImage release];
    [numOneRuneImage release];
    [numTwoRuneImage release];
    [numThreeRuneImage release];
    [numFourRuneImage release];
    //pskill image
    [passiveSkillOneImage release];
    [passiveSkillTwoImage release];
    [passiveSkillThreeImage release];
    
    [initiative release];
    [passive release];
    [runes release];
    [pages release];
    [tags release];
    
    [imageNameArray release];
    [classNameArray release];
    [skillSystemNameArray release];
    
    [_barbarianSkillBoard release];
    [_demonhunterSkillBoard release];
    [_monkSkillBoard release];
    [_witchdoctorSkillBoard release];
    [_wizardSkillBoard release];
    [super dealloc];
}

- (void)goHall
{
    if(currentSkillBoard.isHeroSkillDetailShown)
    {
        [currentSkillBoard restoreViewLocation];
        viewControllerWillTerminate = YES;
    }
    else {
        [[[[UIApplication sharedApplication] keyWindow] viewWithTag:13811150829] removeFromSuperview];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)skillBoardDidFinishClosing
{
    [self makeButtonUnSelected];
    if (viewControllerWillTerminate) {
        [[[[UIApplication sharedApplication] keyWindow] viewWithTag:13811150829] removeFromSuperview];
        [self.navigationController popViewControllerAnimated:YES];
    }
    if (viewControllerWillPopToRoot) {
        [[[[UIApplication sharedApplication] keyWindow] viewWithTag:13811150829] removeFromSuperview];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

- (void)initiativeSkillSelected:(NSString *)heroClasses withSkillKey:(NSString *)skillKey withPage:(NSNumber *)page withTag:(NSNumber *)tag
{
    AppDelegate *mainDelegate = [[UIApplication sharedApplication] delegate];
    NSDictionary *class = [mainDelegate.heroSkillDataSource objectForKey:heroClasses];
    NSDictionary *type = [class objectForKey:@"Initiative"];
    NSDictionary *skill = [type objectForKey:skillKey];
    NSString *skillName = NSLocalizedString([skill objectForKey:@"name"],nil);
    NSString *skillSystem = NSLocalizedString([skill objectForKey:@"system"],nil);
    UIImage *skillImage = [UIImage imageNamed:[skill objectForKey:@"image"]];
    UIColor *color = [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:210.0/255.0 alpha:1.0];
    switch (selectedButton.tag) {
        case 660:
            [mouseLeftSkill setText:skillSystem];
            [mouseLeftSkillName setTextColor:color];
            [mouseLeftSkillName setText:skillName];
            [mouseLeftSkillImage setImage:skillImage];
            [initiative removeObjectAtIndex:0];
            [initiative insertObject:skillKey atIndex:0];
            [pages removeObjectAtIndex:0];
            [pages insertObject:page atIndex:0];
            [tags removeObjectAtIndex:0];
            [tags insertObject:tag atIndex:0];
            break;
        case 661:
            [mouseRightSkill setText:skillSystem];
            [mouseRightSkillName setTextColor:color];
            [mouseRightSkillName setText:skillName];
            [mouseRightSkillImage setImage:skillImage];
            [initiative removeObjectAtIndex:1];
            [initiative insertObject:skillKey atIndex:1];
            [pages removeObjectAtIndex:1];
            [pages insertObject:page atIndex:1];
            [tags removeObjectAtIndex:1];
            [tags insertObject:tag atIndex:1];
            break;
        case 662:
            [numOneSkill setText:skillSystem];
            [numOneSkillName setTextColor:color];
            [numOneSkillName setText:skillName];
            [numOneSkillImage setImage:skillImage];
            [initiative removeObjectAtIndex:2];
            [initiative insertObject:skillKey atIndex:2];
            [pages removeObjectAtIndex:2];
            [pages insertObject:page atIndex:2];
            [tags removeObjectAtIndex:2];
            [tags insertObject:tag atIndex:2];
            break;
        case 663:
            [numTwoSkill setText:skillSystem];
            [numTwoSkillName setTextColor:color];
            [numTwoSkillName setText:skillName];
            [numTwoSkillImage setImage:skillImage];
            [initiative removeObjectAtIndex:3];
            [initiative insertObject:skillKey atIndex:3];
            [pages removeObjectAtIndex:3];
            [pages insertObject:page atIndex:3];
            [tags removeObjectAtIndex:3];
            [tags insertObject:tag atIndex:3];
            break;
        case 664:
            [numThreeSkill setText:skillSystem];
            [numThreeSkillName setTextColor:color];
            [numThreeSkillName setText:skillName];
            [numThreeSkillImage setImage:skillImage];
            [initiative removeObjectAtIndex:4];
            [initiative insertObject:skillKey atIndex:4];
            [pages removeObjectAtIndex:4];
            [pages insertObject:page atIndex:4];
            [tags removeObjectAtIndex:4];
            [tags insertObject:tag atIndex:4];
            break;
        case 665:
            [numFourSkill setText:skillSystem];
            [numFourSkillName setTextColor:color];
            [numFourSkillName setText:skillName];
            [numFourSkillImage setImage:skillImage];
            [initiative removeObjectAtIndex:5];
            [initiative insertObject:skillKey atIndex:5];
            [pages removeObjectAtIndex:5];
            [pages insertObject:page atIndex:5];
            [tags removeObjectAtIndex:5];
            [tags insertObject:tag atIndex:5];
            break;
    }
}

- (void)runeSelected:(NSString *)heroClasses withSkillKey:(NSString *)skillKey withRuneKey:(NSString *)runeKey{
    AppDelegate *mainDelegate = [[UIApplication sharedApplication] delegate];
    NSDictionary *class = [mainDelegate.heroSkillDataSource objectForKey:heroClasses];
    NSDictionary *type = [class objectForKey:@"Initiative"];
    NSDictionary *skill = [type objectForKey:skillKey];
    NSDictionary *rune = [[skill objectForKey:@"runes"] objectForKey:runeKey];
    NSString *runeName = NSLocalizedString([rune objectForKey:@"name"],nil);
    UIImage *runeImage = [UIImage imageNamed:[rune objectForKey:@"image"]];
    if ([runeKey isEqualToString:@"."]) {
        runeName = nil;
        runeImage = nil;
    }
    switch (selectedButton.tag) {
        case 660:
            [mouseLeftRuneName setText:runeName];
            [mouseLeftRuneImage setImage:runeImage];
            [runes removeObjectAtIndex:0];
            [runes insertObject:runeKey atIndex:0];
            break;
        case 661:
            [mouseRightRuneName setText:runeName];
            [mouseRightRuneImage setImage:runeImage];
            [runes removeObjectAtIndex:1];
            [runes insertObject:runeKey atIndex:1];
            break;
        case 662:
            [numOneRuneName setText:runeName];
            [numOneRuneImage setImage:runeImage];
            [runes removeObjectAtIndex:2];
            [runes insertObject:runeKey atIndex:2];
            break;
        case 663:
            [numTwoRuneName setText:runeName];
            [numTwoRuneImage setImage:runeImage];
            [runes removeObjectAtIndex:3];
            [runes insertObject:runeKey atIndex:3];
            break;
        case 664:
            [numThreeRuneName setText:runeName];
            [numThreeRuneImage setImage:runeImage];
            [runes removeObjectAtIndex:4];
            [runes insertObject:runeKey atIndex:4];
            break;
        case 665:
            [numFourRuneName setText:runeName];
            [numFourRuneImage setImage:runeImage];
            [runes removeObjectAtIndex:5];
            [runes insertObject:runeKey atIndex:5];
            break;
    }
}

- (void)passiveSkillSelected:(NSString *)heroClasses withPSkillKey:(NSString *)pskillKey withTag:(NSNumber *)tag
{
    AppDelegate *mainDelegate = [[UIApplication sharedApplication] delegate];
    NSDictionary *class = [mainDelegate.heroSkillDataSource objectForKey:heroClasses];
    NSDictionary *type = [class objectForKey:@"Passive"];
    NSDictionary *pskill = [type objectForKey:pskillKey];
    NSString *pskillName = NSLocalizedString([pskill objectForKey:@"name"],nil);
    UIImage *pskillImage = [UIImage imageNamed:[pskill objectForKey:@"image"]];
    UIColor *color = [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:210.0/255.0 alpha:1.0];
    switch (selectedButton.tag) {
        case 880:
            [passiveSkillOneName setTextColor:color];
            [passiveSkillOneName setText:pskillName];
            [passiveSkillOneImage setImage:pskillImage];
            [passive removeObjectAtIndex:0];
            [passive insertObject:pskillKey atIndex:0];
            [tags removeObjectAtIndex:6];
            [tags insertObject:tag atIndex:6];
            break;
        case 881:
            [passiveSkillTwoName setTextColor:color];
            [passiveSkillTwoName setText:pskillName];
            [passiveSkillTwoImage setImage:pskillImage];
            [passive removeObjectAtIndex:1];
            [passive insertObject:pskillKey atIndex:1];
            [tags removeObjectAtIndex:7];
            [tags insertObject:tag atIndex:7];
            break;
        case 882:
            [passiveSkillThreeName setTextColor:color];
            [passiveSkillThreeName setText:pskillName];
            [passiveSkillThreeImage setImage:pskillImage];
            [passive removeObjectAtIndex:2];
            [passive insertObject:pskillKey atIndex:2];
            [tags removeObjectAtIndex:8];
            [tags insertObject:tag atIndex:8];
            break;
    }
}

- (void)setSkillSystemLabel
{
    [mouseLeftSkill setText:[skillSystemNameArray objectAtIndex:15]];
    [mouseRightSkill setText:[skillSystemNameArray objectAtIndex:16]];
    [numOneSkill setText:[skillSystemNameArray objectAtIndex:17]];
    [numTwoSkill setText:[skillSystemNameArray objectAtIndex:heroClass*3]];
    [numThreeSkill setText:[skillSystemNameArray objectAtIndex:(heroClass*3+1)]];
    [numFourSkill setText:[skillSystemNameArray objectAtIndex:(heroClass*3+2)]];
}

- (void)setInitiativeSkillName
{
    UIColor *color = [UIColor colorWithRed:128.0/255.0 green:118.0/255.0 blue:103.0/255.0 alpha:1.0];
    [mouseLeftSkillName setTextColor:color];
    [mouseLeftSkillName setText:@"Choose Skill"];
    [mouseRightSkillName setTextColor:color];
    [mouseRightSkillName setText:@"Choose Skill"];
    [numOneSkillName setTextColor:color];
    [numOneSkillName setText:@"Choose Skill"];
    [numTwoSkillName setTextColor:color];
    [numTwoSkillName setText:@"Choose Skill"];
    [numThreeSkillName setTextColor:color];
    [numThreeSkillName setText:@"Choose Skill"];
    [numFourSkillName setTextColor:color];
    [numFourSkillName setText:@"Choose Skill"];
}

- (void)setRuneName
{
    [mouseLeftRuneName setText:@""];
    [mouseRightRuneName setText:@""];
    [numOneRuneName setText:@""];
    [numTwoRuneName setText:@""];
    [numThreeRuneName setText:@""];
    [numFourRuneName setText:@""];
}

- (void)setPassiveSkillName
{
    UIColor *color = [UIColor colorWithRed:128.0/255.0 green:118.0/255.0 blue:103.0/255.0 alpha:1.0];
    [passiveSkillOneName setTextColor:color];
    [passiveSkillOneName setText:@"Choose Skill"];
    [passiveSkillTwoName setTextColor:color];
    [passiveSkillTwoName setText:@"Choose Skill"];
    [passiveSkillThreeName setTextColor:color];
    [passiveSkillThreeName setText:@"Choose Skill"];
}

- (void)setInitiativeSkillImage
{
    [mouseLeftSkillImage setImage:nil];
    [mouseRightSkillImage setImage:nil];
    [numOneSkillImage setImage:nil];
    [numTwoSkillImage setImage:nil];
    [numThreeSkillImage setImage:nil];
    [numFourSkillImage setImage:nil];
}

- (void)setRuneImage
{
    [mouseLeftRuneImage setImage:nil];
    [mouseRightRuneImage setImage:nil];
    [numOneRuneImage setImage:nil];
    [numTwoRuneImage setImage:nil];
    [numThreeRuneImage setImage:nil];
    [numFourRuneImage setImage:nil];
}

- (void)setPassiveSkillImage
{
    [passiveSkillOneImage setImage:nil];
    [passiveSkillTwoImage setImage:nil];
    [passiveSkillThreeImage setImage:nil];
}

- (void)setDefaultData
{
    //    NSLog(@"in default data");
    initiative = [[NSMutableArray alloc] initWithObjects:@".",@".",@".",@".",@".",@".", nil];
    passive = [[NSMutableArray alloc] initWithObjects:@".",@".",@".", nil];
    runes = [[NSMutableArray alloc] initWithObjects:@".",@".",@".",@".",@".",@".", nil];
    pages = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:0],[NSNumber numberWithInt:1],[NSNumber numberWithInt:2],[NSNumber numberWithInt:3],[NSNumber numberWithInt:4],[NSNumber numberWithInt:5], nil];
    tags = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:-1],[NSNumber numberWithInt:-1],[NSNumber numberWithInt:-1],[NSNumber numberWithInt:-1],[NSNumber numberWithInt:-1],[NSNumber numberWithInt:-1],[NSNumber numberWithInt:-1],[NSNumber numberWithInt:-1],[NSNumber numberWithInt:-1], nil];
}

- (void)resetBoard
{
    [self setDefaultData];
    [self setSkillSystemLabel];
    [self setInitiativeSkillName];
    [self setInitiativeSkillImage];
    [self setRuneName];
    [self setRuneImage];
    [self setPassiveSkillName];
    [self setPassiveSkillImage];
    [self setPassiveSkillName];
    [self setPassiveSkillImage];
}

- (void)saveHeroData
{
    NSMutableString *skill = [[NSMutableString alloc] init];
    for (int i=0; i<[initiative count]; i++) {
        [skill appendFormat:(NSString *)[initiative objectAtIndex:i],nil];
    }
    [skill appendFormat:@"!"];
    for (int i=0; i<[passive count]; i++) {
        [skill appendFormat:(NSString *)[passive objectAtIndex:i],nil];
    }
    [skill appendFormat:@"!"];
    for (int i=0; i<[runes count]; i++) {
        [skill appendFormat:(NSString *)[runes objectAtIndex:i],nil];
    }
    NSDateFormatter *nsdf2=[[[NSDateFormatter alloc] init]autorelease];
    [nsdf2 setDateStyle:NSDateFormatterShortStyle];
    [nsdf2 setDateFormat:@"YYYYMMddHHmmssSSSS"];
    NSString *t2=[nsdf2 stringFromDate:[NSDate date]];
    NSString *data = [NSString stringWithFormat:@"%@|%d|%d|%@|%@|%d|%@",t2,heroClass,heroSex,@"name",@"NengStar#1141",0,skill];
    NSLog(@"%@\n",data);
    AppDelegate *mainDelegate = [[UIApplication sharedApplication] delegate];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];//获取当前应用程序的文件目录
    NSString *Path = [NSString stringWithFormat:@"%@/SaveData.plist",documentsDirectory];
    if (dataIndex>=0) {
        //alert view for overwrite
        NSLog(@"replace");
        [mainDelegate.savedData replaceObjectAtIndex:dataIndex withObject:data];
    }
    else {
        NSLog(@"add");
        [mainDelegate.savedData insertObject:data atIndex:0];
    }
    [mainDelegate.savedData writeToFile:Path atomically:NO];
    [delegate didFinishSaving];
    [skill release];
    if(currentSkillBoard.isHeroSkillDetailShown)
    {
        [currentSkillBoard restoreViewLocation];
        viewControllerWillPopToRoot = YES;
    }
    else {
        [[[[UIApplication sharedApplication] keyWindow] viewWithTag:13811150829] removeFromSuperview];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

- (void)loadHeroData:(NSString *)data withIndex:(NSInteger)index
{
    //data = @"key|class|sex|name|battletag|server|skilldata"
    //key:time string 
    //class:0,1,2,3,4,5  integer
    //sex:0(female),1(male) integer
    //name:string
    //battletag:string
    //server:0(na),1(eu),2(as) integer
    //skilldata:initiative!passive!rune(ex:abcdef!abc!abcdef)
    //    NSLog(@"in init data");
    NSLog(@"data = %@",data);
    if (data) {
        dataIndex = index;
        dataArray = [data componentsSeparatedByString:@"|"];
        dataKey = [dataArray objectAtIndex:0];
        heroClass = [[dataArray objectAtIndex:1] intValue];
        heroSex = [[dataArray objectAtIndex:2] intValue];
        heroName = [dataArray objectAtIndex:3];
        battleTag = [dataArray objectAtIndex:4];
        server = [[dataArray objectAtIndex:5] intValue];
        skillData = [dataArray objectAtIndex:6];
        NSLog(@"skill = %@",skillData);
        NSArray *skillArray = [skillData componentsSeparatedByString:@"!"];
        if (skillArray) {
            AppDelegate *mainDelegate = [[UIApplication sharedApplication] delegate];
            NSDictionary *class = [mainDelegate.heroSkillDataSource objectForKey:[classNameArray objectAtIndex:heroClass]];
            NSDictionary *skillType = nil;
            NSDictionary *skill = nil;
            NSNumber *tag = nil;
            
            //initiative
            NSString *skillString = [skillArray objectAtIndex:0];
            NSLog(@"iskill = %@",skillString);
            if (skillString) {
                skillType = [class objectForKey:@"Initiative"];
                for (int i=0; i<[skillString length]; i++) {
                    NSString *skillKey = [skillString substringWithRange:NSMakeRange(i, 1)];
                    if (![skillKey isEqualToString:@"."]) {
                        [initiative removeObjectAtIndex:i];
                        [initiative insertObject:skillKey atIndex:i];
                        skill = [skillType objectForKey:skillKey];
                        tag = [skill objectForKey:@"tag"];
                        NSLog(@"%@",tag);
                        [pages removeObjectAtIndex:i];
                        [pages insertObject:[NSNumber numberWithInt:([tag intValue]/10-1)] atIndex:i];
                        [tags removeObjectAtIndex:i];
                        [tags insertObject:tag atIndex:i];
                    }
                }
            }
            
            //passive
            NSString *pskillString = [skillArray objectAtIndex:1];
            NSLog(@"pskill = %@",pskillString);
            if (pskillString) {
                skillType = [class objectForKey:@"Passive"];
                for (int i=0; i<[pskillString length]; i++) {
                    NSString *pskillKey = [pskillString substringWithRange:NSMakeRange(i, 1)];
                    if (![pskillKey isEqualToString:@"."]) {
                        [passive removeObjectAtIndex:i];
                        [passive insertObject:pskillKey atIndex:i];
                        skill = [skillType objectForKey:pskillKey];
                        tag = [skill objectForKey:@"tag"];
                        [tags removeObjectAtIndex:(6+i)];
                        [tags insertObject:tag atIndex:(6+i)];
                    }
                }
            }
            
            //rune
            NSString *runeString = [skillArray objectAtIndex:2];
            NSLog(@"rune = %@",runeString);
            if (runeString) {
                for (int i=0; i<[runeString length]; i++) {
                    NSString *runeKey = [runeString substringWithRange:NSMakeRange(i, 1)];
                    [runes removeObjectAtIndex:i];
                    [runes insertObject:runeKey atIndex:i];
                }
            }
        }
        needReset = NO;
    }
}

- (void) setInitiativeSkillButton:(NSInteger)index withSystemName:(NSString *)system withSkillName:(NSString *)name withSkillImage:(UIImage *)image withRuneName:(NSString *)rname withRuneImage:(UIImage *)rimage
{
    UIColor *color = [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:210.0/255.0 alpha:1.0];
    switch (index) {
        case 0:
            [mouseLeftSkill setText:system];
            [mouseLeftSkillName setTextColor:color];
            [mouseLeftSkillName setText:name];
            [mouseLeftSkillImage setImage:image];
            [mouseLeftRuneName setText:rname];
            [mouseLeftRuneImage setImage:rimage];
            break;
        case 1:
            [mouseRightSkill setText:system];
            [mouseRightSkillName setTextColor:color];
            [mouseRightSkillName setText:name];
            [mouseRightSkillImage setImage:image];
            [mouseRightRuneName setText:rname];
            [mouseRightRuneImage setImage:rimage];
            break;
        case 2:
            [numOneSkill setText:system];
            [numOneSkillName setTextColor:color];
            [numOneSkillName setText:name];
            [numOneSkillImage setImage:image];
            [numOneRuneName setText:rname];
            [numOneRuneImage setImage:rimage];
            break;
        case 3:
            [numTwoSkill setText:system];
            [numTwoSkillName setTextColor:color];
            [numTwoSkillName setText:name];
            [numTwoSkillImage setImage:image];
            [numTwoRuneName setText:rname];
            [numTwoRuneImage setImage:rimage];
            break;
        case 4:
            [numThreeSkill setText:system];
            [numThreeSkillName setTextColor:color];
            [numThreeSkillName setText:name];
            [numThreeSkillImage setImage:image];
            [numThreeRuneName setText:rname];
            [numThreeRuneImage setImage:rimage];
            break;
        case 5:
            [numFourSkill setText:system];
            [numFourSkillName setTextColor:color];
            [numFourSkillName setText:name];
            [numFourSkillImage setImage:image];
            [numFourRuneName setText:rname];
            [numFourRuneImage setImage:rimage];
            break;
    }
}

- (void) setPassiveSkillButton:(NSInteger)index withSkillName:(NSString *)name withSkillImage:(UIImage *)image
{
    UIColor *color = [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:210.0/255.0 alpha:1.0];
    switch (index) {
        case 0:
            [passiveSkillOneName setTextColor:color];
            [passiveSkillOneName setText:name];
            [passiveSkillOneImage setImage:image];
            break;
        case 1:
            [passiveSkillTwoName setTextColor:color];
            [passiveSkillTwoName setText:name];
            [passiveSkillTwoImage setImage:image];
            break;
        case 2:
            [passiveSkillThreeName setTextColor:color];
            [passiveSkillThreeName setText:name];
            [passiveSkillThreeImage setImage:image];
            break;
    }
}

- (void) setBoardView
{
    AppDelegate *mainDelegate = [[UIApplication sharedApplication] delegate];
    NSDictionary *class = [mainDelegate.heroSkillDataSource objectForKey:[classNameArray objectAtIndex:heroClass]];
    NSDictionary *skillType = nil;
    
    skillType = [class objectForKey:@"Initiative"];
    for (int i=0; i<[initiative count]; i++) {
        if (![[initiative objectAtIndex:i] isEqualToString:@"."]) {
            //skill
            NSDictionary *skill = [skillType objectForKey:[initiative objectAtIndex:i]];
            NSString *name = NSLocalizedString([skill objectForKey:@"name"],nil);
            NSString *system = NSLocalizedString([skill objectForKey:@"system"],nil);
            UIImage *image = [UIImage imageNamed:[skill objectForKey:@"image"]];
            //rune
            NSString *rname = nil;
            UIImage *rimage = nil;
            if (![[runes objectAtIndex:i] isEqualToString:@"."]) {
                NSDictionary *rune = [[skill objectForKey:@"runes"] objectForKey:[runes objectAtIndex:i]];
                rname = NSLocalizedString([rune objectForKey:@"name"],nil);
                rimage = [UIImage imageNamed:[rune objectForKey:@"image"]];
            }
            [self setInitiativeSkillButton:i withSystemName:system withSkillName:name withSkillImage:image withRuneName:rname withRuneImage:rimage];
        }
    }
    skillType = [class objectForKey:@"Passive"];
    for (int i=0; i<[passive count]; i++) {
        if (![[passive objectAtIndex:i] isEqualToString:@"."]) {
            NSDictionary *skill = [skillType objectForKey:[passive objectAtIndex:i]];
            NSString *name = NSLocalizedString([skill objectForKey:@"name"], nil);
            UIImage *image = [UIImage imageNamed:[skill objectForKey:@"image"]];
            [self setPassiveSkillButton:i withSkillName:name withSkillImage:image];
        }
    }
}

- (void)createHeroSkillDetailBoard
{
    switch (heroClass) {
        case 0:
            self.barbarianSkillBoard = [[[BarbarianSkillDetailViewController alloc] initWithNibName:@"BarbarianSkillDetailViewController" bundle:nil] autorelease];
            self.barbarianSkillBoard.view.frame = CGRectMake(0, 110, self.barbarianSkillBoard.view.frame.size.width, self.barbarianSkillBoard.view.frame.size.height);
            self.barbarianSkillBoard.view.tag = 13811150829;
            self.barbarianSkillBoard.heroClassString = [classNameArray objectAtIndex:heroClass];
            [self.barbarianSkillBoard setDelegate:self];
            [self.barbarianSkillBoard setVisible:NO];
            [[[UIApplication sharedApplication] keyWindow] addSubview:self.barbarianSkillBoard.view];
            currentSkillBoard = self.barbarianSkillBoard;
            [currentSkillBoard setSelectedButtonGroup:pages withTagGroup:tags];
            break;
        case 1:
            self.demonhunterSkillBoard = [[[DemonHunterSkillDetailViewController alloc] initWithNibName:@"DemonHunterSkillDetailViewController" bundle:nil] autorelease];
            self.demonhunterSkillBoard.view.frame = CGRectMake(0, 110, self.demonhunterSkillBoard.view.frame.size.width, self.demonhunterSkillBoard.view.frame.size.height);
            self.demonhunterSkillBoard.view.tag = 13811150829;
            self.demonhunterSkillBoard.heroClassString = [classNameArray objectAtIndex:heroClass];
            [self.demonhunterSkillBoard setDelegate:self];
            [self.demonhunterSkillBoard setVisible:NO];
            [[[UIApplication sharedApplication] keyWindow] addSubview:self.demonhunterSkillBoard.view];
            currentSkillBoard = self.demonhunterSkillBoard;
            [currentSkillBoard setSelectedButtonGroup:pages withTagGroup:tags];
            break;
        case 2:
            self.monkSkillBoard = [[[MonkSkillDetailViewController alloc] initWithNibName:@"MonkSkillDetailViewController" bundle:nil] autorelease];
            self.monkSkillBoard.view.frame = CGRectMake(0, 110, self.monkSkillBoard.view.frame.size.width, self.monkSkillBoard.view.frame.size.height);
            self.monkSkillBoard.view.tag = 13811150829;
            self.monkSkillBoard.heroClassString = [classNameArray objectAtIndex:heroClass];
            [self.monkSkillBoard setDelegate:self];
            [self.monkSkillBoard setVisible:NO];
            [[[UIApplication sharedApplication] keyWindow] addSubview:self.monkSkillBoard.view];
            currentSkillBoard = self.monkSkillBoard;
            [currentSkillBoard setSelectedButtonGroup:pages withTagGroup:tags];
            break;
        case 3:
            self.witchdoctorSkillBoard = [[[WitchDoctorSkillDetailViewController alloc] initWithNibName:@"WitchDoctorSkillDetailViewController" bundle:nil] autorelease];
            self.witchdoctorSkillBoard.view.frame = CGRectMake(0, 110, self.witchdoctorSkillBoard.view.frame.size.width, self.witchdoctorSkillBoard.view.frame.size.height);
            self.witchdoctorSkillBoard.view.tag = 13811150829;
            self.witchdoctorSkillBoard.heroClassString = [classNameArray objectAtIndex:heroClass];
            [self.witchdoctorSkillBoard setDelegate:self];
            [self.witchdoctorSkillBoard setVisible:NO];
            [[[UIApplication sharedApplication] keyWindow] addSubview:self.witchdoctorSkillBoard.view];
            currentSkillBoard = self.witchdoctorSkillBoard;
            [currentSkillBoard setSelectedButtonGroup:pages withTagGroup:tags];
            break;
        case 4:
            self.wizardSkillBoard = [[[WizardSkillDetailViewController alloc] initWithNibName:@"WizardSkillDetailViewController" bundle:nil] autorelease];
            self.wizardSkillBoard.view.frame = CGRectMake(0, 110, self.wizardSkillBoard.view.frame.size.width, self.wizardSkillBoard.view.frame.size.height);
            self.wizardSkillBoard.view.tag = 13811150829;
            self.wizardSkillBoard.heroClassString = [classNameArray objectAtIndex:heroClass];
            [self.wizardSkillBoard setDelegate:self];
            [self.wizardSkillBoard setVisible:NO];
            [[[UIApplication sharedApplication] keyWindow] addSubview:self.wizardSkillBoard.view];
            currentSkillBoard = self.wizardSkillBoard;
            [currentSkillBoard setSelectedButtonGroup:pages withTagGroup:tags];
            break;
        default:
            NSLog(@"you got a heroClass num error");
            break;
    }
}

- (void)makeButtonSelected:(UIButton *)button
{
    selectedButton = button;
    [selectedButton setSelected:YES];
}

- (void)makeButtonUnSelected
{
    [selectedButton setSelected:NO];
}


- (void)viewDidLoad
{
    //    NSLog(@"enter did");
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if (needReset) {
        [self resetBoard];
    }
    [heroAvatar setImage:[UIImage imageNamed:[imageNameArray objectAtIndex:(heroClass+5*heroSex)]]];
    [className setText:[classNameArray objectAtIndex:heroClass]];
    [self setBoardView];
    [self createHeroSkillDetailBoard];
    //    NSLog(@"out did");
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

- (IBAction)bt_initiativeSkillLeftPressed:(UIButton *)sender {
    if (currentSkillBoard.isHeroSkillDetailShown) {
        if ([sender isEqual:selectedButton]) {
            
        }
        else {
            //remove single detail view
            [currentSkillBoard removeDetailViewFromKeyWindow];
            [currentSkillBoard removeHighLightView];
            //if last view is different
            if (selectedButton.tag > 700) {
                //make change
                [currentSkillBoard setSelfViewToInitiative];
                [currentSkillBoard setDefaultPage:[[pages objectAtIndex:(sender.tag%660)] intValue] withSkillKey:[initiative objectAtIndex:(sender.tag%660)] withRuneKey:[runes objectAtIndex:(sender.tag%660)] withButtonIndex:(sender.tag%660) withTag:[[tags objectAtIndex:(sender.tag%660)] intValue]];
            }
            else {
                [currentSkillBoard setDefaultPage:[[pages objectAtIndex:(sender.tag%660)] intValue] withSkillKey:[initiative objectAtIndex:(sender.tag%660)] withRuneKey:[runes objectAtIndex:(sender.tag%660)] withButtonIndex:(sender.tag%660) withTag:[[tags objectAtIndex:(sender.tag%660)] intValue]];
            }
            [self makeButtonUnSelected];
        }
    }
    else {
        [currentSkillBoard removeHighLightView];
        [currentSkillBoard setDefaultPage:[[pages objectAtIndex:(sender.tag%660)] intValue] withSkillKey:[initiative objectAtIndex:(sender.tag%660)] withRuneKey:[runes objectAtIndex:(sender.tag%660)] withButtonIndex:(sender.tag%660) withTag:[[tags objectAtIndex:(sender.tag%660)] intValue]];
        [currentSkillBoard setSelfViewToInitiative];
        [currentSkillBoard moveToRightSide];
    }
    [self makeButtonSelected:sender];
}

- (IBAction)bt_initiativeSkillRightPressed:(UIButton *)sender {
    if (currentSkillBoard.isHeroSkillDetailShown) {
        if ([sender isEqual:selectedButton]) {
            
        }
        else {
            [currentSkillBoard removeDetailViewFromKeyWindow];
            [currentSkillBoard removeHighLightView];
            if (selectedButton.tag > 700) {
                [currentSkillBoard setSelfViewToInitiative];
                [currentSkillBoard setDefaultPage:[[pages objectAtIndex:(sender.tag%660)] intValue] withSkillKey:[initiative objectAtIndex:(sender.tag%660)] withRuneKey:[runes objectAtIndex:(sender.tag%660)] withButtonIndex:(sender.tag%660) withTag:[[tags objectAtIndex:(sender.tag%660)] intValue]];
            }
            else {
                [currentSkillBoard setDefaultPage:[[pages objectAtIndex:(sender.tag%660)] intValue] withSkillKey:[initiative objectAtIndex:(sender.tag%660)] withRuneKey:[runes objectAtIndex:(sender.tag%660)] withButtonIndex:(sender.tag%660) withTag:[[tags objectAtIndex:(sender.tag%660)] intValue]];
            }
            [self makeButtonUnSelected];
        }
    }
    else {
        [currentSkillBoard removeHighLightView];
        [currentSkillBoard setDefaultPage:[[pages objectAtIndex:(sender.tag%660)] intValue] withSkillKey:[initiative objectAtIndex:(sender.tag%660)] withRuneKey:[runes objectAtIndex:(sender.tag%660)] withButtonIndex:(sender.tag%660) withTag:[[tags objectAtIndex:(sender.tag%660)] intValue]];
        [currentSkillBoard setSelfViewToInitiative];
        [currentSkillBoard moveToLeftSide];
    }
    [self makeButtonSelected:sender];
}

- (IBAction)bt_passiveSkillPressed:(UIButton *)sender {    
    if(currentSkillBoard.isHeroSkillDetailShown)
    {
        if ([sender isEqual:selectedButton]) {
            
        }
        else {
            [currentSkillBoard removeDetailViewFromKeyWindow];
            [currentSkillBoard removeHighLightView];
            if (selectedButton.tag < 700) {
                [currentSkillBoard setSelfViewToPassive];
                [currentSkillBoard setPassiveBoard:[passive objectAtIndex:(sender.tag%880)] withButtonIndex:(sender.tag%880) withTag:[[tags objectAtIndex:(6 + (sender.tag%880))] intValue]];
            }
            else {
                [currentSkillBoard setPassiveBoard:[passive objectAtIndex:(sender.tag%880)] withButtonIndex:(sender.tag%880) withTag:[[tags objectAtIndex:(6 + (sender.tag%880))] intValue]];
            }
            [self makeButtonUnSelected];
        }
    }
    else {
        [currentSkillBoard removeHighLightView];
        [currentSkillBoard setPassiveBoard:[passive objectAtIndex:(sender.tag%880)] withButtonIndex:(sender.tag%880) withTag:[[tags objectAtIndex:(6 + (sender.tag%880))] intValue]];
        [currentSkillBoard setSelfViewToPassive];
        [currentSkillBoard moveToRightSide];
    }
    [self makeButtonSelected:sender];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    
    if ([touch view] != heroAvatar) {
        if (currentSkillBoard.isHeroSkillDetailShown) {
            [currentSkillBoard restoreViewLocation];
        }
    }
}

@end
