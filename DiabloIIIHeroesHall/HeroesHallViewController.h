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

@interface HeroesHallViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
{
//    NSInteger currentCell;
    IBOutlet UITableView *hallTable;
}
- (IBAction)createHero:(id)sender;

@end
