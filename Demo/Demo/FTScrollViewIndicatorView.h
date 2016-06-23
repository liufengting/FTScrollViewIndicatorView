//
//  FTScrollViewIndicatorView.h
//  Demo
//
//  Created by liufengting on 16/6/22.
//  Copyright © 2016年 liufengting. All rights reserved.
//

#import <UIKit/UIKit.h>

#define FTScrollViewIndicatorViewDefaultMargin                      5.0f
#define FTScrollViewIndicatorViewDefaultHightLightItemSize          20.0f
#define FTScrollViewIndicatorViewDefaultItemSize                    8.0f
#define FTScrollViewIndicatorViewItemMargin                         10.0f

/**
 *  FTScrollViewIndicatorViewItemState
 */
typedef NS_ENUM(NSUInteger, FTScrollViewIndicatorViewItemState) {
    /**
     *  Normal State
     */
    FTScrollViewIndicatorViewItemStateNormal,
    /**
     *  Activated state
     */
    FTScrollViewIndicatorViewItemStateActivated,
    /**
     *  HighLightedb state
     */
    FTScrollViewIndicatorViewItemStateHighLighted,
};

/**
 *  FTScrollViewIndicatorView
 */
@interface FTScrollViewIndicatorView : UIView

@property (nonatomic, strong)UIColor *normaTintColor;

@property (nonatomic, strong)UIColor *highLightedTintColor;

@property (nonatomic, assign)NSInteger highlightedIndex;

-(void)setupWithPageCount:(NSInteger)pageCount currentIndex:(NSInteger)currentIndex;

-(void)transformWithNewOffset:(CGFloat )newOffset oldOffSet:(CGFloat)oldOffSet pageSize:(CGFloat)pageSize;

@end



/**
 *  FTScrollViewIndicatorViewItem
 */

@interface FTScrollViewIndicatorViewItem : UIView

@property (nonatomic, strong)UIColor *indicatorColor;

@end
