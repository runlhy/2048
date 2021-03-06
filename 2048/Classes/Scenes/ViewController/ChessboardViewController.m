//
//  ChessboardViewController.m
//  2048
//
//  Created by runlhy on 16/8/6.
//  Copyright © 2016年 Pengcent. All rights reserved.
//

#import "ChessboardViewController.h"
#import "ChessView.h"
#import "OneGame.h"
#import "Chess.h"
#define RGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]

@interface ChessboardViewController (){
    CGFloat _chessWidth;
    NSArray *_evolutionArray;
}

@property (weak, nonatomic) IBOutlet UIView *chessboardView;

@end

@implementation ChessboardViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self initOnegame];
    [self addAllGesture];
}

- (void)initOnegame{
    OneGame *onegame = [OneGame new];
    onegame.scale = 4;
    
    onegame.chessboardArray = [NSMutableArray arrayWithCapacity:onegame.scale * onegame.scale];
    for (NSInteger i=0; i<onegame.scale; i++) {
        for (NSInteger j=0; j<onegame.scale; j++) {
            //一维数组模拟二维数组
            onegame.chessboardArray[i*onegame.scale+j] = @0;
        }
    }
    NSInteger x1, y1, x2, y2;
    x1 = arc4random()%onegame.scale;
    y1 = arc4random()%onegame.scale;
    x2 = arc4random()%onegame.scale;
    y2 = arc4random()%onegame.scale;
    while (x1 == x2 && y1 == y2) {
        x2 = arc4random()%onegame.scale;
        y2 = arc4random()%onegame.scale;
    }
    Chess *chess1 = [Chess new];
    chess1.level = 0;
    chess1.x = x1;
    chess1.y = y1;
    Chess *chess2 = [Chess new];
    chess2.level = 0;
    chess2.x = x2;
    chess2.y = y2;
    //填充棋子
    onegame.chessboardArray[y1*onegame.scale+x1] = chess1;
    onegame.chessboardArray[y2*onegame.scale+x2] = chess2;
    //NSLog(@"(%ld,%ld), (%ld,%ld)%@",x1+1,y1+1,x2+1,y2+1,onegame.chessboardArray);
    
    self.oneGame = onegame;
    CGFloat width = self.chessboardView.bounds.size.width;
    _chessWidth = width/onegame.scale;
    
    NSInteger scale = onegame.scale;
    for (NSInteger i=0; i<scale; i++) {
        for (NSInteger j=0; j<scale; j++) {
            UIView *backgorudView = [[UIView alloc]initWithFrame:CGRectMake(j * _chessWidth + 2, i *_chessWidth +2, _chessWidth - 4, _chessWidth - 4)];
            backgorudView.layer.cornerRadius = (_chessWidth-4)/10;
            backgorudView.backgroundColor = RGB(204, 192, 179);
            [self.chessboardView addSubview:backgorudView];
            
            if (![onegame.chessboardArray[i*scale+j] isKindOfClass:[NSNumber class]]) {
                Chess *chess = onegame.chessboardArray[i*scale+j];
                ChessView *view = [[ChessView alloc] initWithFrame:CGRectMake(chess.x * _chessWidth + 2, chess.y * _chessWidth + 2, _chessWidth-4, _chessWidth-4)];
                view.transform = CGAffineTransformMakeScale(0, 0);
                [UIView animateWithDuration:.2 animations:^{
                    view.transform = CGAffineTransformMakeScale(1, 1);
                } completion:^(BOOL finished) {
                    view.level = chess.level;
                }];
                chess.view = view;
                [self.chessboardView addSubview:view];
            }
            
        }
    }
}

/**
 添加手势
 */
- (void)addAllGesture{
    UISwipeGestureRecognizer *recognizer;
    recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [self.chessboardView addGestureRecognizer:recognizer];
    
    recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [self.chessboardView addGestureRecognizer:recognizer];
    
    recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionUp)];
    [self.chessboardView addGestureRecognizer:recognizer];
    
    recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionDown)];
    [self.chessboardView addGestureRecognizer:recognizer];
}
/**
 手势Action
 */
