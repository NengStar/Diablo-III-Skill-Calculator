//
//  AppDelegate.m
//  DiabloIIIHerosHall
//
//  Created by  on 12-4-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize navigationController = _navigationController;
@synthesize heroSkillDataSource = _heroSkillDataSource;

- (void)dealloc
{
    [_window release];
    [_navigationController release];
    [_heroSkillDataSource release];
    [super dealloc];
}

-(void)customizeAppearance{

    UIImage *bg_bar = [UIImage imageNamed:@"bg_topbar"];
    //set the background image for *all* UINavigationBars为所有导航栏设置背景图片
    [[UINavigationBar appearance]setBackgroundImage:bg_bar forBarMetrics:UIBarMetricsDefault];
    
//    //customize the title text for *all* UINavigationBars为所有导航栏设置标题文本
    [[UINavigationBar appearance]setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIColor colorWithRed:243.0/255.0 green:171.0/255.0 blue:86.0/255.0 alpha:1.0],
      UITextAttributeTextColor,
      [UIColor colorWithRed:68.0/255.0 green:49.0/255.0 blue:27.0/255.0 alpha:0.8],
      UITextAttributeTextShadowColor,
      [NSValue valueWithUIOffset:UIOffsetMake(0, 1)],
      UITextAttributeTextShadowOffset,
      [UIFont fontWithName:@"Arial"size:12.0],
      UITextAttributeFont,
      nil]];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self customizeAppearance];
    NSString *dataPath = [[NSBundle mainBundle] pathForResource:@"HeroSkillDataSource" ofType:@"plist"];
    self.heroSkillDataSource = [[[NSDictionary alloc] initWithContentsOfFile:dataPath] autorelease];
    [self.window addSubview:self.navigationController.view];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
