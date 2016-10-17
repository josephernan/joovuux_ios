//
//  WhiteBalanceVC.m
//  JooVuuX
//
//  Created by Andrey on 01.10.15.
//  Copyright (c) 2015 lsoft. All rights reserved.
//

#import "WhiteBalanceVC.h"
#import "KAProgressLabel.h"
#import "NMRangeSlider.h"
#import "CameraManager.h"
#import "AppDelegate.h"
@interface WhiteBalanceVC ()
{
    float delta;
    float checkInt;
}
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *allView;

- (IBAction)sharpness:(NMRangeSlider*)sender;
@property (strong, nonatomic) IBOutlet NMRangeSlider *sharpness;

- (IBAction)contrast:(NMRangeSlider*)sender;
@property (strong, nonatomic) IBOutlet NMRangeSlider *contrast;

- (IBAction)whiteBalance:(NMRangeSlider*)sender;
@property (strong, nonatomic) IBOutlet NMRangeSlider *whiteBalance;
@property (weak, nonatomic) IBOutlet NMRangeSlider *saturationSlider;
- (IBAction)onSaturationChange:(NMRangeSlider*)sender;


@property (weak,nonatomic) IBOutlet KAProgressLabel * pLabel;
@property (weak, nonatomic) IBOutlet KAProgressLabel *backLabel;
@property (weak, nonatomic) IBOutlet KAProgressLabel *curcleLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic,retain) AppDelegate *appDelegate;

@property (strong, nonatomic) NSString * string;

@property (weak, nonatomic) IBOutlet UILabel *lblSaturationVal;
@property (weak, nonatomic) IBOutlet UILabel *lblContrastVal;
@property (weak, nonatomic) IBOutlet UILabel *lblSharpnessVal;


@end

@implementation WhiteBalanceVC


