//
//  UILabel+CoinPlug.h
//  CPCubeDemo
//
//  Created by coinplug on 2018. 4. 17..
//  Copyright © 2018년 coinplug. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (CoinPlug)

- (void) boldSubstring: (NSString*) substring;
- (void) boldRange: (NSRange) range;

- (void)differentSizeRange:(NSRange)range font:(UIFont *)font;
- (void)differentSubString:(NSString *)substring font:(UIFont *)font;

- (void) colorSubstring:(NSString *)subString color:(UIColor *)color;
- (void) colorRange:(NSRange)range color:(UIColor *)color;

- (void)strikeSubString:(NSString *)str;

- (void)addUnderLine:(NSString *)str;

- (void)addImage:(UIImage *)img title:(NSString *)title rect:(CGRect)rect;

- (void)leftAddImage:(UIImage *)img title:(NSString *)title rect:(CGRect)rect;

- (void)addLineSpacing:(CGFloat)space alignment:(NSTextAlignment)alignment;

- (void)verticalCenterString:(NSString *)str space:(CGFloat)space;

@end
