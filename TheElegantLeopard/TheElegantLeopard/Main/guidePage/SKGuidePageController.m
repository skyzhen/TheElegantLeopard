//
//  SKGuidePageController.m
//  TheElegantLeopard
//
//  Created by lzb on 16/4/21.
//  Copyright © 2016年 SK. All rights reserved.
//

#import "SKGuidePageController.h"

@interface SKGuidePageController () <UIScrollViewDelegate>
@property(nonatomic, strong) UIPageControl *guidePageControl;
@end

@implementation SKGuidePageController
- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  [self createGuideImageView];
  [self createGuideScrollView];
  [self createGuidePageControl];
}

#pragma mark - 创建底层ImageView
- (void)createGuideImageView {
  UIImageView *guideImageView =
      [[UIImageView alloc] initWithFrame:self.view.bounds];
  [guideImageView setImage:[UIImage imageNamed:@"new_feature_background.png"]];
  [self.view addSubview:guideImageView];
  self.view.userInteractionEnabled = YES;
}
#pragma mark - 创建滚动容器ScrollView
- (void)createGuideScrollView {
  UIScrollView *guideScrollView =
      [[UIScrollView alloc] initWithFrame:self.view.bounds];
  [guideScrollView
      setContentSize:CGSizeMake(self.view.bounds.size.width * 4, 0)];
  CGFloat imageWith = self.view.bounds.size.width;
  CGFloat imageHeight = self.view.bounds.size.height;
  for (int i = 0; i < 4; i++) {
    UIImageView *pageImageView = [[UIImageView alloc]
        initWithFrame:CGRectMake(i * imageWith, 0, imageWith, imageHeight)];
    [pageImageView
        setImage:[UIImage imageNamed:[NSString
                                         stringWithFormat:@"new_feature_%d.png",
                                                          i + 1]]];
    if (i == 3) {
      [self createGuideButton:pageImageView];
    }
    [guideScrollView addSubview:pageImageView];
  }
  [guideScrollView setPagingEnabled:YES];
  [guideScrollView setBounces:NO];
  [guideScrollView setShowsHorizontalScrollIndicator:NO];
  [guideScrollView setShowsVerticalScrollIndicator:NO];
  [guideScrollView setDelegate:self];
  [self.view addSubview:guideScrollView];
}

#pragma mark - 创建进入按钮
- (void)createGuideButton:(UIImageView *)pageImageView {
  pageImageView.userInteractionEnabled = YES;
  UIButton *intoButton = [[UIButton alloc] init];
  UIImage *backImageTouch =
      [UIImage imageNamed:@"new_feature_finish_button.png"];
  UIImage *backImageNormal =
      [UIImage imageNamed:@"new_feature_finish_button_highlighted.png"];
  [intoButton setBackgroundImage:backImageTouch forState:UIControlStateNormal];
  [intoButton setBackgroundImage:backImageNormal
                        forState:UIControlStateHighlighted];
  CGFloat centerX = pageImageView.bounds.size.width / 2;
  CGFloat centerY = pageImageView.bounds.size.height * 0.8;
  CGFloat width = backImageTouch.size.width;
  CGFloat height = backImageTouch.size.height;
  [intoButton setBounds:CGRectMake(0, 0, width, height)];
  [intoButton setCenter:CGPointMake(centerX, centerY)];
  [intoButton addTarget:self
                 action:@selector(clickInto)
       forControlEvents:UIControlEventTouchUpInside];
  [pageImageView addSubview:intoButton];
}
#pragma mark 立即体验消息事件
- (void)clickInto {
  NSLog(@"点击intoButton");
}
#pragma mark - 创建pageControl
- (void)createGuidePageControl {
  _guidePageControl = [[UIPageControl alloc] init];
  [_guidePageControl setCenter:CGPointMake(self.view.bounds.size.width / 2,
                                           self.view.bounds.size.height * 0.9)];
  [_guidePageControl setBounds:CGRectMake(0, 0, 150, 44)];
  [_guidePageControl setNumberOfPages:4];
  [_guidePageControl setPageIndicatorTintColor:[UIColor grayColor]];
  [_guidePageControl setCurrentPageIndicatorTintColor:[UIColor orangeColor]];
  [self.view addSubview:_guidePageControl];
}
#pragma mark scrollView的代理方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
  NSInteger index = scrollView.contentOffset.x / scrollView.bounds.size.width;
  [_guidePageControl setCurrentPage:index];
}
- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
