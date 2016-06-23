//
//  UIScrollView+FTScrollViewIndicatorView.m
//  Demo
//
//  Created by liufengting on 16/6/22.
//  Copyright © 2016年 liufengting. All rights reserved.
//

#import "UIScrollView+FTScrollViewIndicatorView.h"
#import <objc/runtime.h>

@interface UIScrollView () <UIScrollViewDelegate>

@property (nonatomic, strong)FTScrollViewIndicatorView *indicatorView;

@end

@implementation UIScrollView (FTScrollViewIndicatorView)

static char IndicatorViewKey;


-(UIView *)indicatorView
{
    return objc_getAssociatedObject(self, &IndicatorViewKey);
}

-(void)setIndicatorView:(UIView *)indicatorView
{
    objc_setAssociatedObject(self, &IndicatorViewKey, indicatorView, OBJC_ASSOCIATION_RETAIN);
}

-(void)addIndicatorViewWithframe:(CGRect)frame
{
    self.indicatorView = [[FTScrollViewIndicatorView alloc] initWithFrame:frame];
    self.indicatorView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    [self.indicatorView setupWithPageCount:((NSInteger)self.contentSize.width/self.frame.size.width) currentIndex:0];
    if (self.superview) {
        [self.superview addSubview:self.indicatorView];
    }
    self.delegate = self;
    [self addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    
}



- (void)observeValueForKeyPath:(NSString*)keyPath ofObject:(id)object change:(NSDictionary*)change context:(void*)context
{
    if ([keyPath isEqualToString:@"contentOffset"]) {
        NSString *new = [NSString stringWithFormat:@"%@",[change objectForKey:@"new"]];
        NSString *old = [NSString stringWithFormat:@"%@",[change objectForKey:@"old"]];
        if (new.length && old.length) {
            CGPoint newOffset = CGPointFromString(((NSString *)new));
            CGPoint oldOffset = CGPointFromString(((NSString *)old));
            [self.indicatorView transformWithNewOffset:newOffset.x oldOffSet:oldOffset.x pageSize:self.frame.size.width];
        }
    }
}

//-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//    NSInteger page = scrollView.contentOffset.x/scrollView.frame.size.width;
//    self.indicatorView.highlightedIndex = page;
////    [self.indicatorView setupWithPageCount:((NSInteger)self.contentSize.width/self.frame.size.width) currentIndex:page];
//}


@end