- (void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer{

    Chess *tempChess = nil;
    
    NSInteger scale = self.oneGame.scale;
    
    switch (recognizer.direction) {
        case UISwipeGestureRecognizerDirectionUp:{
            
            for (NSInteger i=0; i<scale; i++) {
                NSInteger k=0;
                Chess *cloneChess = nil;
                for (NSInteger j=0; j<scale; j++) {
                    
                    if (![self.oneGame.chessboardArray[j*scale+i] isKindOfClass:[NSNumber class]]) {
                        Chess *chess = self.oneGame.chessboardArray[j*scale+i];
                        if (cloneChess && cloneChess.level == chess.level) {
                            chess.y = cloneChess.y;
                            chess.isUpgrade = YES;
                            chess.level += 1;
                            
                            tempChess.y = cloneChess.y;
                            tempChess.isUpgrade = YES;
                            tempChess.level += 1;
                            cloneChess = nil;
                        }else{
                            chess.y = k++;
                            cloneChess = [chess copy];
                            tempChess = chess;
                        }
                    }
                }
            }
        }
            
            break;
        case UISwipeGestureRecognizerDirectionDown:{
            
            for (NSInteger i=scale-1; i>=0; i--) {
                NSInteger k=scale-1;
                Chess *cloneChess = nil;
                for (NSInteger j=scale-1; j>=0; j--) {
                    
                    if (![self.oneGame.chessboardArray[j*scale+i] isKindOfClass:[NSNumber class]]) {
                        Chess *chess = self.oneGame.chessboardArray[j*scale+i];
                        if (cloneChess && cloneChess.level == chess.level) {
                            chess.y = cloneChess.y;
                            chess.isUpgrade = YES;
                            chess.level += 1;
                            
                            tempChess.y = cloneChess.y;
                            tempChess.isUpgrade = YES;
                            tempChess.level += 1;
                            cloneChess = nil;
                        }else{
                            chess.y = k--;
                            cloneChess = [chess copy];
                            tempChess = chess;
                        }
                    }
                }
            }
        }
            
            break;
        case UISwipeGestureRecognizerDirectionLeft:{
            
            for (NSInteger i=0; i<scale; i++) {
                NSInteger k=0;
                Chess *cloneChess = nil;
                for (NSInteger j=0; j<scale; j++) {
                    
                    if (![self.oneGame.chessboardArray[i*scale+j] isKindOfClass:[NSNumber class]]) {
                        Chess *chess = self.oneGame.chessboardArray[i*scale+j];
                        if (cloneChess && cloneChess.level == chess.level) {
                            chess.x = cloneChess.x;
                            chess.isUpgrade = YES;
                            chess.level += 1;
                            tempChess.x = cloneChess.x;
                            tempChess.isUpgrade = YES;
                            tempChess.level += 1;
                            cloneChess = nil;
                        }else{
                            chess.x = k++;
                            cloneChess = [chess copy];
                            tempChess = chess;
                        }
                    }
                }
            }
        }
            break;
            
        default:{
            
            for (NSInteger i=scale-1; i>=0; i--) {
                NSInteger k=scale-1;
                Chess *cloneChess = nil;
                for (NSInteger j=scale-1; j>=0; j--) {
                    
                    if (![self.oneGame.chessboardArray[i*scale+j] isKindOfClass:[NSNumber class]]) {
                        Chess *chess = self.oneGame.chessboardArray[i*scale+j];
                        if (cloneChess && cloneChess.level == chess.level) {
                            chess.x = cloneChess.x;
                            chess.isUpgrade = YES;
                            chess.level += 1;
                            tempChess.x = cloneChess.x;
                            tempChess.isUpgrade = YES;
                            tempChess.level += 1;
                            cloneChess = nil;
                        }else{
                            chess.x = k--;
                            cloneChess = [chess copy];
                            tempChess = chess;
                        }
                    }
                }
            }
        }
            
            break;
    }
    
    [self updateData];
    
    NSArray *animateArray = [NSArray arrayWithArray:self.oneGame.chessboardArray];
    for (NSInteger i=0; i<scale; i++) {
        for (NSInteger j=0; j<scale; j++) {
            if (![animateArray[i*scale+j] isKindOfClass:[NSNumber class]]) {
                Chess *chess = animateArray[i*scale+j];
                
                [UIView animateWithDuration:.2f animations:^{
                    chess.view.frame = CGRectMake(chess.x * _chessWidth + 2, chess.y * _chessWidth + 2, _chessWidth-4, _chessWidth-4);
                }];
            }
        }
    }
    [self performSelector:@selector(updateChessboard) withObject:nil afterDelay:.1];
}
/**
 更新数据
 */
- (void)updateData{
    
    NSInteger scale = self.oneGame.scale;
    NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:scale * scale];
    for (NSInteger i=0; i<scale; i++) {
        for (NSInteger j=0; j<scale; j++) {
            tempArray[i*scale+j] = @0;
        }
    }
    for (NSInteger i=0; i<scale; i++) {
        for (NSInteger j=0; j<scale; j++) {
            if (![self.oneGame.chessboardArray[i*scale+j] isKindOfClass:[NSNumber class]]) {
                Chess *chess = self.oneGame.chessboardArray[i*scale+j];
                tempArray[chess.y*scale+chess.x] = chess;
            }
        }
    }
    
    if ([self.oneGame.chessboardArray isEqualToArray:tempArray]) {
        NSLog(@"相等");
    }else{
        self.oneGame.chessboardArray = tempArray;
        
        NSMutableArray *empyArray = [NSMutableArray array];
        for (NSInteger i=0; i<scale; i++) {
            for (NSInteger j=0; j<scale; j++) {
                if ([self.oneGame.chessboardArray[i*scale+j] isKindOfClass:[NSNumber class]]){
                    Chess *chess = [Chess new];
                    chess.x = j;
                    chess.y = i;
                    [empyArray addObject:chess];
                }
            }
        }
        
        NSInteger index = arc4random() % empyArray.count;
        Chess *chess = empyArray[index];
        chess.level = 0;
        tempArray[chess.y*scale+chess.x] = chess;
        ChessView *view = [[ChessView alloc] initWithFrame:CGRectMake(chess.x * _chessWidth + 2, chess.y * _chessWidth + 2, _chessWidth-4, _chessWidth-4)];
        chess.view = view;
        view.transform = CGAffineTransformMakeScale(0, 0);
        
        [self.chessboardView addSubview:view];
        [UIView animateWithDuration:.2 animations:^{
            view.transform = CGAffineTransformMakeScale(1, 1);
            view.level = chess.level;
        }];
    }
}
/**
 更新棋盘
 */