-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    
    [self saveSettings];
    
    //self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.appDelegate = [[UIApplication sharedApplication] delegate];
    
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:72/255.0 green:216/255.0 blue:183/255.0 alpha:1];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(touchEND)
                                                 name:@"touchENDED"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(touchBEGAN)
                                                 name:@"touchBEGAN"
                                               object:nil];

    
    [self.pLabel setText:[NSString stringWithFormat:@"2.0"]]; //Установка дефолтного значения лейблы
    self.pLabel.backgroundColor = [UIColor clearColor]; // Установка бекграунда крутилки
    [self.pLabel setTrackWidth: 8]; //Установка внутреннего ползунка
    self.pLabel.trackColor =  [UIColor colorWithRed:213.0 / 256.0 green:213.0 / 256.0 blue:213.0 / 256.0 alpha:1]; //Установка цвета внутреннего ползунка
    [self.pLabel setProgressWidth: 8]; // Установка внешнего ползунка
    self.pLabel.progressColor = [UIColor colorWithRed:54.0 / 256.0 green:216.0 / 256.0 blue:185.0 / 256.0 alpha:1]; //Установка цвета внешнего ползунка
    self.pLabel.fillColor = [UIColor clearColor];
    self.pLabel.isStartDegreeUserInteractive = NO; //Кликабельный конечный ползунок -- НЕ ТРОГАТЬ
    self.pLabel.isEndDegreeUserInteractive = YES; //Кликабельный начальный ползунок -- НЕ ТРОГАТЬ
    
    
    // [self.backLabel setText:[NSString stringWithFormat:@"0"]]; //Установка дефолтного значения лейблы
    self.backLabel.backgroundColor = [UIColor clearColor]; // Установка бекграунда крутилки
    [self.backLabel setTrackWidth: 3]; //Установка внутреннего ползунка
    self.backLabel.trackColor =  [UIColor colorWithRed:191.0 / 256.0 green:191.0 / 256.0 blue:191.0 / 256.0 alpha:1]; //Установка цвета внутреннего ползунка
    [self.backLabel setProgressWidth: 3]; // Установка внешнего ползунка
    self.backLabel.progressColor = [UIColor colorWithRed:49.0 / 256.0 green:195.0 / 256.0 blue:165.0 / 256.0 alpha:1]; //Установка цвета внешнего ползунка
    self.backLabel.fillColor = [UIColor colorWithRed:239.0 / 256.0 green:239.0 / 256.0 blue:239.0 / 256.0 alpha:1];
    self.backLabel.isStartDegreeUserInteractive = NO; //Кликабельный конечный ползунок -- НЕ ТРОГАТЬ
    self.backLabel.isEndDegreeUserInteractive = YES; //Кликабельный начальный ползунок -- НЕ ТРОГАТЬ
    
    
    
    // [self.curcleLabel setText:[NSString stringWithFormat:@"0"]]; //Установка дефолтного значения лейблы
    self.curcleLabel.backgroundColor = [UIColor clearColor]; // Установка бекграунда крутилки
    [self.curcleLabel setTrackWidth: 0]; //Установка внутреннего ползунка
    self.curcleLabel.trackColor =  [UIColor colorWithRed:191.0 / 256.0 green:191.0 / 256.0 blue:191.0 / 256.0 alpha:1]; //Установка цвета внутреннего ползунка
    [self.curcleLabel setProgressWidth: 0]; // Установка внешнего ползунка
    self.curcleLabel.progressColor = [UIColor colorWithRed:49.0 / 256.0 green:195.0 / 256.0 blue:165.0 / 256.0 alpha:1]; //Установка цвета внешнего ползунка
    self.curcleLabel.fillColor = [UIColor clearColor];
    self.curcleLabel.isStartDegreeUserInteractive = NO; //Кликабельный конечный ползунок -- НЕ ТРОГАТЬ
    self.curcleLabel.isEndDegreeUserInteractive = YES; //Кликабельный начальный ползунок -- НЕ ТРОГАТЬ
    [self.curcleLabel setRoundedCornersWidth:15];
    
    
    
    //[self.pLabel setStartDegree:0];  // Установка начальной точки
    //[self.pLabel setEndDegree:0];  // Установка конечной точки
    //[self.pLabel setTrackWidth:0];  //Хуй знает шо
    //[self.pLabel setProgressWidth:0]; //Хуй знает шо
    // [self.pLabel setProgress:1/100]; //Хуй знает шо
    //Установка размера кружочка
    //Установке внутреннего бека
    

    
    __unsafe_unretained WhiteBalanceVC * weakSelf = self;
    self.pLabel.labelVCBlock = ^(KAProgressLabel *label) {
        
        [self.backLabel setEndDegree:weakSelf.pLabel.endDegree];
        [self.curcleLabel setEndDegree:weakSelf.pLabel.endDegree];
        weakSelf.pLabel.endLabel.text = [NSString stringWithFormat:@"%.f",weakSelf.pLabel.endDegree];
        delta =label.endDegree-label.startDegree;
        if(delta<180){
            [label setText:[NSString stringWithFormat:@"%1.1f",((-delta+180)/90)]];
        }else{
            [label setText:[NSString stringWithFormat:@"%1.1f",((((delta-180))/90)* -1)]];
        }
        self.string = label.text;
    };

    [self configureMetalThemeForSlider:self.sharpness];
    self.sharpness.upperValue = 3;
    self.sharpness.maximumValue = 6;
    self.sharpness.lowerHandleHidden = YES;
    self.sharpness.stepValue = 1;
    self.sharpness.stepValueContinuously = YES;
    
    [self configureMetalThemeForSlider:self.contrast];
    self.contrast.upperValue = 128;
    self.contrast.maximumValue = 256;
    self.contrast.lowerHandleHidden = YES;
    self.contrast.stepValue = 1;
    self.contrast.stepValueContinuously = YES;
    
    [self configureMetalThemeForSlider:self.saturationSlider];
    self.saturationSlider.upperValue = 128;
    self.saturationSlider.maximumValue = 256;
    self.saturationSlider.lowerHandleHidden = YES;
    self.saturationSlider.stepValue = 1;
    self.saturationSlider.stepValueContinuously = YES;
    
    [self configureMetalThemeForSlider:self.whiteBalance];
    self.whiteBalance.upperValue = 0;
    self.whiteBalance.maximumValue = 2;
    self.whiteBalance.lowerHandleHidden = YES;
    self.whiteBalance.stepValue = 1;
    self.whiteBalance.stepValueContinuously = YES;

    [self.resetSettings addTarget:self action:@selector(resetSettingsButtonHighlight:) forControlEvents:UIControlEventTouchDown];
    [self.resetSettings addTarget:self action:@selector(resetSettingsButton:) forControlEvents:UIControlEventTouchDragOutside];
    
    [self loadSettings];
}


