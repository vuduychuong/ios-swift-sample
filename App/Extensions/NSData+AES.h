/*
 http://www.imcore.net | hosihito@gmail.com
 Developer. Kyoungbin Lee
 2012.05.25

 AES256 EnCrypt / DeCrypt
*/

//#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface NSData (AES)
- (NSData*)AES256EncryptWithKey:(NSString*)key;
- (NSData*)AES256DecryptWithKey:(NSString*)key;
@end
