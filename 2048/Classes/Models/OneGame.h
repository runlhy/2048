//
//  OneGame.h
//  2048
//
//  Created by runlhy on 16/8/6.
//  Copyright © 2016年 Pengcent. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OneGame : NSObject

/** 棋子数据 */
@property (nonatomic, strong) NSMutableArray *chessboardArray;

/** 规模 scale * scale */
@property (nonatomic, assign) NSInteger scale;

@end
