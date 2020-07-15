//
//  MetaUtils.m
//  Metadium
//
//  Created by han jinsik on 2018. 6. 12..
//  Copyright © 2018년 coinplug. All rights reserved.
//

#import "MetaUtils.h"
//#import "UIDevice-Hardware.h"
#include <sys/socket.h>
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>

@implementation MetaUtils


+ (UIImage *)getFullScreenShot:(UIView *)view {
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        //레티나일 경우
        UIGraphicsBeginImageContextWithOptions(window.bounds.size, NO, [UIScreen mainScreen].scale);
        [window drawViewHierarchyInRect:window.bounds afterScreenUpdates:NO];
    } else {
        //레티나가 아닐 경우
        UIGraphicsBeginImageContext(view.bounds.size);
        [window drawViewHierarchyInRect:window.bounds afterScreenUpdates:NO];
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIWindow *)topmostVisibleWindow {
    
    NSArray<__kindof UIWindow *> *wins = [[UIApplication sharedApplication] windows];
    
    UIWindow *topmostVisibleWindow = nil;
    
    for (NSInteger i = [wins count]-1; i >= 0; i--) {
        
        UIWindow *window = wins[i];
        BOOL isBlank = NO;
        
        if ([window isKindOfClass:NSClassFromString(@"UIRemoteKeyboardWindow")]) {
            for(UIView* subView in window.subviews) {
                if([subView isKindOfClass:NSClassFromString(@"UIInputSetHostView")]) {
                    for(UIView* subsubView in subView.subviews) {
                        if([subsubView isKindOfClass:NSClassFromString(@"UIInputSetHostView")]) {
                            if ([subsubView.subviews count] == 0) {
                                [window removeFromSuperview];
                                isBlank = YES;
                                
                                break;
                            }
                        }
                    }
                }
            }
        }
        
        if (isBlank) {
            continue;
        }
        
        if (wins[i].hidden == NO && isBlank == NO) {
            topmostVisibleWindow = wins[i];
            break;
        }
    }
    return topmostVisibleWindow;
}


+ (BOOL)isiPhone
{
    return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone;
}

+ (CGFloat)screenWidth {
    return [UIScreen mainScreen].bounds.size.width;
}

+ (CGFloat)screenHeight {
    return [UIScreen mainScreen].bounds.size.height;
}


+ (BOOL)checkValidEmail:(NSString *)email {
    NSString *emailRegex =
    @"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
    @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
    @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
    @"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
    @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
    @"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
    @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES[c] %@", emailRegex];
    
    return [emailTest evaluateWithObject:email];
}


/**
 * @brief 단말기의 UUID값을 추출.
 * @return 추출한 UUID.
 * @author jinsik han
 */
+ (NSString*)getUUID{
    NSString * uuid = [[NSUUID UUID] UUIDString];
    
    return uuid;
}

/**
 * @brief Vender ID를 받아온다.
 * @return 추출한 Vender ID.
 * @author jinsik han
 */
+ (NSString*)getVendorID{
    return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}

/**
 * @brief platform 정보를 받아온다.
 * @return 추출한 platform 정보.
 * @author jinsik han
 */
+ (NSString*)getPlatform{
    //    return [[UIDevice currentDevice] platform];
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    return platform;
}

/**
 * @brief platform 정보를 알기쉬운 단말기 정보로 변환하여 받아온다.
 * @return 추출한 단말기 정보.
 * @author jinsik han
 */
//+ (NSString*)getPlatformName{
//    return [[UIDevice currentDevice] platformString];
//}

/**
 * @brief 단말기 OS 버전정보 받아온다.
 * @return 추출한 OS 버전정보.
 * @author jinsik han
 */
+ (NSString*)getSystemVersion{
    return [[UIDevice currentDevice] systemVersion];
}

/**
 * @brief Device에 설정된 단말기 이름 정보를 받아온다.
 * @return 추출한 단말기 이름.
 * @author jinsik han
 */
+ (NSString*)getDeviceName{
    return [[UIDevice currentDevice] name];
}



/**
 * @brief NSDictionary의 값을 JSON문자열로 변환해 준다.
 * @return 변환 된 JSON 문자열.
 * @author jinsik han
 */
+ (NSString*) toJSONString:(NSDictionary*)dictionary{

    NSString *jsonString = @"";
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary
                                                       options:0
                                                         error:&error];

    if (!jsonData) {
        
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }

    return jsonString;
}

/**
 * @brief NSDictionary의 값을 JSON문자열로 변환해 준다.
 * @param dictionary 변환 할 NSDictionary.
 * @param isPretty NSJSONWritingPrettyPrinted 옵션을 줄지 여부
 * @return 변환 된 JSON 문자열
 * @author jinsik han
 */
