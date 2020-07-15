//
//  CPActivityIndicator.h
//  CPCubeDemo
//
//  Created by coinplug on 2018. 3. 8..
//  Copyright © 2018년 coinplug. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MetaActivityIndicator : NSObject {
    UIView *bgView_;
    UIActivityIndicatorView *activityView;
}

+ (MetaActivityIndicator *)sharedCPActivity;

- (void)start;
- (void)stop;
- (BOOL)isAnimating;

@end