-(void) saveSettings
{
    [[NSUserDefaults standardUserDefaults] setFloat:delta forKey:@"exposureDeltaKEY"];
    [[NSUserDefaults standardUserDefaults] setFloat:self.sharpness.upperValue forKey:@"sharpnessUpperKEY"];
    [[NSUserDefaults standardUserDefaults] setFloat:self.contrast.upperValue forKey:@"contrastUpperKEY"];
    [[NSUserDefaults standardUserDefaults] setFloat:self.saturationSlider.upperValue forKey:@"saturationUpperKEY"];
    [[NSUserDefaults standardUserDefaults] setFloat:self.whiteBalance.upperValue forKey:@"whiteBalanceUpperKEY"];
}

-(void) loadSettings
{
    NSLog(@"%f",[[NSUserDefaults standardUserDefaults] floatForKey:@"exposureDeltaKEY"]);
    
    [self.backLabel setEndDegree:[[NSUserDefaults standardUserDefaults] floatForKey:@"exposureDeltaKEY"]];
    [self.curcleLabel setEndDegree:[[NSUserDefaults standardUserDefaults] floatForKey:@"exposureDeltaKEY"]];
    [self.pLabel setEndDegree:[[NSUserDefaults standardUserDefaults] floatForKey:@"exposureDeltaKEY"]];
    
    for (UILabel * label in self.whiteBalanceCollection) {
        [label setTextColor:[UIColor blackColor]];
    }
    for (UILabel * label in self.sharpnessLabelCollection) {
        [label setTextColor:[UIColor blackColor]];
    }
    for (UILabel * label in self.contrastLabelCollection) {
        [label setTextColor:[UIColor blackColor]];
    }
    
    
    int sharpness = [[NSUserDefaults standardUserDefaults] floatForKey:@"sharpnessUpperKEY"];
    [self.sharpness setUpperValue:sharpness animated:YES];
    UILabel * sharpnessLabel = [self.sharpnessLabelCollection objectAtIndex:sharpness];
    [sharpnessLabel setTextColor:[UIColor colorWithRed:49.0 / 256.0 green:195.0 / 256.0 blue:165.0 / 256.0 alpha:1]];
    
    int contrast = [[NSUserDefaults standardUserDefaults] floatForKey:@"contrastUpperKEY"];
    [self.contrast setUpperValue:contrast animated:YES];
    UILabel * contrastLabel = [self.contrastLabelCollection objectAtIndex:contrast];
    [contrastLabel setTextColor:[UIColor colorWithRed:49.0 / 256.0 green:195.0 / 256.0 blue:165.0 / 256.0 alpha:1]];
    
    int saturation = [[NSUserDefaults standardUserDefaults] floatForKey:@"saturationUpperKEY"];
    [self.saturationSlider setUpperValue:saturation animated:YES];
    
    int whiteBalance = [[NSUserDefaults standardUserDefaults] floatForKey:@"whiteBalanceUpperKEY"];
    [self.whiteBalance setUpperValue:whiteBalance animated:YES];
    UILabel * whiteBalanceLabel = [self.whiteBalanceCollection objectAtIndex:whiteBalance];
    [whiteBalanceLabel setTextColor:[UIColor colorWithRed:49.0 / 256.0 green:195.0 / 256.0 blue:165.0 / 256.0 alpha:1]];
}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
}

