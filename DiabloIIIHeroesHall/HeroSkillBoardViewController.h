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
@protocol HeroSkillBoardViewDelegate

-(void) didFinishSaving;

@end

@interface HeroSkillBoardViewController : UIViewController <HeroSkillDetailDelegate>
{
    id<HeroSkillBoardViewDelegate> delegate;
    IBOutlet UIImageView *heroAvatar;
    IBOutlet UILabel *className;
    //system label
    IBOutlet UILabel *mouseLeftSkill;
    IBOutlet UILabel *mouseRightSkill;
    IBOutlet UILabel *numOneSkill;
    IBOutlet UILabel *numTwoSkill;
    IBOutlet UILabel *numThreeSkill;
    IBOutlet UILabel *numFourSkill;
    //name label
    IBOutlet UILabel *mouseLeftSkillName;
    IBOutlet UILabel *mouseRightSkillName;
    IBOutlet UILabel *numOneSkillName;
    IBOutlet UILabel *numTwoSkillName;
    IBOutlet UILabel *numThreeSkillName;
    IBOutlet UILabel *numFourSkillName;
    //rune label
    IBOutlet UILabel *mouseLeftRuneName;
    IBOutlet UILabel *mouseRightRuneName;
    IBOutlet UILabel *numOneRuneName;
    IBOutlet UILabel *numTwoRuneName;
    IBOutlet UILabel *numThreeRuneName;
    IBOutlet UILabel *numFourRuneName;
    //pskill label
    IBOutlet UILabel *passiveSkillOneName;
    IBOutlet UILabel *passiveSkillTwoName;
    IBOutlet UILabel *passiveSkillThreeName;
    //skill image
    IBOutlet UIImageView *mouseLeftSkillImage;
    IBOutlet UIImageView *mouseRightSkillImage;
    IBOutlet UIImageView *numOneSkillImage;
    IBOutlet UIImageView *numTwoSkillImage;
    IBOutlet UIImageView *numThreeSkillImage;
    IBOutlet UIImageView *numFourSkillImage;
    //rune image
    IBOutlet UIImageView *mouseLeftRuneImage;
    IBOutlet UIImageView *mouseRightRuneImage;
    IBOutlet UIImageView *numOneRuneImage;
    IBOutlet UIImageView *numTwoRuneImage;
    IBOutlet UIImageView *numThreeRuneImage;
    IBOutlet UIImageView *numFourRuneImage;
    //pskill image
    IBOutlet UIImageView *passiveSkillOneImage;
    IBOutlet UIImageView *passiveSkillTwoImage;
    IBOutlet UIImageView *passiveSkillThreeImage;
    
    NSArray *imageNameArray;
    NSArray *classNameArray;
    NSArray *skillSystemNameArray;
    NSArray *dataArray;
    UIButton *selectedButton;
    BOOL viewControllerWillTerminate;
    
    NSMutableArray *initiative;
    NSMutableArray *passive;
    NSMutableArray *runes;
    NSMutableArray *pages;
    NSMutableArray *tags;
@public
    BOOL needReset;
    NSInteger dataIndex;
    NSString *dataKey;
    NSInteger heroClass;
    NSInteger heroSex;
    NSString *heroName;
    NSString *battleTag;
    NSInteger server;
    NSString *skillData;
    HeroSkillDetailViewController *currentSkillBoard;
}

@property (nonatomic,assign)id<HeroSkillBoardViewDelegate> delegate;

@property NSInteger heroClass;
@property NSInteger heroSex;
@property BOOL needReset;

@property (nonatomic, retain) BarbarianSkillDetailViewController *barbarianSkillBoard;
@property (nonatomic, retain) DemonHunterSkillDetailViewController *demonhunterSkillBoard;
@property (nonatomic, retain) MonkSkillDetailViewController *monkSkillBoard;
@property (nonatomic, retain) WitchDoctorSkillDetailViewController *witchdoctorSkillBoard;
@property (nonatomic, retain) WizardSkillDetailViewController *wizardSkillBoard;

- (IBAction)bt_initiativeSkillLeftPressed:(UIButton *)sender;
- (IBAction)bt_initiativeSkillRightPressed:(UIButton *)sender;
- (IBAction)bt_passiveSkillPressed:(UIButton *)sender;

- (void)loadHeroData:(NSString *)data withIndex:(NSInteger)index;


@end
