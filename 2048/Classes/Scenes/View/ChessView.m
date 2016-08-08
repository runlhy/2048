//
//  ChessView.m
//  2048
//
//  Created by runlhy on 16/8/6.
//  Copyright © 2016年 Pengcent. All rights reserved.
//

#import "ChessView.h"

#define RGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]


@interface ChessView(){
    NSArray *_evolutionArray;
}
@property (nonatomic, strong) UILabel *label;
@end


@implementation ChessView
- (UILabel *)label
{
    if (!_label){
        _label = [[UILabel alloc] init];
    }
    return _label;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = frame.size.width/10;
        _evolutionArray = @[@"2", @"4", @"8", @"16", @"32", @"64", @"128", @"256", @"512", @"1024", @"2048"];
//        _evolutionArray = @[@"搭讪", @"暧昧", @"约会", @"表白", @"恋爱", @"牵手", @"拥抱", @"接吻", @"XXOO", @"求婚", @"小恩爱", @"相濡以沫", @"死亡", @"复活", @"诈尸"];
    }
    return self;
}

- (void)setLevel:(NSInteger)level{
    self.label.frame = self.bounds;
    _label.textColor = [self textColorForLevel:level];
    _label.font = [UIFont systemFontOfSize:self.bounds.size.width/2 weight:.3];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.adjustsFontSizeToFitWidth = YES;
    [self addSubview:_label];
    _label.text = _evolutionArray[level];
    self.backgroundColor = [self colorForLevel:level];
}

- (UIColor *)textColorForLevel:(NSInteger)level
{
    switch (level+1) {
        case 1:
        case 2:
            return RGB(118, 109, 100);
        default:
            return [UIColor whiteColor];
    }
}
- (UIColor *)colorForLevel:(NSInteger)level
{
    switch (level+1) {
        case 1:
            return RGB(238, 228, 218);
        case 2:
            return RGB(237, 224, 200);
        case 3:
            return RGB(242, 177, 121);
        case 4:
            return RGB(245, 149, 99);
        case 5:
            return RGB(246, 124, 95);
        case 6:
            return RGB(246, 94, 59);
        case 7:
            return RGB(237, 207, 114);
        case 8:
            return RGB(237, 204, 97);
        case 9:
            return RGB(237, 200, 80);
        case 10:
            return RGB(237, 197, 63);
        case 11:
            return RGB(237, 194, 46);
        case 12:
            return RGB(173, 183, 119);
        case 13:
            return RGB(170, 183, 102);
        case 14:
            return RGB(164, 183, 79);
        case 15:
        default:
            return RGB(161, 183, 63);
    }
}

@end
