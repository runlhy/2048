//
//  ChessView.m
//  2048
//
//  Created by runlhy on 16/8/6.
//  Copyright © 2016年 Pengcent. All rights reserved.
//

#import "ChessView.h"
@interface ChessView()
{
    UILabel *_label;
}


@end

@implementation ChessView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _label = [[UILabel alloc]initWithFrame:self.bounds];
        _label.textColor = [UIColor whiteColor];
        _label.font = [UIFont systemFontOfSize:50 weight:5];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_label];
    }
    return self;
}

- (void)setText:(NSString *)text{
    _label.text = text;
}

@end
