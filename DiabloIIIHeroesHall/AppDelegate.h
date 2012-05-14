//
//  AppDelegate.h
//  DiabloIIIHerosHall
//
//  Created by  on 12-4-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UINavigationController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
@public
    NSDictionary *heroSkillDataSource;
    NSMutableArray *savedData;
}

@property (retain, nonatomic) IBOutlet UIWindow *window;
@property (retain, nonatomic) IBOutlet UINavigationController *navigationController;

@property (retain, nonatomic) NSDictionary *heroSkillDataSource;
@property (retain, nonatomic) NSMutableArray *savedData;

@end
