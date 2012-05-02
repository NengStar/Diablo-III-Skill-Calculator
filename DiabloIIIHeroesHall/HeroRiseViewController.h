//
//  HeroRiseViewController.h
//  DiabloIIIHerosHall
//
//  Created by  on 12-4-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <Foundation/Foundation.h>
#import "UINavigationController.h"
#import "HeroSkillBoardViewController.h"

@interface HeroRiseViewController : UIViewController <UIWebViewDelegate, UIScrollViewDelegate>
{
    
//    UIWebView *heroStage;
//    NSData *heroGifData;
    IBOutlet UITextView *heroInfo;
    IBOutlet UILabel *heroClass;
    IBOutlet UIActivityIndicatorView *loadView;
    IBOutlet UIImageView *heroRect;
    IBOutlet UIScrollView *heroScroll;
    IBOutlet UIPageControl *heroPage;
    IBOutlet UIButton *male;
    IBOutlet UIButton *female;
//    NSMutableArray *heroClassArray;
    NSArray *imageNameArray;
    NSArray *classNameArray;
    NSInteger lastClass;
    NSInteger currentClass;
    NSInteger currentSex;
    NSInteger lastSex;
@public
//    HeroSkillBoardViewController *_heroSkillBoardViewController;
}
- (IBAction)maleSelected:(UIButton *)sender;
- (IBAction)femaleSelected:(UIButton *)sender;
- (IBAction)nextPage:(UIButton *)sender;

@end
