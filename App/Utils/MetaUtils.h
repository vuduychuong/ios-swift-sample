//
//  MetaUtils.h
//  Metadium
//
//  Created by han jinsik on 2018. 6. 12..
//  Copyright © 2018년 coinplug. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MetaUtils : NSObject

+ (UIImage *)getFullScreenShot:(UIView *)view;

+ (UIWindow *)topmostVisibleWindow;
+ (BOOL)isiPhone;


+ (CGFloat)screenWidth;
+ (CGFloat)screenHeight;

+ (BOOL)checkValidEmail:(NSString *)email;
+ (int)checkValidPassword:(NSString *)password;

/**
 * @brief 단말기의 UUID값을 추출.
 * @return 추출한 UUID.
 * @author jinsik han
 */
+ (NSString*)getUUID;

/**
 * @brief Vender ID를 추출.
 * @return 추출한 Vender ID.
 * @author jinsik han
 */
+ (NSString*)getVendorID;

/**
 * @brief platform 정보를 받아온다.
 * @return 추출한 platform 정보.
 * @author jinsik han
 */
+ (NSString*)getPlatform;


/**
 * @brief 단말기 OS 버전정보 받아온다.
 * @return 추출한 OS 버전정보.
 * @author jinsik han
 */
+ (NSString*)getSystemVersion;


+ (NSString*)getDeviceName;


+ (NSString*) toJSONString:(NSDictionary*)dictionary;


+ (NSString*) toJSONString:(NSDictionary*)dictionary
                  isPretty:(BOOL)isPretty;

+ (NSDictionary*) toDictionary:(NSString*)jsonString;

+ (NSInteger)isPhoneNum:(NSString *)phoneNum;


+ (BOOL)specialCheck:(NSString *)password;

+ (BOOL)numbersCheck:(NSString *)password;

+ (BOOL)charRange:(NSString *)password;


+ (NSMutableArray *)shuffleArr:(NSArray *)arr;


@end
