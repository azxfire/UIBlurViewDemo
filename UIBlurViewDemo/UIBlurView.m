//
//  UIBlurView.m
//  UIBlurViewDemo
//
//  Created by taowang on 15/7/7.
//  Copyright © 2015年 Plague. All rights reserved.
//

#import "UIBlurView.h"
#import <GPUImage/GPUImage.h>
@implementation UIBlurView
{
    __weak UIView *sourceView_;
    BOOL wantRefresh_;
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //add notification
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationBecameActive) name: UIApplicationDidBecomeActiveNotification object:nil];
    }
    return self;
}
-(void)attachView:(UIView *)sourceView
{
    sourceView_ = sourceView;
}
-(void)setNeedsBlur
{
    if (sourceView_ == nil) return;
    if ([UIApplication sharedApplication].applicationState != UIApplicationStateActive) {
        wantRefresh_ = YES;
        return;
    }
    CGRect rect = sourceView_.frame;
    UIGraphicsBeginImageContextWithOptions(rect.size, YES, 0.0f);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [sourceView_.layer renderInContext:context];
    UIImage *viewSnapshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    if (viewSnapshot) {
        GPUImageiOSBlurFilter *blurFilter = [[GPUImageiOSBlurFilter alloc] init];
        blurFilter.blurRadiusInPixels = 4.f;
        blurFilter.saturation = .85f;
        blurFilter.downsampling = 2.f;
        
        @try {
            self.image = [blurFilter imageByFilteringImage:viewSnapshot];
        }
        @catch (NSException *exception) {
//            SLYAssert(NO, @"Error blurring the snapshot: %@", exception);
        }
    }
}
- (void)applicationBecameActive {
    if (wantRefresh_ == YES) {
        wantRefresh_ = NO;
        [self setNeedsBlur];
    }
}
@end
