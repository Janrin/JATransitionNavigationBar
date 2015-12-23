//
//  JATransitionNavigationBar.h
//  JATransitionNavigationBar
//
//  Created by Janrin on 15/12/23.
//  Copyright © 2015年 Janrin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (JATransitionNavigationBar)

- (void)convertToTransitionBar:(UIScrollView *)scrollView useOffset:(CGFloat)offset;

@end
