//
//  JATransitionNavigationBar.m
//  JATransitionNavigationBar
//
//  Created by Janrin on 15/12/23.
//  Copyright © 2015年 Janrin. All rights reserved.
//

#import "JATransitionNavigationBar.h"
#import <objc/runtime.h>


#define kKeyScrollView @"transitionScrollView"
#define kKeyOffset @"transitionOffset"
#define kContentOffset @"contentOffset"
#define kFullNavigationBarHeight 64

@implementation UINavigationBar (JATransitionNavigationBar)

- (void)convertToTransitionBar:(UIScrollView *)scrollView useOffset:(CGFloat)offset {
    objc_setAssociatedObject(self, kKeyScrollView, scrollView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, kKeyOffset, @(offset), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [scrollView addObserver:self
          forKeyPath:kContentOffset
             options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld
             context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    UIScrollView *transitionScrollView = objc_getAssociatedObject(self, kKeyScrollView);
    CGFloat transitionOffset = [objc_getAssociatedObject(self, kKeyOffset) floatValue];
    CGFloat offset = transitionScrollView.contentOffset.y;
    CGFloat alpha = offset / transitionOffset;
    self.hidden = alpha < 0;
    alpha = MIN(0.99, MAX(0, alpha));
    UIColor *barTintColor = self.barTintColor;
    if (!barTintColor) {
        switch (self.barStyle) {
            case UIBarStyleDefault: {
                barTintColor = [UIColor whiteColor];
                break;
            }
            case UIBarStyleBlack: {
                barTintColor = [UIColor blackColor];
                break;
            }
            default:
                barTintColor = [UIColor blackColor];
                break;
        }
    }
    UIColor *color = [barTintColor colorWithAlphaComponent:alpha];
    [self setBackgroundImage:[self imageWithColor:color] forBarMetrics:UIBarMetricsDefault];
}

- (UIImage *)imageWithColor:(UIColor *)color {
    CGSize size = CGSizeMake(1, kFullNavigationBarHeight);
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

@end


