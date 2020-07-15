//
//  CPActivityIndicator.m
//  CPCubeDemo
//
//  Created by coinplug on 2018. 3. 8..
//  Copyright © 2018년 coinplug. All rights reserved.
//

#import "MetaActivityIndicator.h"

#define DURATION    .9
#define MIN_ALPHA   .3
#define MAX_ALPHA   1.

static MetaActivityIndicator *sharedCPActivity_ = nil;

@implementation MetaActivityIndicator

+ (MetaActivityIndicator *)sharedCPActivity {
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        sharedCPActivity_ = [[self alloc] init];
    });
    
    return sharedCPActivity_;
}

- (instancetype)init {
    self = [super init];
    
    if (self) {
        CGSize size = [[UIScreen mainScreen] bounds].size;
        bgView_ = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
        [bgView_ setBackgroundColor:[UIColor colorWithWhite:.0 alpha:.6]];

        UIView *container = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
        container.backgroundColor = [UIColor clearColor];
        activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        activityView.center = bgView_.center;
        [container addSubview:activityView];
        [bgView_ addSubview:container];
    }
    
    return self;
}


- (void)start {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIWindow *window = [UIApplication sharedApplication].delegate.window;
        [window addSubview:self->bgView_];
        [self->activityView startAnimating];
    });
}

- (void)stop {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self->activityView stopAnimating];
        [self->bgView_ removeFromSuperview];
    });
}


- (BOOL)isAnimating {
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    
    if (bgView_.superview == window) {
        
        return YES;
    }
    
    return NO;
}

@end
