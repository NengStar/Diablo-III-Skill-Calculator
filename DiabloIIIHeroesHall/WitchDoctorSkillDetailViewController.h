//
//  HeroSkillDetailViewController.h
//  DiabloIIIHerosHall
//
//  Created by  on 12-5-2.
//  Copyright (c) 2012年 Neng! Star. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeroSkillDetailViewController.h"
#import "AppDelegate.h"

@interface WitchDoctorSkillDetailViewController : HeroSkillDetailViewController <UIScrollViewDelegate ,UITableViewDelegate ,UITableViewDataSource>
{
    NSString *selectedSkillKey;
    NSString *selectedPSkillKey;
    IBOutlet UIScrollView *skillScroll;
    //    NSArray *runeList;
}
#pragma board views
@property (retain, nonatomic) IBOutlet UIView *initiative;
@property (retain, nonatomic) IBOutlet UIView *passive;
#pragma skill views
@property (retain, nonatomic) IBOutlet UIView *primary;
@property (retain, nonatomic) IBOutlet UIView *secondary;
@property (retain, nonatomic) IBOutlet UIView *defensive;
@property (retain, nonatomic) IBOutlet UIView *terror;
@property (retain, nonatomic) IBOutlet UIView *decay;
@property (retain, nonatomic) IBOutlet UIView *voodoo;
#pragma sub views
@property (retain, nonatomic) IBOutlet UITextView *runeTips;
@property (retain, nonatomic) IBOutlet UITableView *runeTable;
@property (retain, nonatomic) IBOutlet UIScrollView *skillScroll;
@property (retain, nonatomic) IBOutlet UIPageControl *skillPage;
@property (retain, nonatomic) IBOutlet UILabel *numOfSlot;
//@property (retain, nonatomic) NSArray *runeList;
#pragma Localization views


- (void)setSkillTableVisible:(BOOL)visible;
#pragma skill button action
- (IBAction)skillButtonPressed:(UIButton *)sender;
- (IBAction)pskillButtonPressed:(UIButton *)sender;

@end
