//
//  video.m
//  photoKitAndCoreData
//
//  Created by Joe Chen on 2016/8/3.
//  Copyright © 2016年 Joe Chen. All rights reserved.
//

#import "video.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

@interface video ()
@property (weak, nonatomic) IBOutlet UIImageView *image;

@end

@implementation video
{
    AVPlayer * player;
    AVPlayerLayer * playerLayer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)click:(id)sender {
    
    
    player = [[AVPlayer alloc] initWithURL:_videoUrl];
    playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
    playerLayer.frame = _image.frame;
    [self.view.layer addSublayer:playerLayer];
    [player play];
}
- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