-(void) viewDidAppear:(BOOL)animated
{
    CGRect contentRect = CGRectZero;
    for (UIView *view in self.scrollView.subviews) {
        contentRect = CGRectUnion(contentRect, view.frame);
    }
    self.scrollView.contentSize = contentRect.size;
}

- (void)touchEND
{
    [self.scrollView setScrollEnabled:YES];
    
    checkInt = [self.pLabel.text floatValue];
    
    if (checkInt >= 1.8f && checkInt <= 2.0f) {
        [[CameraManager cameraManager] params:@"+2.0" type:@"exposure"];
    }else if (checkInt >= 1.4f  && checkInt <= 1.7f) {
        [[CameraManager cameraManager] params:@"+1.7" type:@"exposure"];
    }else if (checkInt >= 1.1f  && checkInt <= 1.3f) {
        [[CameraManager cameraManager] params:@"+1.3" type:@"exposure"];
    }else if (checkInt >= 0.8f  && checkInt <= 1.0f) {
        [[CameraManager cameraManager] params:@"+1.0" type:@"exposure"];
    }else if (checkInt >= 0.4f  && checkInt <= 0.7f) {
        [[CameraManager cameraManager] params:@"+0.7" type:@"exposure"];
    }else if (checkInt >= 0.1f  && checkInt <= 0.3f) {
        [[CameraManager cameraManager] params:@"+0.3" type:@"exposure"];
    }else if (checkInt >= -0.2f  && checkInt <= 0.0f) {
        [[CameraManager cameraManager] params:@"0.0" type:@"exposure"];
    }else if (checkInt >= -0.6f  && checkInt <= -0.3f) {
        [[CameraManager cameraManager] params:@"-0.3" type:@"exposure"];
    }else if (checkInt >= -0.9f  && checkInt <= -0.7f) {
        [[CameraManager cameraManager] params:@"-0.7" type:@"exposure"];
    }else if (checkInt >= -1.2f  && checkInt <= -1.0f) {
        [[CameraManager cameraManager] params:@"-1.0" type:@"exposure"];
    }else if (checkInt >= -1.6f  && checkInt <= -1.3f) {
        [[CameraManager cameraManager] params:@"-1.3" type:@"exposure"];
    }else if (checkInt >= -1.9f  && checkInt <= -1.7f) {
        [[CameraManager cameraManager] params:@"-1.7" type:@"exposure"];
    }else if (checkInt < -1.9f) {
        [[CameraManager cameraManager] params:@"-2.0" type:@"exposure"];
    }
}

