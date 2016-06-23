//
//  FTScrollViewIndicatorView.m
//  Demo
//
//  Created by liufengting on 16/6/22.
//  Copyright © 2016年 liufengting. All rights reserved.
//

#import "FTScrollViewIndicatorView.h"

/**
 *  FTScrollViewIndicatorView
 */

@interface FTScrollViewIndicatorView ()

@property (nonatomic, strong)UIButton *centerButton;
@property (nonatomic, assign)NSInteger totalCount;


@end

@implementation FTScrollViewIndicatorView

@synthesize normaTintColor = _normaTintColor;
@synthesize highLightedTintColor = _highLightedTintColor;


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
//        self.centerButton.frame = CGRectMake((frame.size.width - FTScrollViewIndicatorViewDefaultHightLightItemSize)/2, (frame.size.height - FTScrollViewIndicatorViewDefaultMargin)/2, FTScrollViewIndicatorViewDefaultHightLightItemSize, FTScrollViewIndicatorViewDefaultHightLightItemSize);
//        
//
//        
    }
    return self;
}




-(UIButton *)centerButton
{
    if (!_centerButton) {
        _centerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _centerButton.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        
    }
    return _centerButton;
}

-(UIColor *)normaTintColor
{
    if (!_normaTintColor) {
        _normaTintColor = [UIColor redColor];
    }
    return _normaTintColor;
}

-(void)setNormaTintColor:(UIColor *)normaTintColor
{
    _normaTintColor = normaTintColor;
    
}
-(UIColor *)highLightedTintColor
{
    if (!_highLightedTintColor) {
        _highLightedTintColor = [UIColor redColor];
    }
    return _highLightedTintColor;
}
-(void)setHighLightedTintColor:(UIColor *)highLightedTintColor
{
    _highLightedTintColor = highLightedTintColor;

}


-(void)setupWithPageCount:(NSInteger)pageCount currentIndex:(NSInteger)currentIndex
{
    
    _highlightedIndex = currentIndex;
    _totalCount = pageCount;

    for (FTScrollViewIndicatorViewItem *item in self.subviews) {
        [item removeFromSuperview];
    }
    
    for (NSInteger i = 0; i < pageCount; i++) {
        
        UIColor *itemColor = i == currentIndex ? self.highLightedTintColor : self.normaTintColor;
        
        FTScrollViewIndicatorViewItem *item = [[FTScrollViewIndicatorViewItem alloc] initWithFrame:[self getRectForIndicatorWithIndex:i currentHighlightIndex:currentIndex]];
        item.backgroundColor = [UIColor clearColor];
        item.indicatorColor = itemColor;
        item.tag = i;
        [self addSubview:item];
        
    }
}

-(CGRect)getRectForIndicatorWithIndex:(NSInteger)itemIndex currentHighlightIndex:(NSInteger)currentHighlightIndex
{
    CGFloat buttonX = (self.frame.size.width - FTScrollViewIndicatorViewDefaultHightLightItemSize)/2;

    CGFloat itemX = 0;
    CGFloat itemY = (self.frame.size.height - FTScrollViewIndicatorViewDefaultItemSize)/2;
    CGFloat itemWidth = FTScrollViewIndicatorViewDefaultItemSize;
    CGFloat itemHight = FTScrollViewIndicatorViewDefaultItemSize;
    
    if (itemIndex < currentHighlightIndex) {
        
        itemX = buttonX - (FTScrollViewIndicatorViewItemMargin + FTScrollViewIndicatorViewDefaultItemSize)*(currentHighlightIndex - itemIndex);
        
    }else if (itemIndex == currentHighlightIndex){
        
        itemX = buttonX;
        itemY = (self.frame.size.height - FTScrollViewIndicatorViewDefaultHightLightItemSize)/2;
        itemWidth = FTScrollViewIndicatorViewDefaultHightLightItemSize;
        itemHight = FTScrollViewIndicatorViewDefaultHightLightItemSize;
        
    }else{
        
        itemX = buttonX + FTScrollViewIndicatorViewDefaultHightLightItemSize + (FTScrollViewIndicatorViewItemMargin)*(itemIndex - currentHighlightIndex) + (FTScrollViewIndicatorViewDefaultItemSize)*(itemIndex - currentHighlightIndex - 1);
        
    }
    
    return CGRectMake(itemX, itemY, itemWidth, itemHight);
}


