//
//  MainCardTransition.h
//  GreatArtist
//
//  Created by Caesar on 2018/9/14.
//  Copyright © 2018年 Caesar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MainCardTransition : NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) BOOL isPush;//是否是push，反之则是pop

@property (nonatomic, assign) NSTimeInterval animationDuration;//动画时长

@end
