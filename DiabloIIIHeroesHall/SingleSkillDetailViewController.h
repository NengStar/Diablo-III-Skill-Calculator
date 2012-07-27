//
//  SingleSkillDetailViewController.h
//  DiabloIIIHeroesHall
//
//  Created by  on 12-5-4.
//  Copyright (c) 2012年 Neng! Star. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cnvUILabel.h"

@interface SingleSkillDetailViewController : UIViewController
{
    NSString *heroClass;
    NSString *skillType;
    NSString *skillKey;
    BOOL hasStory;
}

@property BOOL isSingleSkillDetailShown;
@property(nonatomic,retain)NSString *skillType;
@property(nonatomic,retain)NSString *skillKey;
@property(nonatomic,retain)NSString *heroClass;
@property BOOL hasStory;
@end
