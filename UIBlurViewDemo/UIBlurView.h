//
//  UIBlurView.h
//  UIBlurViewDemo
//
//  Created by taowang on 15/7/7.
//  Copyright © 2015年 Plague. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBlurView : UIImageView
- (void)attachView:(UIView *)sourceView;
- (void)setNeedsBlur;
@end
