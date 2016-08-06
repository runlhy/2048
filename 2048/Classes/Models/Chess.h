//
//  Chess.h
//  2048
//
//  Created by runlhy on 16/8/6.
//  Copyright © 2016年 Pengcent. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ChessView;
@interface Chess : NSObject<NSCoding,NSCopying>

/** 坐标 */
@property (nonatomic, assign) NSInteger x;
@property (nonatomic, assign) NSInteger y;

/** 等级 */
@property (nonatomic, assign) NSInteger level;

/** 升级 */
@property (nonatomic, assign) BOOL isUpgrade;
/** 临时 */
//@property (nonatomic, assign) BOOL isTemp;

/** view */
@property (nonatomic, strong) ChessView *view;

@end
