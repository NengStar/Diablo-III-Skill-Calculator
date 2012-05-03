//
//  HeroSkillDetailViewController.h
//  DiabloIIIHerosHall
//
//  Created by  on 12-5-2.
//  Copyright (c) 2012年 Neng! Star. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeroSkillDetailViewController.h"

@interface BarbarianSkillDetailViewController : HeroSkillDetailViewController

#pragma board views
@property (retain, nonatomic) IBOutlet UIView *initiative;
@property (retain, nonatomic) IBOutlet UIView *passive;
@property (retain, nonatomic) IBOutlet UIView *detail;
#pragma skill views
@property (retain, nonatomic) IBOutlet UIView *primary;
@property (retain, nonatomic) IBOutlet UIView *secondary;
@property (retain, nonatomic) IBOutlet UIView *defensive;
@property (retain, nonatomic) IBOutlet UIView *might;
@property (retain, nonatomic) IBOutlet UIView *tactics;
@property (retain, nonatomic) IBOutlet UIView *rage;
#pragma sub views
@property (retain, nonatomic) IBOutlet UITextView *runeTips;
@property (retain, nonatomic) IBOutlet UITableView *runeTable;
@property (retain, nonatomic) IBOutlet UIScrollView *skillScroll;
@property (retain, nonatomic) IBOutlet UIPageControl *skillPage;
#pragma Localization views
@end
