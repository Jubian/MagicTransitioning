//
//  MainCardTransition.m
//  GreatArtist
//
//  Created by Caesar on 2018/9/14.
//  Copyright © 2018年 Caesar. All rights reserved.
//

#import "MainCardTransition.h"
#import "MainViewController.h"

@implementation MainCardTransition

-(instancetype)init{
    self = [super init];
    if (self) {
        self.animationDuration = 1.0f;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return self.animationDuration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    if (_isPush) {
        [self pushAnimateTransition:transitionContext];
    }else{
        [self popAnimateTransition:transitionContext];
    }
}

#pragma mark ————— push —————
- (void)pushAnimateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    //获取两个VC 和 动画发生的容器
    RTContainerController *fromContainer = (RTContainerController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    RTContainerController *toContainer   = (RTContainerController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    MainViewController *fromVC = fromContainer.contentViewController;
    MainDetailViewController *toVC = toContainer.contentViewController;

    UIView *containerView = [transitionContext containerView];
    
    MainCardCollectionViewCell *cell =(MainCardCollectionViewCell *)[fromVC.collectionView cellForItemAtIndexPath:[[fromVC.collectionView indexPathsForSelectedItems] firstObject]];
    
    UIView *toView = toVC.bgImageView;
    UIView *fromView = cell.picImageView;
    
    UIImageView * snapShotView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"向日葵.jpg"]];//[cell.picImageView snapshotViewAfterScreenUpdates:NO];
    snapShotView.contentMode = UIViewContentModeScaleAspectFill;
    snapShotView.clipsToBounds = YES;
    snapShotView.frame = [containerView convertRect:fromView.frame fromView:fromView.superview];
    
    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
    toVC.view.alpha = 0;
    toView.hidden = YES;
    fromView.hidden = YES;
    
    [containerView addSubview:toContainer.view];
    [containerView addSubview:snapShotView];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0f usingSpringWithDamping:0.6f initialSpringVelocity:1.0f options:UIViewAnimationOptionCurveLinear animations:^{
        [containerView layoutIfNeeded];
        toVC.view.alpha = 1.0f;
        snapShotView.frame = [containerView convertRect:toView.frame fromView:toView.superview];
        
    } completion:^(BOOL finished) {
        
        toView.hidden = NO;
        fromView.hidden = NO;
        [snapShotView removeFromSuperview];
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
    
}

#pragma mark ————— pop —————
- (void)popAnimateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    //获取两个VC 和 动画发生的容器
    RTContainerController *fromContainer = (RTContainerController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    RTContainerController *toContainer   = (RTContainerController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    MainDetailViewController *fromVC = fromContainer.contentViewController;
    MainViewController *toVC = toContainer.contentViewController;
    
    UIView *containerView = [transitionContext containerView];
    
    MainCardCollectionViewCell *cell =(MainCardCollectionViewCell *)[toVC.collectionView cellForItemAtIndexPath:fromVC.indexPath];

    UIView *toView = cell.picImageView;
    UIView *fromView = fromVC.bgImageView;
    
    UIImageView * snapShotView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"向日葵.jpg"]];//[cell.picImageView snapshotViewAfterScreenUpdates:NO];
    snapShotView.contentMode = UIViewContentModeScaleAspectFill;
    snapShotView.clipsToBounds = YES;
    snapShotView.frame = [containerView convertRect:fromView.frame fromView:fromView.superview];
    fromVC.bgImageView.hidden = YES;
    
    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
    toView.hidden = YES;
    
    [containerView insertSubview:toContainer.view belowSubview:fromContainer.view];
    [containerView addSubview:snapShotView];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0f usingSpringWithDamping:0.6f initialSpringVelocity:1.0f options:UIViewAnimationOptionCurveLinear animations:^{
        fromContainer.view.alpha = 0.0f;
        snapShotView.frame = [containerView convertRect:toView.frame fromView:toView.superview];
        
    } completion:^(BOOL finished) {
        
        toView.hidden = NO;
        fromVC.bgImageView.hidden = NO;
        [snapShotView removeFromSuperview];
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

@end
