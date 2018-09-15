//
//  MainCardCollectionViewCell.m
//  GreatArtist
//
//  Created by Caesar on 2018/9/14.
//  Copyright © 2018年 Caesar. All rights reserved.
//

#import "MainCardCollectionViewCell.h"

@interface MainCardCollectionViewCell ()



@end

@implementation MainCardCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        [self setupLayout];
    }
    return self;
}

- (void)setupUI {
    
    self.backgroundColor = [UIColor clearColor];
//    //cell设置阴影
//    self.layer.contentsScale = [UIScreen mainScreen].scale;
//    self.layer.shadowOpacity = 0.75f;
//    self.layer.shadowRadius = 4.0f;
//    self.layer.shadowOffset = CGSizeMake(0,2.5);
//    self.layer.shadowColor = [UIColor grayColor].CGColor;
//    self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
//    //设置缓存
//    self.layer.shouldRasterize = YES;
//    //设置抗锯齿边缘
//    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
    
    [self.contentView addSubview:self.picImageView];
    
    self.picImageView.image = [UIImage imageNamed:@"向日葵.jpg"];
}

- (void)setupLayout {
    [self.picImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

#pragma mark - getter

- (UIImageView *)picImageView {
    if (!_picImageView) {
        _picImageView = ({
            UIImageView *imageView = [[UIImageView alloc]init];
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.clipsToBounds = YES;
            imageView;
        });
    }
    return _picImageView;
}

@end
