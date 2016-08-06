//
//  Chess.m
//  2048
//
//  Created by runlhy on 16/8/6.
//  Copyright © 2016年 Pengcent. All rights reserved.
//

#import "Chess.h"

@implementation Chess

- (id)copyWithZone:(NSZone *)zone{
    Chess *newChess = [[self class] allocWithZone:zone];
    newChess.x = _x;
    newChess.y = _y;
    newChess.level = _level;
    return newChess;
}

/**
 将属性进行编码
 */
- (void) encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeInteger:_x forKey:@"x"];
    [encoder encodeInteger:_y forKey:@"y"];
    [encoder encodeInteger:_level forKey:@"level"];
}
/**
 将属性进行解码
 */
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        _x = [aDecoder decodeIntegerForKey:@"x"];
        _y = [aDecoder decodeIntegerForKey:@"y"];
        _level = [aDecoder decodeIntegerForKey:@"level"];
    }
    return self;
}

@end
