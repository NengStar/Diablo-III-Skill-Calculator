//
//  HeroSkillDetailViewController.h
//  DiabloIIIHerosHall
//
//  Created by  on 12-5-2.
//  Copyright (c) 2012年 Neng! Star. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SingleSkillDetailViewController.h"

@protocol HeroSkillDetailDelegate

- (void)skillBoardDidFinishClosing;

@end

@interface HeroSkillDetailViewController : UIViewController <UIScrollViewDelegate ,UITableViewDelegate ,UITableViewDataSource>
{
    
    id <HeroSkillDetailDelegate> delegate;
@public
    BOOL isHeroSkillDetailShown;
    NSInteger lastPage;
    NSInteger skillSelectedPage;
}
@property NSInteger lastPage;
@property NSInteger skillSelectedPage;
@property BOOL isHeroSkillDetailShown;
@property (nonatomic,assign)id <HeroSkillDetailDelegate> delegate;
@property (nonatomic, retain)SingleSkillDetailViewController *singleSkillDetailViewController;

- (void)setVisible:(BOOL)visible;
- (void)moveToLeftSide;
- (void)moveToRightSide;
- (void)restoreViewLocation;
- (void)setSelfViewToPassive;
- (void)setSelfViewToInitiative;
- (void)addDetailViewToKeyWindow;
- (void)removeDetailViewFromKeyWindow;

@end
