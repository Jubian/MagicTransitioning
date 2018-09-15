//
//  MainViewController.m
//  GreatArtist
//
//  Created by Caesar on 2018/9/13.
//  Copyright © 2018年 Caesar. All rights reserved.
//

#import "MainViewController.h"
#import "CardLayOut.h"
#import "MainCardTransition.h"


@interface MainViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UINavigationControllerDelegate>

@property (nonatomic, strong) CardLayOut *layout;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"66";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animate {
    self.navigationController.delegate = self;
}

#pragma mark - privateMethods

- (void)setupUI {
    [self.view addSubview:self.collectionView];
}

- (void)setupLayout {
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view).insets(UIEdgeInsetsMake(10, 0, 0, 0));
        make.height.equalTo(@400);
//        make.edges.equalTo(self.view);
    }];
    
}

#pragma mark <UINavigationControllerDelegate>
- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC{
    
    if ([toVC isKindOfClass:[MainDetailViewController class]]) {
        MainCardTransition *transition = [[MainCardTransition alloc]init];
        transition.isPush = YES;
        return transition;
    }else{
        return nil;
    }
}

#pragma mark - collectionDelegate/DataSource
- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    MainCardCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MainCardCollectionViewCell class]) forIndexPath:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    MainDetailViewController *detailVC = [[MainDetailViewController alloc]init];
    detailVC.indexPath = indexPath;
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark - getter
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = ({
            UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:self.layout];
            collectionView.backgroundColor = [UIColor clearColor];
            collectionView.delegate = self;
            collectionView.dataSource = self;
            collectionView.showsHorizontalScrollIndicator = NO;
            collectionView.showsVerticalScrollIndicator = NO;
            [collectionView registerClass:[MainCardCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([MainCardCollectionViewCell class])];
            collectionView;
        });
    }
    return _collectionView;
}

- (CardLayOut *)layout {
    if (!_layout) {
        _layout = [[CardLayOut alloc]init];
        _layout.spacing = 30;
        _layout.scale = 1.1;
        _layout.itemSize = CGSizeMake(SCREEN_WIDTH - 90, 360);
        float edgeSpace = (SCREEN_WIDTH - _layout.itemSize.width) / 2;
        _layout.edgeInset = UIEdgeInsetsMake(0,edgeSpace , 0, edgeSpace);
        _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return _layout;
}


@end
