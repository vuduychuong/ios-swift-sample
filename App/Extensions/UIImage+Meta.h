//
//  UIImage+DDingdong.h
//  ddingdong
//
//  Created by DDingDong on 2016. 6. 8..
//  Copyright © 2016년 ddingdong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreImage/CoreImage.h>
#import <Accelerate/Accelerate.h>

@interface UIImage (Meta)

+ (UIImage*)imageWithColor:(UIColor*)color;

- (UIImage *)re_applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage;

@end