-(void)touchBEGAN
{
    [self.scrollView setScrollEnabled:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) setLabelColorInSortedSharpnessArray:(NSArray *)array slider:(NMRangeSlider *)slider valueForKey:(NSString *)key reset:(BOOL)reset
{
    for (UILabel * label in self.sharpnessLabelCollection) {
        [label setTextColor:[UIColor blackColor]];
    }
    if (!reset) {
        int value = slider.upperValue;
        [slider setUpperValue:value animated:YES];
        UILabel * label = [array objectAtIndex:value];
        [label setTextColor:[UIColor colorWithRed:49.0 / 256.0 green:195.0 / 256.0 blue:165.0 / 256.0 alpha:1]];
    }
}

-(void) setLabelColorInSortedContrastArray:(NSArray *)array slider:(NMRangeSlider *)slider valueForKey:(NSString *)key reset:(BOOL)reset
{
    for (UILabel * label in self.contrastLabelCollection) {
        [label setTextColor:[UIColor blackColor]];
    }
    if (!reset) {
        int value = slider.upperValue;
        [slider setUpperValue:value animated:YES];
        UILabel * label = [array objectAtIndex:value];
        [label setTextColor:[UIColor colorWithRed:49.0 / 256.0 green:195.0 / 256.0 blue:165.0 / 256.0 alpha:1]];
    }
}

-(void) setLabelColorInSortedWhiteBalanceArray:(NSArray *)array slider:(NMRangeSlider *)slider valueForKey:(NSString *)key reset:(BOOL)reset
{
    for (UILabel * label in self.whiteBalanceCollection) {
        [label setTextColor:[UIColor blackColor]];
    }
    if (!reset) {
        int value = slider.upperValue;
        [slider setUpperValue:value animated:YES];
        UILabel * label = [array objectAtIndex:value];
        [label setTextColor:[UIColor colorWithRed:49.0 / 256.0 green:195.0 / 256.0 blue:165.0 / 256.0 alpha:1]];
    }
}

- (IBAction)sharpness:(NMRangeSlider *)sender
{
    NSString * strVal = [[NSNumber numberWithFloat:sender.upperValue] stringValue];
    [[CameraManager cameraManager ] params:strVal type:@"sharpness"];
    self.lblSharpnessVal.text = strVal;
}

- (IBAction)contrast:(NMRangeSlider *)sender
{
    NSString * strVal = [[NSNumber numberWithFloat:sender.upperValue] stringValue];
    [[CameraManager cameraManager ] params:strVal type:@"contrast"];
    self.lblContrastVal.text = strVal;
}

- (IBAction)onSaturationChange:(NMRangeSlider *)sender {

    NSString * strVal = [[NSNumber numberWithFloat:sender.upperValue] stringValue];
    [[CameraManager cameraManager ] params:strVal type:@"saturation"];
    self.lblSaturationVal.text = strVal;
}

- (IBAction)whiteBalance:(NMRangeSlider *)sender
{
    [self setLabelColorInSortedWhiteBalanceArray:self.whiteBalanceCollection slider:self.whiteBalance valueForKey:nil reset:NO];
    if (sender.upperValue == 0) {
        [[CameraManager cameraManager ] params:@"AUTO" type:@"white_balance"];
    }else if (sender.upperValue == 1) {
        [[CameraManager cameraManager ] params:@"SUNNY" type:@"white_balance"];
    }else if (sender.upperValue == 2){
        [[CameraManager cameraManager ] params:@"CLOUDY" type:@"white_balance"];
    }
}

-(void) configureSlider:(NMRangeSlider *)slider lowerLabel:(UILabel *)lowerLabel upperLabel:(UILabel *)upperLaber labelText:(NSString*)text
{
    CGPoint lowerCenter;
    lowerCenter.x = (slider.lowerCenter.x + slider.frame.origin.x);
    lowerCenter.y = (slider.center.y + 20.0f);
    
    lowerLabel.center = lowerCenter;
    lowerLabel.text = [NSString stringWithFormat:@"%d%@", (int)slider.lowerValue, text];
    
    CGPoint upperCenter;
    upperCenter.x = (slider.upperCenter.x + slider.frame.origin.x);
    upperCenter.y = (slider.center.y + 20.0f);
    
    upperLaber.center = upperCenter;
    upperLaber.text = [NSString stringWithFormat:@"%d%@", (int)slider.upperValue, text];
}

- (void) configureMetalThemeForSlider:(NMRangeSlider*) slider
{
    UIImage* image = nil;
    
    image = [UIImage imageNamed:@"slider-metal-trackBackground"];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 7.0, 0.0, 7.0)];
    slider.trackBackgroundImage = image;
    
    image = [UIImage imageNamed:@"slider-metal-track"];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 7.0, 0.0, 7.0)];
    slider.trackImage = image;
    
    image = [UIImage imageNamed:@"slider-metal-handle"];
    image = [image imageWithAlignmentRectInsets:UIEdgeInsetsMake(-1, 2, 1, 2)];
    slider.lowerHandleImageNormal = image;
    slider.upperHandleImageNormal = image;
    
    image = [UIImage imageNamed:@"slider-metal-handle-highlighted"];
    image = [image imageWithAlignmentRectInsets:UIEdgeInsetsMake(-1, 2, 1, 2)];
    slider.lowerHandleImageHighlighted = image;
    slider.upperHandleImageHighlighted = image;
}