+ (NSString*) toJSONString:(NSDictionary*)dictionary
                  isPretty:(BOOL)isPretty
{
    NSString *jsonString = @"";
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary
                                                       options:(NSJSONWritingOptions) (isPretty ? NSJSONWritingPrettyPrinted : 0)
                                                         error:&error];

    if (!jsonData) {
        
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }

    return jsonString;
}

/**
 * @brief jsonString을 NSDictionary로 변환하여 반환한다.
 * @return 변환된 NSDictionary.
 * @author jinsik han
 */
+ (NSDictionary*) toDictionary:(NSString*)jsonString{
    NSError *error;
    NSData *objectData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:objectData
                                                               options:NSJSONReadingMutableContainers
                                                                 error:&error];

    if (!dictionary) {
        
    }
    return dictionary;
}

+ (NSInteger)isPhoneNum:(NSString *)phoneNum {
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^01[0,1,6,7,8,9]{1}[0-9]{3,4}[0-9]{4}$" options:0 error:&error];
    NSUInteger numberOfMatches = [regex numberOfMatchesInString:phoneNum options:0 range:NSMakeRange(0, phoneNum.length)];
    
    
    return numberOfMatches;
}

+ (int)checkValidPassword:(NSString *)password {
    if (password == nil) return 1;
    
    if (password.length < 8) return 1;
    
    // number?
    NSString *__numbers = [[password componentsSeparatedByCharactersInSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]] componentsJoinedByString:@""];
    if (__numbers.length <= 0) return 1;
    
    // 대소문자 check
    NSRange lowercaseCharRange = [password rangeOfCharacterFromSet:[NSCharacterSet lowercaseLetterCharacterSet]];
    if (lowercaseCharRange.location == NSNotFound) {
        return 0;
    }

    NSRange uppercaseCharRange = [password rangeOfCharacterFromSet:[NSCharacterSet uppercaseLetterCharacterSet]];
    if (uppercaseCharRange.location == NSNotFound) {
        return 0;
    }
    
    // letters
    NSString *__letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSCharacterSet *__notLetters = [[NSCharacterSet characterSetWithCharactersInString:__letters] invertedSet];
    NSString *__engletter = [[password componentsSeparatedByCharactersInSet:__notLetters] componentsJoinedByString:@""];
    if (__engletter.length <= 0) return 1;
    
    // 혀용하는 특수문자
    //! " # $ % & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~
    // special chars
    NSString *__special = @"!\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~";
    
    NSCharacterSet *__notSpecial = [[NSCharacterSet characterSetWithCharactersInString:__special] invertedSet];
    NSString *__schrs = [[password componentsSeparatedByCharactersInSet:__notSpecial] componentsJoinedByString:@""];
    if (__schrs.length <= 0) return 1;
    
    return 0;
}

+ (BOOL)specialCheck:(NSString *)password {
    NSString *__special = @"!\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~";
    
    NSCharacterSet *__notSpecial = [[NSCharacterSet characterSetWithCharactersInString:__special] invertedSet];
    NSString *__schrs = [[password componentsSeparatedByCharactersInSet:__notSpecial] componentsJoinedByString:@""];
    if (__schrs.length <= 0) return NO;
    
    return YES;
}

+ (BOOL)numbersCheck:(NSString *)password {
    NSString *__numbers = [[password componentsSeparatedByCharactersInSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]] componentsJoinedByString:@""];
    
    if (__numbers.length <= 0) {
        return NO;
    }
    
    return YES;
}

+ (BOOL)charRange:(NSString *)password {
    // 대소문자 check
    NSRange lowercaseCharRange = [password rangeOfCharacterFromSet:[NSCharacterSet lowercaseLetterCharacterSet]];
    if (lowercaseCharRange.location == NSNotFound) {
        return NO;
    }
    
    NSRange uppercaseCharRange = [password rangeOfCharacterFromSet:[NSCharacterSet uppercaseLetterCharacterSet]];
    if (uppercaseCharRange.location == NSNotFound) {
        return NO;
    }
    
    return YES;
}


+ (NSMutableArray *)shuffleArr:(NSArray *)arr {
    NSMutableArray *exchangeArr = [[NSMutableArray alloc] initWithArray:arr];
    NSUInteger count = [exchangeArr count];
    
    for (NSUInteger i = 0; i < count; ++i) {
        NSInteger nElements = count - i;
        NSInteger n = (arc4random() % nElements) + i;
        [exchangeArr exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
    
    return exchangeArr;
}


@end
