//
//  HeroSkillDetailViewController.h
//  DiabloIIIHerosHall
//
//  Created by  on 12-5-2.
//  Copyright (c) 2012年 Neng! Star. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HeroSkillDetailDelegate

- (void)skillBoardDidFinishClosing;

@end

@interface HeroSkillDetailViewController : UIViewController
{
    id <HeroSkillDetailDelegate> delegate;
    @public
        BOOL isHeroSkillDetailShown;
}

@property BOOL isHeroSkillDetailShown;
@property (nonatomic,assign)id <HeroSkillDetailDelegate> delegate;

- (void)setVisible:(BOOL)visible;
- (void)moveToLeftSide;
- (void)moveToRightSide;
- (void)restoreViewLocation;

@end
