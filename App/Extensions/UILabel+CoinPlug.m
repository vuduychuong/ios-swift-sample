//
//  UILabel+CoinPlug.m
//  CPCubeDemo
//
//  Created by coinplug on 2018. 4. 17..
//  Copyright © 2018년 coinplug. All rights reserved.
//

#import "UILabel+CoinPlug.h"

@implementation UILabel (CoinPlug)

- (void)boldRange:(NSRange)range {
    if (![self respondsToSelector:@selector(setAttributedText:)]) {
        return;
    }
    NSMutableAttributedString *attributedText;
    if (!self.attributedText) {
        attributedText = [[NSMutableAttributedString alloc] initWithString:self.text];
    } else {
        attributedText = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    }
    
    [attributedText setAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"AppleSDGothicNeo-Bold" size:self.font.pointSize]} range:range];
    self.attributedText = attributedText;
}


- (void)boldSubstring:(NSString*)substring {
    NSRange range = [self.text rangeOfString:substring];
    [self boldRange:range];
}


- (void)differentSizeRange:(NSRange)range font:(UIFont *)font {
    if (![self respondsToSelector:@selector(setAttributedText:)]) {
        return;
    }
    NSMutableAttributedString *attributedText;
    if (!self.attributedText) {
        attributedText = [[NSMutableAttributedString alloc] initWithString:self.text];
    } else {
        attributedText = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    }
    [attributedText setAttributes:@{NSFontAttributeName:font} range:range];
    self.attributedText = attributedText;
}

- (void)differentSubString:(NSString *)substring font:(UIFont *)font {
    NSRange range = [self.text rangeOfString:substring];
    [self differentSizeRange:range font:font];
}



- (void)colorRange:(NSRange)range color:(UIColor *)color {
    if (![self respondsToSelector:@selector(setAttributedText:)]) {
        return;
    }
    
    NSMutableAttributedString *attributedText;
    if (!self.attributedText) {
        attributedText = [[NSMutableAttributedString alloc] initWithString:self.text];
    } else {
        attributedText = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    }
    [attributedText addAttribute:NSForegroundColorAttributeName value:color range:range];
    
    self.attributedText = attributedText;
}


- (void)colorSubstring:(NSString *)subString color:(UIColor *)color {
    NSRange range = [self.text rangeOfString:subString];
    [self colorRange:range color:color];
}

- (void)strikeRange:(NSRange)range {
    if (![self respondsToSelector:@selector(setAttributedText:)]) {
        return;
    }
    
    NSMutableAttributedString *attributedText;
    if (!self.attributedText) {
        attributedText = [[NSMutableAttributedString alloc] initWithString:self.text];
    } else {
        attributedText = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    }
    
    [attributedText addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInt:1] range:range];
    [attributedText addAttribute:NSBaselineOffsetAttributeName value:[NSNumber numberWithInt:0] range:range];//임시
    
    self.attributedText = attributedText;
}

- (void)strikeSubString:(NSString *)str {
    NSRange range = [self.text rangeOfString:str];
    
    [self strikeRange:range];
}


- (void)addUnderLine:(NSString *)str {
    if (![self respondsToSelector:@selector(setAttributedText:)]) {
        return;
    }
    NSMutableAttributedString *attributedText;
    if (!self.attributedText) {
        attributedText = [[NSMutableAttributedString alloc] initWithString:self.text];
    } else {
        attributedText = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    }
    
    NSRange range = [self.text rangeOfString:str];
    [attributedText addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:range];
    
    self.attributedText = attributedText;
}


- (void)addImage:(UIImage *)img title:(NSString *)title rect:(CGRect)rect {
    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] init];
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:title attributes:nil];
    [attribute appendAttributedString:str];
    
    NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
    attachment.image = img;
    attachment.bounds = rect;
    NSAttributedString *attributedIcon = [NSAttributedString attributedStringWithAttachment:attachment];
    [attribute appendAttributedString:attributedIcon];
    
    self.attributedText = attribute;
}


- (void)leftAddImage:(UIImage *)img title:(NSString *)title rect:(CGRect)rect {
    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] init];
    
    NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
    attachment.image = img;
    attachment.bounds = rect;
    NSAttributedString *attributedIcon = [NSAttributedString attributedStringWithAttachment:attachment];
    [attribute appendAttributedString:attributedIcon];
    
    
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:title attributes:nil];
    [attribute appendAttributedString:str];
    
    self.attributedText = attribute;
}


- (void)addLineSpacing:(CGFloat)space alignment:(NSTextAlignment)alignment {
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:space];
    [style setAlignment:alignment];
    
    NSAttributedString *attStr = [[NSAttributedString alloc] initWithString:self.text attributes:@{NSParagraphStyleAttributeName:style}];
    self.attributedText = attStr;
}

- (void)verticalCenterString:(NSString *)str space:(CGFloat)space {
    NSRange range = [self.text rangeOfString:str];
    [self verticalRange:range space:space];
}


- (void)verticalRange:(NSRange)range space:(CGFloat)space {
    if (![self respondsToSelector:@selector(setAttributedText:)]) {
        return;
    }
    
    NSMutableAttributedString *attributedText;
    if (!self.attributedText) {
        attributedText = [[NSMutableAttributedString alloc] initWithString:self.text];
    } else {
        attributedText = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    }
    [attributedText addAttribute:NSBaselineOffsetAttributeName value:@(space) range:range];
    
    self.attributedText = attributedText;
}

@end
