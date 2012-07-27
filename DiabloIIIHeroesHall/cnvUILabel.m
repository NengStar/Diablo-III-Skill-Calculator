//
//  cnvUILabel.m
//  Label
//
//  Created by xiong xiongwenjie on 11-8-2.
//  Copyright 2011 CareLand. All rights reserved.
//

#import "cnvUILabel.h"
#import <CoreText/CoreText.h>

@implementation cnvUILabel

@synthesize stringColor;
@synthesize keywordColor;
@synthesize list;

-(id) init
{
    if (self = [super init]) {
        self.text = nil;
        stringColor = nil;
        keywordColor = nil;
        list = [[NSMutableArray alloc] init];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.text = nil;
        stringColor = nil;
        keywordColor = nil;
        list = [[NSMutableArray alloc] init];
        // Initialization code.
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
}
*/

- (void)dealloc {
    [list release];
    [super dealloc];
}

//设置字体颜色和关键字的颜色
- (void) cnv_setUIlabelTextColor:(UIColor *) strColor 
                 andKeyWordColor: (UIColor *) keyColor
{
    self.stringColor = strColor;
    self.keywordColor = keyColor;
}
//设置关键字，并且调用保存关键字函数将关键字的Range存再list中。
- (void) cnv_setUILabelText:(NSString *)string andKeyWord:(NSString *)keyword
{
    if (self.text != string) {
        self.text = string;
    }
    [self saveKeywordRangeOfText:keyword];
}

//保存关键字再Text中的位置信息
- (void) saveKeywordRangeOfText:(NSString *)keyWord
{
    //有效性校验
    if (nil == keyWord) {
        return;
    }
    
    //将所有的字符位置存在list中
    int nLen = [keyWord length];
    for (int i = 0  ; i < nLen; i++) 
    {
        //按照所给的位置，长度，从keyword中截取子串
        NSString *strTemp = [keyWord substringWithRange:NSMakeRange(i, 1)];
        //获取单个关键字符在text中的位置
        NSString *strText = self.text;
        int TextLenth = [strText length];
        for (int j= 0; j<TextLenth; j++) {
            NSRange range = NSMakeRange(j,1);
            NSString * star = [strText substringWithRange:range];
            if ([star isEqualToString:strTemp]) {
                //                NSRange range = [strText rangeOfString:star];
                //由于结构体不能直接存到NSArray中，所以要转换一下。
                NSValue *value = [NSValue valueWithRange:range];
                
                if (range.length > 0) 
                {
                    [list addObject:value];
                }
            }
        }
        NSRange range = [strText rangeOfString:strTemp];
        //由于结构体不能直接存到NSArray中，所以要转换一下。
        NSValue *value = [NSValue valueWithRange:range];
        
        if (range.length > 0) 
        {
            [list addObject:value];
        }
        
    }
    
}


//设置颜色属性和字体属性
- (NSAttributedString *)illuminatedString:(NSString *)text 
                                     font:(UIFont *)AtFont{
	
    int len = [text length];
    //创建一个可变的属性字符串
    NSMutableAttributedString *mutaString = [[[NSMutableAttributedString alloc] initWithString:text] autorelease];
    //改变字符串 从1位 长度为1 这一段的前景色，即字的颜色。
/*    [mutaString addAttribute:(NSString *)(kCTForegroundColorAttributeName) 
                       value:(id)[UIColor darkGrayColor].CGColor 
                       range:NSMakeRange(1, 1)]; */
    [mutaString addAttribute:(NSString *)(kCTForegroundColorAttributeName)
                       value:(id)self.stringColor.CGColor
                       range:NSMakeRange(0, len)];
    
  
    
    if (self.keywordColor != nil)
    {
        for (NSValue *value in list) 
        {
         //   NSValue *value = [list objectAtIndex:i];
            NSRange keyRange = [value rangeValue];
            [mutaString addAttribute:(NSString *)(kCTForegroundColorAttributeName)
                                                    value:(id)self.keywordColor.CGColor
                                                    range:keyRange];
        }
    }

    
    //设置部分字段的字体大小与其他的不同
/*    CTFontRef ctFont = CTFontCreateWithName((CFStringRef)AtFont.fontName, 
                                            AtFont.pointSize, 
                                            NULL);
    [mutaString addAttribute:(NSString *)(kCTFontAttributeName) 
                       value:(id)ctFont 
                       range:NSMakeRange(0, 1)];*/
    
    //设置是否使用连字属性，这里设置为0，表示不使用连字属性。标准的英文连字有FI,FL.默认值为1，既是使用标准连字。也就是当搜索到f时候，会把fl当成一个文字。
    int nNumType = 0;
//    float fNum = 3.0;
    CFNumberRef cfNum = CFNumberCreate(NULL, kCFNumberIntType, &nNumType);
//    CFNumberRef cfNum2 = CFNumberCreate(NULL, kCFNumberFloatType, &fNum);
    [mutaString addAttribute:(NSString *)kCTLigatureAttributeName
                       value:(id)cfNum
                       range:NSMakeRange(0, len)];
    //空心字
//    [mutaString addAttribute:(NSString *)kCTStrokeWidthAttributeName value:(id)cfNum2 range:NSMakeRange(0, len)];
    
    CFRelease(cfNum);
    CTFontRef ctFont2 = CTFontCreateWithName((CFStringRef)AtFont.fontName, 
                                             AtFont.pointSize,
                                             NULL);
    [mutaString addAttribute:(NSString *)(kCTFontAttributeName) 
                       value:(id)ctFont2 
                       range:NSMakeRange(0, len)];
 //   CFRelease(ctFont);
    CFRelease(ctFont2);
    return [[mutaString copy] autorelease];
}

//重绘Text
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    if (self.text !=nil) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, 0.0, 0.0);//move
        CGContextScaleCTM(context, 1.0, -1.0);
        CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((/*__bridge*/  CFAttributedStringRef)[self illuminatedString:self.text font:self.font]);
        CGMutablePathRef pathRef = CGPathCreateMutable();
        CGPathAddRect(pathRef,NULL , CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height));//const CGAffineTransform *m
        CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), pathRef,NULL );//CFDictionaryRef frameAttributes
        CGContextTranslateCTM(context, 0, -self.bounds.size.height);
        CGContextSetTextPosition(context, 0, 0);
        CTFrameDraw(frame, context);
        CGContextRestoreGState(context);
        CGPathRelease(pathRef);
        CFRelease(framesetter);
        CFRelease(frame);
        UIGraphicsPushContext(context);
        
    }
}
@end
