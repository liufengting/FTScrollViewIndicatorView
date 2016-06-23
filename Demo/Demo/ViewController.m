//
//  ViewController.m
//  Demo
//
//  Created by liufengting on 16/6/22.
//  Copyright © 2016年 liufengting. All rights reserved.
//

#import "ViewController.h"
#import "FTScrollViewIndicatorView.h"
#import "UIScrollView+FTScrollViewIndicatorView.h"

@interface ViewController () 

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong)NSArray<UIColor *> *colorArray;

@property (nonatomic, strong)FTScrollViewIndicatorView *IndicatorView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.navigationController.navigationBar.translucent = NO;
 
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.colorArray = @[[UIColor redColor],[UIColor greenColor],[UIColor blueColor],[UIColor whiteColor],[UIColor blackColor],];
    
    [self.scrollView setContentSize:CGSizeMake(self.scrollView.frame.size.width*self.colorArray.count, self.scrollView.frame.size.height)];

    

    
    
    for (NSInteger i = 0; i < self.colorArray.count; i++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(self.scrollView.frame.size.width*(i), 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height)];
        [view setBackgroundColor:self.colorArray[i]];
        [self.scrollView addSubview:view];
    }
    
    
    [self.scrollView addIndicatorViewWithframe:CGRectMake(0, self.scrollView.frame.size.height-50, self.scrollView.frame.size.width, 50)];
    
    
//    _IndicatorView = [[FTScrollViewIndicatorView  alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
//    _IndicatorView.backgroundColor = [UIColor whiteColor];
//    _IndicatorView.IndicatorColor = [UIColor cyanColor];
//    [self.view addSubview:_IndicatorView];
    
    //    [_IndicatorView setNeedsDisplay];
}



- (IBAction)refresh:(UIBarButtonItem *)sender
{
//        [UIView animateWithDuration:0.5
//                         animations:^{
//                             [_IndicatorView setFrame:CGRectMake(140, 140, 20, 20)];
//                         }];
}



@end
