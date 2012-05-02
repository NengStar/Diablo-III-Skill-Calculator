//
//  UINavigationController.m
//  DiabloIIIHerosHall
//
//  Created by  on 12-5-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UINavigationController.h"

@implementation UINavigationController (UINavigationController)

- (void)pushAnimationDidStop{}

- (void)pushViewController: (UIViewController*)controller  
    animatedWithTransition: (UIViewAnimationTransition)transition {  
    [self pushViewController:controller animated:NO];  
    
    [UIView beginAnimations:nil context:nil];  
    [UIView setAnimationDuration:0.5];  
    [UIView setAnimationDelegate:self];  
    [UIView setAnimationDidStopSelector:@selector(pushAnimationDidStop)];  
    [UIView setAnimationTransition:transition forView:self.view cache:YES];  
    [UIView commitAnimations];  
    
}  

- (UIViewController*)popViewControllerAnimatedWithTransition:(UIViewAnimationTransition)transition {  
    UIViewController* poppedController = [self popViewControllerAnimated:NO];  
    
    [UIView beginAnimations:nil context:NULL];  
    [UIView setAnimationDuration:0.5];  
    [UIView setAnimationDelegate:self];  
    [UIView setAnimationDidStopSelector:@selector(pushAnimationDidStop)];  
    [UIView setAnimationTransition:transition forView:self.view cache:NO];  
    [UIView commitAnimations];  
    
    return poppedController;  
}

@end
