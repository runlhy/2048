//
//  ViewController.m
//  2048
//
//  Created by runlhy on 16/8/5.
//  Copyright © 2016年 Pengcent. All rights reserved.
//

#import "ViewController.h"
#define touchDistance 100
#define touchPy 10

@interface ViewController (){
    UIView *_view;
}
@end

@implementation ViewController

- (void)viewDidLoad{
    
    [super viewDidLoad];
    [self addAllGesture];
    [self addAllViews];
}

- (void)addAllViews{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    view.backgroundColor = [UIColor grayColor];
    view.center = self.view.center;
    _view = view;
    [self.view addSubview:view];
}

- (void)addAllGesture{
    UISwipeGestureRecognizer *recognizer;
    recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [[self view] addGestureRecognizer:recognizer];
    
    recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [[self view] addGestureRecognizer:recognizer];
    
    recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionUp)];
    [[self view] addGestureRecognizer:recognizer];
    
    recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionDown)];
    [[self view] addGestureRecognizer:recognizer];
}

- (void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer{
    CGRect frame = _view.frame;
    if(recognizer.direction==UISwipeGestureRecognizerDirectionDown) {
        NSLog(@"swipe down");
        frame.origin.y += 100;
    }
    if(recognizer.direction==UISwipeGestureRecognizerDirectionUp) {
        NSLog(@"swipe up");
        frame.origin.y -= 100;
    }
    if(recognizer.direction==UISwipeGestureRecognizerDirectionLeft) {
        NSLog(@"swipe left");
        frame.origin.x -= 100;
    }
    if(recognizer.direction==UISwipeGestureRecognizerDirectionRight) {
        NSLog(@"swipe right");
        frame.origin.x += 100;
    }
    [UIView animateWithDuration:.3 delay:0 usingSpringWithDamping:0.9 initialSpringVelocity:10 options:UIViewAnimationOptionAllowAnimatedContent animations:^{
        _view.frame = frame;
    } completion:^(BOOL finished) {
    }];
    
}


@end
