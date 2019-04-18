//
//  GWObjectiveCViewController.m
//  GWMarkSlider
//
//  Created by Will on 2/7/17.
//  Copyright © 2017 gewill.org. All rights reserved.
//

#import "GWObjectiveCViewController.h"
#import "GWMarkSlider-Swift.h"

@interface GWObjectiveCViewController ()
@property (strong, nonatomic) IBOutlet GWMarkSlider *slider;

@end

@implementation GWObjectiveCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    GWMarkInfo *markInfo1 = [[GWMarkInfo alloc] init];
    markInfo1.value = 0.3;
    markInfo1.image = [UIImage imageNamed:@"bg"];
    
    GWMarkInfo *markInfo2 = [[GWMarkInfo alloc] init];
    markInfo2.value = 0.6;
    markInfo2.image = [UIImage imageNamed:@"bg2"];
    
    _slider.markInfos = @[markInfo1, markInfo2];
    
}

- (IBAction)sliderValueChanged:(GWMarkSlider *)sender {
    NSLog(@"%s value: %f", __FUNCTION__ ,sender.currentValue);
}
- (IBAction)sliderMarkClicked:(GWMarkSlider *)sender {
     NSLog(@"%s value: %f index: %d" , __FUNCTION__ ,sender.currentValue, sender.selectedMarkIndex);
}
- (IBAction)sliderTouchUpInside:(GWMarkSlider *)sender {
     NSLog(@"%s value: %f", __FUNCTION__ ,sender.currentValue);
}
- (IBAction)sliderTouchDown:(GWMarkSlider *)sender {
     NSLog(@"%s value: %f", __FUNCTION__ ,sender.currentValue);
}

@end
