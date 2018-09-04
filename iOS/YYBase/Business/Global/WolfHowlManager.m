//
//  WolfHowlManager.m
//  trader-ios
//
//  Created by YYang on 30/6/18.
//  Copyright © 2018 Trader. All rights reserved.
//

#import "WolfHowlManager.h"
#import <AVFoundation/AVFoundation.h>

@interface WolfHowlManager()<AVAudioPlayerDelegate>
@property(nonatomic, strong)AVAudioPlayer *audioPlayer;
@end


@implementation WolfHowlManager
SingletonM(Instance)

-(void)addNotificationObserve{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(lunchScreen) name:WolfHowlManagerWillTriggerLunchScreenNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(palyAudio) name:WolfHowlManagerWillTriggerPlayAudioNotification object:nil];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


-(void)palyAudio{
    [self delayLaunchScreen];
    [self.audioPlayer play];
}

-(void)lunchScreen{
    UIViewController *ctrl = [UIStoryboard loadController:@"LaunchScreen" storyBoard:@"LaunchScreen"];
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    ctrl.view.tag = 666;
    [window addSubview:ctrl.view];
    [window bringSubviewToFront:ctrl.view];
}


-(void)delayLaunchScreen{
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    __block UIView *lunchView = [window viewWithTag:666];
    
    if (!lunchView) {
        UIViewController *ctrl = [UIStoryboard loadController:@"LaunchScreen" storyBoard:@"LaunchScreen"];
        lunchView = ctrl.view;
        lunchView.tag = 666;
        [window addSubview:lunchView];
        [window bringSubviewToFront:lunchView];
    }
    
    [UIView animateWithDuration:.5f delay:4.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        lunchView.alpha = 0.0f;
        lunchView.layer.transform = CATransform3DScale(CATransform3DIdentity, 1, 1, 1.0f);
    } completion:^(BOOL finished) {
        [lunchView removeFromSuperview];
    }];
    
}



#pragma mark -Getters and Setters
-(AVAudioPlayer *)audioPlayer{
    if(!_audioPlayer){
        NSString *path = [[NSBundle mainBundle]pathForResource:@"wolf" ofType:@"mp3"];
        _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:path] error:nil];
        _audioPlayer.delegate = self;
        _audioPlayer.volume = 0.5;
        [_audioPlayer prepareToPlay];
    }
    return _audioPlayer;
}



@end
