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
#define RUNE_IMAGE_SIZE 20.0f

@protocol HeroSkillDetailDelegate

- (void)skillBoardDidFinishClosing;
- (void)initiativeSkillSelected:(NSString *)heroClasses withSkillKey:(NSString *)skillKey withPage:(NSNumber *)page withTag:(NSNumber *)tag;
- (void)runeSelected:(NSString *)heroClasses withSkillKey:(NSString *)skillKey withRuneKey:(NSString *)runeKey;
- (void)passiveSkillSelected:(NSString *)heroClasses withPSkillKey:(NSString *)pskillKey withTag:(NSNumber *)tag;

@end

@interface HeroSkillDetailViewController : UIViewController
{
    
    id <HeroSkillDetailDelegate> delegate;
@public
    BOOL isHeroSkillDetailShown;
    UIButton *selectedSkillButton;
    UIButton *selectedPSkillButton;
    NSInteger lastPage;
    NSInteger skillSelectedPage;
    NSString *selectedRuneKey;
    NSInteger runeSelectedIndex;
    NSString *heroClassString;
    NSInteger skillButtonGroupIndex;
    NSInteger pskillButtonGroupIndex;
    NSInteger skillButtonGroupTag;
    NSInteger pskillButtonGroupTag;
    NSMutableArray *selectSkillButtonGroup;
    NSMutableArray *selectPSkillButtonGroup;
}
@property NSInteger lastPage;
@property NSInteger skillSelectedPage;
@property NSInteger runeSelectedIndex;
@property NSInteger skillButtonGroupIndex;
@property NSInteger pskillButtonGroupIndex;
@property NSInteger skillButtonGroupTag;
@property NSInteger pskillButtonGroupTag;
@property BOOL isHeroSkillDetailShown;
@property (nonatomic,retain)NSString *heroClassString;
@property (nonatomic,assign)id <HeroSkillDetailDelegate> delegate;
@property (nonatomic, retain)SingleSkillDetailViewController *singleSkillDetailViewController;

- (void)setVisible:(BOOL)visible;
- (void)moveToLeftSide;
- (void)moveToRightSide;
- (void)restoreViewLocation;
- (void)setSelfViewToPassive;
- (void)setSelfViewToInitiative;
- (void)addDetailViewToKeyWindow:(NSString *)heroClass skillType:(NSString *)skillType skillKey:(NSString *)skillKey hasStory:(BOOL)hasStory;
- (void)removeDetailViewFromKeyWindow;
- (void)setDefaultCell:(NSInteger)index;
- (void)setDefaultPage:(NSInteger)page withSkillKey:(NSString *)skillKey withRuneKey:(NSString *)runeKey withButtonIndex:(NSInteger)index withTag:(NSInteger)tag;
- (void)setPassiveBoard:(NSString *)pskillKey withButtonIndex:(NSInteger)index withTag:(NSInteger)tag;

- (void)setSelectedButtonGroup:(NSMutableArray *)viewPage withTagGroup:(NSMutableArray *)tagGroup;

- (void)removeHighLightView;

@end
