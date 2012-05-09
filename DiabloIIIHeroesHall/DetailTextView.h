//
//  DetailTextView.h
//  
//
//  Created by Mac Pro on 4/27/12.
//  Copyright (c) 2012 Dawn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailTextView : UILabel
{
    NSMutableAttributedString *resultAttributedString;
}
-(void)setKeyWordTextArray:(NSArray *)keyWordArray WithFont:(UIFont *)font AndColor:(UIColor *)keyWordColor;
-(void)setText:(NSString *)text WithFont:(UIFont *)font AndColor:(UIColor *)color;

@end
