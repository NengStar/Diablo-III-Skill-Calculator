//
//  HeroesHallViewController.h
//  DiabloIIIHerosHall
//
//  Created by  on 12-4-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UINavigationController.h"
#import "HeroRiseViewController.h"
#import "AppDelegate.h"
#import "HeroSkillBoardViewController.h"

@interface HeroesHallViewController : UIViewController<UITableViewDelegate, UITableViewDataSource,HeroSkillBoardViewDelegate>
{
    IBOutlet UITableView *hallTable;
    IBOutlet UIImageView *rectImage;
}
- (IBAction)createHero:(id)sender;

@end
