//
//  HeroSkillBoardViewController.h
//  DiabloIIIHerosHall
//
//  Created by  on 12-5-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UINavigationController.h"
#import "AppDelegate.h"
#import "BarbarianSkillDetailViewController.h"
#import "DemonHunterSkillDetailViewController.h"
#import "MonkSkillDetailViewController.h"
#import "WitchDoctorSkillDetailViewController.h"
#import "WizardSkillDetailViewController.h"

@interface HeroSkillBoardViewController : UIViewController <HeroSkillDetailDelegate>
{
    IBOutlet UIImageView *heroAvatar;
    IBOutlet UILabel *className;
    NSArray *imageNameArray;
    NSArray *classNameArray;
    BOOL viewControllerWillTerminate;
@public
    NSInteger heroClass;
    NSInteger heroSex;
    HeroSkillDetailViewController *currentSkillBoard;
}

@property NSInteger heroClass;
@property NSInteger heroSex;

@property (nonatomic, retain) BarbarianSkillDetailViewController *barbarianSkillBoard;
@property (nonatomic, retain) DemonHunterSkillDetailViewController *demonhunterSkillBoard;
@property (nonatomic, retain) MonkSkillDetailViewController *monkSkillBoard;
@property (nonatomic, retain) WitchDoctorSkillDetailViewController *witchdoctorSkillBoard;
@property (nonatomic, retain) WizardSkillDetailViewController *wizardSkillBoard;

- (IBAction)bt_mouseLeftPressed:(UIButton *)sender;
- (IBAction)bt_mouseRightPressed:(UIButton *)sender;



@end
