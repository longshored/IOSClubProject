//
//  Counter VC.m
//  IOSProject
//
//  Created by Derek Longshore on 2/17/16.
//  Copyright © 2016 Derek Longshore. All rights reserved.
//

#import "Counter VC.h"

@interface Counter_VC ()
@property (nonatomic, weak) IBOutlet UILabel *timerLabel;
@property (nonatomic, weak) IBOutlet UIButton *cancelButton;
@property (nonatomic, weak) IBOutlet UIButton *startButton;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, assign) NSInteger currentTimeRemaining;
@property (nonatomic, assign) NSTimeInterval defaultTime;

@property (nonatomic, assign) BOOL isTimerRunning;

@end

@implementation Counter_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.defaultTime = 30 * 60;
    self.currentTimeRemaining = self.defaultTime;
    [self updateLabelWithTime];
    
}

-(IBAction)startPressed {
    if (self.isTimerRunning) {
        [self pauseTimer];
        [self.startButton setTitle:@"Start" forState:UIControlStateNormal];
    }
    else {
        [self startTimer];
        [self.startButton setTitle:@"Pause" forState:UIControlStateNormal];
    }
    self.isTimerRunning = !self.isTimerRunning;
}

-(IBAction)cancelPressed {
    self.isTimerRunning = NO;
    [self cancelTimer];
    [self.startButton setTitle:@"Start" forState: UIControlStateNormal];
    
}

-(void) timerExecuted {
    self.currentTimeRemaining--;
    [self updateLabelWithTime];
}

-(void)startTimer {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerExecuted) userInfo:nil repeats:YES];
    

}

-(void)pauseTimer {
    [self.timer invalidate];
    self.timer=nil;
    
}

-(void)cancelTimer {
    [self pauseTimer];
    self.currentTimeRemaining = self.defaultTime;
    [self updateLabelWithTime];
}

-(void) updateLabelWithTime {
    NSInteger secondsRemaining;
    NSInteger minutesRemaining;
    
    minutesRemaining = self.currentTimeRemaining / 60;
    secondsRemaining = self.currentTimeRemaining % 60;
    
    NSString *secondString;
    if(secondsRemaining <10) {
        secondString = [NSString stringWithFormat:@"0%zd", secondsRemaining];
    }
    else {
        secondString = [NSString stringWithFormat:@"%zd", secondsRemaining];
    }
    
    
    self.timerLabel.text = [NSString stringWithFormat:@"%zd:%@", minutesRemaining, secondString];
    
}

@end