-(void) alertResetSettings
{
    UIAlertView *subAlert = [[UIAlertView alloc] initWithTitle:@""
                                                       message:@"Reset Settings Did Complete Successfully."
                                                      delegate:self
                                             cancelButtonTitle:@"Close"
                                             otherButtonTitles:nil];
    [subAlert show];
}

- (IBAction)back:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)resetAllSettings:(UIButton *)sender {
    
    self.resetAllSettingsLabel.backgroundColor = [UIColor colorWithRed:166/256.0 green:166/256.0 blue:166/256.0 alpha:1];
    int WB = 0;
    int value = 1;
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        
        if ([self.appDelegate isConnected]) {
            [[CameraManager cameraManager ] resetAllSettings:@"AUTO" type:@"white_balance"];
            [[CameraManager cameraManager ] resetAllSettings:@"64" type:@"contrast"];
            [[CameraManager cameraManager ] resetAllSettings:@"3" type:@"sharpness"];
            [[CameraManager cameraManager ] resetAllSettings:@"64" type:@"saturation"];
            [[CameraManager cameraManager] resetAllSettings:@"0.0" type:@"exposure"];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            for (UILabel * label in self.sharpnessLabelCollection) {
                [label setTextColor:[UIColor blackColor]];
            }
            
            [self.sharpness setUpperValue:3 animated:YES];
            self.lblSharpnessVal.text = @"3";
            
            UILabel * label = [self.sharpnessLabelCollection objectAtIndex:value];
            [label setTextColor:[UIColor colorWithRed:49.0 / 256.0 green:195.0 / 256.0 blue:165.0 / 256.0 alpha:1]];
            
            for (UILabel * label1 in self.contrastLabelCollection) {
                [label1 setTextColor:[UIColor blackColor]];
            }
            
            [self.contrast setUpperValue:64 animated:YES];
            self.lblContrastVal.text = @"64";
            [self.saturationSlider setUpperValue:64 animated:YES];
            self.lblSaturationVal.text = @"64";
            UILabel * label1 = [self.contrastLabelCollection objectAtIndex:value];
            [label1 setTextColor:[UIColor colorWithRed:49.0 / 256.0 green:195.0 / 256.0 blue:165.0 / 256.0 alpha:1]];
            
            self.whiteBalance.upperValue = WB;
            
            for (UILabel * label3 in self.whiteBalanceCollection) {
                [label3 setTextColor:[UIColor blackColor]];
            }
            
            [self.whiteBalance setUpperValue:WB animated:YES];
            UILabel * label3 = [self.whiteBalanceCollection objectAtIndex:WB];
            [label3 setTextColor:[UIColor colorWithRed:49.0 / 256.0 green:195.0 / 256.0 blue:165.0 / 256.0 alpha:1]];
            
            [self.backLabel setEndDegree:179.0f];
            [self.curcleLabel setEndDegree:179.0f];
            [self.pLabel setEndDegree:179.0f];
            
            [self alertResetSettings];
  
        });
    });
}


-(void)resetSettingsButtonHighlight:(UIButton*) button {
    
    self.resetAllSettingsLabel.backgroundColor = [UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1];
}

-(void)resetSettingsButton:(UIButton*) button {
    
    self.resetAllSettingsLabel.backgroundColor = [UIColor colorWithRed:149/256.0 green:149/256.0 blue:149/256.0 alpha:1];
}


@end