-(void)transformWithNewOffset:(CGFloat )newOffset oldOffSet:(CGFloat)oldOffSet pageSize:(CGFloat)pageSize
{
    if (newOffset == oldOffSet) {
        self.highlightedIndex = newOffset/pageSize;
        return;
    }
    BOOL isScrollLeft = newOffset > oldOffSet;
    NSInteger activeIndex_2 = isScrollLeft ? _highlightedIndex + 1 : _highlightedIndex - 1;
    CGFloat buttonX = (self.frame.size.width - FTScrollViewIndicatorViewDefaultHightLightItemSize)/2;
    CGFloat buttonY = (self.frame.size.height - FTScrollViewIndicatorViewDefaultHightLightItemSize)/2;

    
    for (FTScrollViewIndicatorViewItem *item in self.subviews) {
        
//        CGFloat itemHight = 0;
//        UIColor *itemColor = self.normaTintColor;
        
        CGRect originRect = [self getRectForIndicatorWithIndex:item.tag currentHighlightIndex:_highlightedIndex];
        CGFloat itemX = originRect.origin.x;
        CGFloat itemY = originRect.origin.y;
        CGFloat itemWidth = originRect.size.width;

        float percent = 0;
        if (isScrollLeft) {
            percent = (newOffset - _highlightedIndex*pageSize)/pageSize;
        }else{
            percent = (_highlightedIndex*pageSize - newOffset)/pageSize;
        }

        if (item.tag == _highlightedIndex) {
            if (isScrollLeft) {

                itemX = buttonX - (FTScrollViewIndicatorViewDefaultItemSize + FTScrollViewIndicatorViewItemMargin)*percent;
                itemY = buttonY + (FTScrollViewIndicatorViewDefaultHightLightItemSize - FTScrollViewIndicatorViewDefaultItemSize)/2*percent;
                itemWidth = FTScrollViewIndicatorViewDefaultHightLightItemSize - (FTScrollViewIndicatorViewDefaultHightLightItemSize - FTScrollViewIndicatorViewItemMargin)*percent;
            }else{
                itemX = buttonX + (FTScrollViewIndicatorViewDefaultHightLightItemSize + FTScrollViewIndicatorViewItemMargin)*percent;
                itemY = buttonY + (FTScrollViewIndicatorViewDefaultHightLightItemSize - FTScrollViewIndicatorViewDefaultItemSize)/2*percent;
                itemWidth = FTScrollViewIndicatorViewDefaultHightLightItemSize - (FTScrollViewIndicatorViewDefaultHightLightItemSize - FTScrollViewIndicatorViewItemMargin)*percent;
            }
        }else if (item.tag == activeIndex_2){
            if (isScrollLeft) {
                itemX = originRect.origin.x - (FTScrollViewIndicatorViewDefaultHightLightItemSize + FTScrollViewIndicatorViewItemMargin)*percent;
                itemY = (self.frame.size.height - FTScrollViewIndicatorViewDefaultItemSize)/2 - (FTScrollViewIndicatorViewDefaultHightLightItemSize - FTScrollViewIndicatorViewDefaultItemSize)/2*percent;
                itemWidth = FTScrollViewIndicatorViewDefaultItemSize + (FTScrollViewIndicatorViewDefaultHightLightItemSize - FTScrollViewIndicatorViewItemMargin)*percent;
            }else{
                itemX = originRect.origin.x + (FTScrollViewIndicatorViewDefaultItemSize + FTScrollViewIndicatorViewItemMargin)*percent;
                itemY = (self.frame.size.height - FTScrollViewIndicatorViewDefaultItemSize)/2 - (FTScrollViewIndicatorViewDefaultHightLightItemSize - FTScrollViewIndicatorViewDefaultItemSize)/2*percent;
                itemWidth = FTScrollViewIndicatorViewDefaultItemSize + (FTScrollViewIndicatorViewDefaultHightLightItemSize - FTScrollViewIndicatorViewItemMargin)*percent;
            }
        }else{
            if (isScrollLeft) {
                itemX = originRect.origin.x - (FTScrollViewIndicatorViewDefaultItemSize + FTScrollViewIndicatorViewItemMargin)*percent;
            }else{
                itemX = originRect.origin.x + (FTScrollViewIndicatorViewDefaultItemSize + FTScrollViewIndicatorViewItemMargin)*percent;
            }
            itemY = (self.frame.size.height - FTScrollViewIndicatorViewDefaultItemSize)/2;
            itemWidth = FTScrollViewIndicatorViewDefaultItemSize;
        }
        item.frame = CGRectMake(itemX, itemY, itemWidth, itemWidth);
        [item setNeedsDisplay];
    }
    
}





@end

/**
 *  FTScrollViewIndicatorViewItem
 */

@implementation FTScrollViewIndicatorViewItem

@synthesize indicatorColor = _indicatorColor;

-(UIColor *)indicatorColor
{
    if (!_indicatorColor) {
        _indicatorColor = [UIColor redColor];
    }
    return _indicatorColor;
}

-(void)setIndicatorColor:(UIColor *)indicatorColor
{
    _indicatorColor = indicatorColor;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    self.backgroundColor = [UIColor clearColor];
    
    CGPoint center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    CGFloat radius = self.bounds.size.width/2;
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, self.indicatorColor.CGColor);
    CGContextAddArc(context, center.x, center.y, radius, 0, 2*M_PI, 0);
    CGContextFillPath(context);
    
}

@end