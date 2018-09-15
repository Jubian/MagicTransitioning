//
//  MainDetailViewController.m
//  GreatArtist
//
//  Created by Caesar on 2018/9/14.
//  Copyright © 2018年 Caesar. All rights reserved.
//

#import "MainDetailViewController.h"
#import "MainCardTransition.h"

#import "MainViewController.h"

@interface MainDetailViewController ()<UINavigationControllerDelegate>

@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *percentDrivenTransition;

@end

@implementation MainDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.hidden = YES;
    [UIView animateWithDuration:0.5 animations:^{
        self.StatusBarStyle = UIStatusBarStyleLightContent;
    }];
    self.rt_disableInteractivePop = YES;
    
    UIScreenEdgePanGestureRecognizer *edgePanGestureRecognizer = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(edgePanGesture:)];
    //设置从什么边界滑入
    edgePanGestureRecognizer.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:edgePanGestureRecognizer];
}

- (void)viewDidAppear:(BOOL)animate {
    self.navigationController.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    
}

-(void)edgePanGesture:(UIScreenEdgePanGestureRecognizer *)recognizer{
    //计算手指滑的距离
    CGFloat progress = [recognizer translationInView:self.view].x / (self.view.bounds.size.width * 1.0);
    progress = MIN(1.0, MAX(0.0, progress));//把这个百分比限制在0~1之间
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.percentDrivenTransition = [[UIPercentDrivenInteractiveTransition alloc]init];
        [self.navigationController popViewControllerAnimated:YES];
    }else if (recognizer.state == UIGestureRecognizerStateChanged){
        [self.percentDrivenTransition updateInteractiveTransition:progress];
    }else if (recognizer.state == UIGestureRecognizerStateCancelled || recognizer.state == UIGestureRecognizerStateEnded){
        //当距离为大于0.1之后，主动完成返回手势
        if (progress > 0.1) {
            [self.percentDrivenTransition finishInteractiveTransition];
        }else{
            [self.percentDrivenTransition cancelInteractiveTransition];
        }
        self.percentDrivenTransition = nil;
    }
    
}

#pragma mark - privateMethods

- (void)setupUI {
    [self.view addSubview:self.bgImageView];
}

- (void)setupLayout {
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark <UINavigationControllerDelegate>
- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC{
    
    if ([toVC isKindOfClass:[MainViewController class]]) {
        MainCardTransition *transition = [[MainCardTransition alloc]init];
        transition.isPush = NO;
        return transition;
    }else{
        return nil;
    }
}

- (id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                          interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController{
    if ([animationController isKindOfClass:[MainCardTransition class]]) {
        return self.percentDrivenTransition;
    }else{
        return nil;
    }
}

#pragma mark - getter

- (UIImageView *)bgImageView {
    if (!_bgImageView) {
        _bgImageView = ({
            UIImageView *imageView = [[UIImageView alloc]init];
            imageView.image = [UIImage imageNamed:@"向日葵.jpg"];
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.clipsToBounds = YES;
            imageView;
        });
    }
    return _bgImageView;
}

@end