- (void)updateChessboard{
    for(UIView *view in [self.chessboardView subviews]){
        if ([view isKindOfClass:[ChessView class]]) {
            [view removeFromSuperview];
        }
    }
    NSInteger scale = self.oneGame.scale;
    for (NSInteger i=0; i<scale; i++) {
        for (NSInteger j=0; j<scale; j++) {
            if (![self.oneGame.chessboardArray[i*scale+j] isKindOfClass:[NSNumber class]]) {
                Chess *chess = self.oneGame.chessboardArray[i*scale+j];
                ChessView *view = [[ChessView alloc] initWithFrame:CGRectMake(chess.x * _chessWidth + 2, chess.y * _chessWidth + 2, _chessWidth-4, _chessWidth-4)];
                
                view.level = chess.level;
                
                chess.view = view;
                if (chess.isUpgrade) {
                    chess.isUpgrade = NO;
                    [UIView animateWithDuration:.1 animations:^{
                        chess.view.transform = CGAffineTransformMakeScale(1.2, 1.2);
                        chess.view.level = chess.level;
                        
                    } completion:^(BOOL finished) {
                        [UIView animateWithDuration:.1 animations:^{
                            chess.view.transform = CGAffineTransformIdentity;
                        }];
                    }];
                }
                
                [self.chessboardView addSubview:view];
            }
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
