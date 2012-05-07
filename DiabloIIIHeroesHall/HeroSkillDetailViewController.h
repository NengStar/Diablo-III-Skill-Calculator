//
//  HeroSkillDetailViewController.h
//  DiabloIIIHerosHall
//
//  Created by  on 12-5-2.
//  Copyright (c) 2012年 Neng! Star. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SingleSkillDetailViewController.h"

#define NAME_FONT_SIZE 11.0f
#define DETAIL_FONT_SIZE 9.0f
#define CELL_CONTENT_WIDTH 136.0f
#define CELL_CONTENT_MARGIN 5.0f
#define RUNE_IMAGE_WIDTH 20.0f
#define RUNE_IMAGE_HEIGHT 20.0f

@protocol HeroSkillDetailDelegate

- (void)skillBoardDidFinishClosing;

@end

@interface HeroSkillDetailViewController : UIViewController
{
    
    id <HeroSkillDetailDelegate> delegate;
@public
    BOOL isHeroSkillDetailShown;
    NSInteger lastPage;
    NSInteger skillSelectedPage;
    NSInteger runeSelectedIndex;
}
@property NSInteger lastPage;
@property NSInteger skillSelectedPage;
@property NSInteger runeSelectedIndex;
@property BOOL isHeroSkillDetailShown;
@property (nonatomic,assign)id <HeroSkillDetailDelegate> delegate;
@property (nonatomic, retain)SingleSkillDetailViewController *singleSkillDetailViewController;

- (void)setVisible:(BOOL)visible;
- (void)moveToLeftSide;
- (void)moveToRightSide;
- (void)restoreViewLocation;
- (void)setSelfViewToPassive;
- (void)setSelfViewToInitiative;
- (void)addDetailViewToKeyWindow:(NSString *)skillType skillKey:(NSString *)skillKey;
- (void)removeDetailViewFromKeyWindow;
- (void)setDefaultCell:(NSInteger)index;

@end
