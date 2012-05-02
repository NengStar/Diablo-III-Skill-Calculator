//
//  UINavigationController.h
//  DiabloIIIHerosHall
//
//  Created by  on 12-5-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (UINavigationController)


- (void)pushAnimationDidStop;  
- (void)pushViewController: (UIViewController*)controller animatedWithTransition: (UIViewAnimationTransition)transition;  
- (UIViewController*)popViewControllerAnimatedWithTransition:(UIViewAnimationTransition)transition; 
@end
