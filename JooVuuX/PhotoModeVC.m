//
//  PhotoModeVC.m
//  JooVuuX
//
//  Created by Vladislav on 29.09.15.
//  Copyright (c) 2015 lsoft. All rights reserved.
//

#import "PhotoModeVC.h"
#import "ModeTwoVC.h"
#import "ModeSettingsVC.h"
#import "CameraManager.h"
#import "StreamVC.h"

@interface PhotoModeVC ()
{
    BOOL dateTimestampCheck;
    BOOL photoResolutionCheck;
    BOOL rotatePhotosCheck;
    BOOL timeLapsePhotoCheck;
    BOOL timeLapseVideoCheck;
    BOOL burstPhotoModeCheck;
    BOOL checkWindow;

}

@property(strong, nonatomic) UIButton* button;
@property (strong, nonatomic)UIImageView * imageViewRight;

@end

@implementation PhotoModeVC


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
        
    for (UITableViewCell * cell in self.photoResolutionCollection) {
        [self cell:cell setHidden:YES];
        [self reloadDataAnimated:NO];
        photoResolutionCheck = YES;
    }
    
    for (UITableViewCell * cell in self.burstPhotoModeCollection) {
        [self cell:cell setHidden:YES];
        [self reloadDataAnimated:NO];
        burstPhotoModeCheck = YES;
    }
    
    
    
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(alertCamera21) name:@"camera21" object:nil];
    //if ([[NSUserDefaults standardUserDefaults] boolForKey:@"firstOpenPhotoModeKEY"]) {
        [self loadAllSettings];
    //}
}

-(void)alertCamera21
{
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Camera is recording now, the setting has not been set on the camera" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alertView show];
}

-(void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    
    [self saveAllSettings];
}


- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) saveAllSettings
{
    [[NSUserDefaults standardUserDefaults] setValue:self.photoResolutionDestinationLabel.text forKey:@"photoResolutionDestinationLabel"];
    [[NSUserDefaults standardUserDefaults] setValue:self.burstPhotoDestinationLabel.text forKey:@"burstPhotoDestinationLabel"];
    
    [[NSUserDefaults standardUserDefaults] setBool:dateTimestampCheck forKey:@"dateTimestampCheck"];
    [[NSUserDefaults standardUserDefaults] setBool:rotatePhotosCheck forKey:@"rotatePhotosCheck"];
    [[NSUserDefaults standardUserDefaults] setBool:timeLapsePhotoCheck forKey:@"timeLapsePhotoCheck"];
    [[NSUserDefaults standardUserDefaults] setBool:timeLapseVideoCheck forKey:@"timeLapseVideoCheck"];

    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstOpenPhotoModeKEY"];
}

-(void) loadAllSettings
{
    self.photoResolutionDestinationLabel.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"photoResolutionDestinationLabel"];
    self.burstPhotoDestinationLabel.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"burstPhotoDestinationLabel"];

    dateTimestampCheck = [[NSUserDefaults standardUserDefaults] boolForKey:@"dateTimestampCheck"];
    rotatePhotosCheck = [[NSUserDefaults standardUserDefaults] boolForKey:@"rotatePhotosCheck"];
    timeLapsePhotoCheck = [[NSUserDefaults standardUserDefaults] boolForKey:@"timeLapsePhotoCheck"];
    timeLapseVideoCheck = [[NSUserDefaults standardUserDefaults] boolForKey:@"timeLapseVideoCheck"];
    
    if (!dateTimestampCheck) {
        [self.dateTimestamp setTitle:@"OFF" forState:UIControlStateNormal];
        [self.dateTimestamp setBackgroundColor:[UIColor colorWithRed:166/256.0 green:166/256.0 blue:166/256.0 alpha:1]];
    } else {
        [self.dateTimestamp setTitle:@"ON" forState:UIControlStateNormal];
        [self.dateTimestamp setBackgroundColor:[UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1]];
    }
    
    if (!rotatePhotosCheck) {
        [self.rotatePhotos setTitle:@"OFF" forState:UIControlStateNormal];
        [self.rotatePhotos setBackgroundColor:[UIColor colorWithRed:166/256.0 green:166/256.0 blue:166/256.0 alpha:1]];
    } else {
        [self.rotatePhotos setTitle:@"ON" forState:UIControlStateNormal];
        [self.rotatePhotos setBackgroundColor:[UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1]];
    }
    
    if (!timeLapsePhotoCheck) {
        [self.timeLapsePhoto setTitle:@"OFF" forState:UIControlStateNormal];
        [self.timeLapsePhoto setBackgroundColor:[UIColor colorWithRed:166/256.0 green:166/256.0 blue:166/256.0 alpha:1]];
    } else {
        [self.timeLapsePhoto setTitle:@"ON" forState:UIControlStateNormal];
        [self.timeLapsePhoto setBackgroundColor:[UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1]];
    }
    
    if (!timeLapseVideoCheck) {
        [self.timeLapseVideo setTitle:@"OFF" forState:UIControlStateNormal];
        [self.timeLapseVideo setBackgroundColor:[UIColor colorWithRed:166/256.0 green:166/256.0 blue:166/256.0 alpha:1]];
    } else {
        [self.timeLapseVideo setTitle:@"ON" forState:UIControlStateNormal];
        [self.timeLapseVideo setBackgroundColor:[UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1]];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    return 40;
}


- (UIView*) tableView: (UITableView*) tableView viewForHeaderInSection: (NSInteger)section {
    
    self.button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.button addTarget:self
                    action:@selector(aMethod:)
          forControlEvents:UIControlEventTouchUpInside];
    self.button.backgroundColor = [UIColor clearColor];
    self.button.frame = CGRectMake((self.view.frame.size.width) - 70, 3.0, 60, 35);
    
    self.imageViewRight = [[UIImageView alloc]
                           initWithFrame:CGRectMake((self.view.frame.size.width) - 50, 8.0, 15, 25)];
    UIImage *btnImage = [UIImage imageNamed:@"arrow_right_mode_pick.png"];
    self.imageViewRight.image = btnImage;
    
    if ([self.orientation isEqualToString:@"Landscape"])
    {
        self.button.frame = CGRectMake((self.view.frame.size.width) - 70, 3.0, 60, 35);
        self.imageViewRight.frame = CGRectMake((self.view.frame.size.width) - 50, 8.0, 15, 25);
    }
    if ([self.orientation isEqualToString:@"Portrait"])
    {
        self.button.frame = CGRectMake((self.view.frame.size.width) - 70, 3.0, 60, 35);
        self.imageViewRight.frame = CGRectMake((self.view.frame.size.width) - 50, 8.0, 15, 25);
    }
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button1 addTarget:self
                action:@selector(backMode:)
      forControlEvents:UIControlEventTouchUpInside];
    button1.backgroundColor = [UIColor clearColor];
    button1.frame = CGRectMake(10, 3.0, 60, 35);
    
    UIImageView *imageViewLeft = [[UIImageView alloc]
                                  initWithFrame:CGRectMake( 30, 8.0, 15, 25)];
    UIImage *btnI = [UIImage imageNamed:@"arrow_left_mode_pick.png"];
    imageViewLeft.image = btnI;

    
    UIView* view = [[UIView alloc] init];
    UILabel* label = [[UILabel alloc] init];
    [view setBackgroundColor:[UIColor clearColor]];
    label.text = [self tableView: tableView titleForHeaderInSection: section];
    label.textAlignment = NSTextAlignmentCenter;
    [label sizeToFit];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    [label setTextColor:[UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1]];
    [label setFont:[UIFont systemFontOfSize:12]];
    [view addSubview:label];
    [view addConstraints:
     @[[NSLayoutConstraint constraintWithItem:label
                                    attribute:NSLayoutAttributeCenterX
                                    relatedBy:NSLayoutRelationEqual
                                       toItem:view
                                    attribute:NSLayoutAttributeCenterX
                                   multiplier:1 constant:0],
       [NSLayoutConstraint constraintWithItem:label
                                    attribute:NSLayoutAttributeCenterY
                                    relatedBy:NSLayoutRelationEqual
                                       toItem:view
                                    attribute:NSLayoutAttributeCenterY
                                   multiplier:1 constant:0]]];
    
    [view addSubview:self.button];
    [view addSubview:button1];
    [view addSubview:self.imageViewRight];
    [view addSubview:imageViewLeft];

    return view;
}


- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    if (fromInterfaceOrientation == UIInterfaceOrientationPortrait) {
        [UIView animateWithDuration:0 animations:^{
            self.button.frame = CGRectMake((self.view.frame.size.width) - 70, 3.0, 60, 35);
            self.imageViewRight.frame = CGRectMake((self.view.frame.size.width) - 50, 8.0, 15, 25);
        }];
    }
    if (fromInterfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
        [UIView animateWithDuration:0 animations:^{
            self.button.frame = CGRectMake((self.view.frame.size.width) - 70, 3.0, 60, 35);
            self.imageViewRight.frame = CGRectMake((self.view.frame.size.width) - 50, 8.0, 15, 25);
        }];
    }
    if (fromInterfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        [UIView animateWithDuration:0 animations:^{
            self.imageViewRight.frame = CGRectMake((self.view.frame.size.width) - 50, 8.0, 15, 25);
            self.button.frame = CGRectMake((self.view.frame.size.width) - 70, 3.0, 60, 35);
        }];
    }
}


-(void)aMethod:(UIButton*) button {
    
    ModeSettingsVC * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ModeSettingsVC"];
    vc.orientation = self.orientation;
    [self.navigationController pushViewController:vc animated:NO];
}

-(void)backMode:(UIButton*) button {
    
    ModeTwoVC * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ModeTwoVC"];
    vc.orientation = self.orientation;
    [self.navigationController pushViewController:vc animated:NO];
}


-(void) showPhotoResolutionCollection {
    
    if (photoResolutionCheck) {
        for (UITableViewCell * cell in self.photoResolutionCollection) {
            [self cell:cell setHidden:NO];
            [self reloadDataAnimated:YES];
            photoResolutionCheck = NO;
            
        }
    } else {
        
        for (UITableViewCell * cell in self.photoResolutionCollection) {
            [self cell:cell setHidden:YES];
            [self reloadDataAnimated:YES];
            photoResolutionCheck = YES;
            
        }
    }
}


-(void) showBurstPhotoModeCollection
{
    if (burstPhotoModeCheck) {
        for (UITableViewCell * cell in self.burstPhotoModeCollection) {
            [self cell:cell setHidden:NO];
            [self reloadDataAnimated:YES];
            burstPhotoModeCheck = NO;
            
        }
    } else {
        
        for (UITableViewCell * cell in self.burstPhotoModeCollection) {
            [self cell:cell setHidden:YES];
            [self reloadDataAnimated:YES];
            burstPhotoModeCheck = YES;
            
        }
    }
}


#pragma mark - Actions

- (IBAction)backButton:(UIBarButtonItem *)sender {
    
    checkWindow = [[NSUserDefaults standardUserDefaults] boolForKey:@"checkWindows"];
    if (checkWindow) {
        checkWindow = YES;
        [[NSUserDefaults standardUserDefaults] setBool:checkWindow forKey:@"checkWindows"];
        for (UIViewController *controller in self.navigationController.viewControllers)
        {
            if ([controller isKindOfClass:[StreamVC class]])
            {
                [self.navigationController popToViewController:controller animated:YES];
                break;
            }
        }
    }else {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

- (IBAction)dateTimestampButton:(UIButton *)sender {
    
    if (!dateTimestampCheck) {
         [[CameraManager cameraManager] params:@"on" type:@"date_time_stamp"];
        [self.dateTimestamp setTitle:@"ON" forState:UIControlStateNormal];
        [self.dateTimestamp setBackgroundColor:[UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1]];
        dateTimestampCheck = YES;
        
    } else {
        [[CameraManager cameraManager] params:@"off" type:@"date_time_stamp"];
        [self.dateTimestamp setTitle:@"OFF" forState:UIControlStateNormal];
        [self.dateTimestamp setBackgroundColor:[UIColor colorWithRed:166/256.0 green:166/256.0 blue:166/256.0 alpha:1]];
        dateTimestampCheck = NO;
        
    }
    
}

- (IBAction)photoResolutionButton:(UIButton *)sender {
    
    [self showPhotoResolutionCollection];
}




- (IBAction)rotatePhotosButton:(UIButton *)sender {
    
    if (!rotatePhotosCheck) {
         [[CameraManager cameraManager] params:@"on" type:@"rotate_photo_180_degrees"];
        [self.rotatePhotos setTitle:@"ON" forState:UIControlStateNormal];
        [self.rotatePhotos setBackgroundColor:[UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1]];
        rotatePhotosCheck = YES;
    } else {
         [[CameraManager cameraManager] params:@"off" type:@"rotate_photo_180_degrees"];
        [self.rotatePhotos setTitle:@"OFF" forState:UIControlStateNormal];
        [self.rotatePhotos setBackgroundColor:[UIColor colorWithRed:166/256.0 green:166/256.0 blue:166/256.0 alpha:1]];
        rotatePhotosCheck = NO;
    }

}
- (IBAction)timeLapsePhotoButton:(UIButton *)sender {
    
    if (!timeLapsePhotoCheck) {
         [[CameraManager cameraManager] params:@"on" type:@"time_lapse_photo"];
        [self.timeLapsePhoto setTitle:@"ON" forState:UIControlStateNormal];
        [self.timeLapsePhoto setBackgroundColor:[UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1]];
        timeLapsePhotoCheck = YES;
        
    } else {
        [[CameraManager cameraManager] params:@"off" type:@"time_lapse_photo"];
        [self.timeLapsePhoto setTitle:@"OFF" forState:UIControlStateNormal];
        [self.timeLapsePhoto setBackgroundColor:[UIColor colorWithRed:166/256.0 green:166/256.0 blue:166/256.0 alpha:1]];
        timeLapsePhotoCheck = NO;
    }
}

- (IBAction)timeLapseVideoButton:(UIButton *)sender {
    
    if (!timeLapseVideoCheck) {
        [[CameraManager cameraManager] params:@"on" type:@"timelapse_photo"];
        [self.timeLapseVideo setTitle:@"ON" forState:UIControlStateNormal];
        [self.timeLapseVideo setBackgroundColor:[UIColor colorWithRed:72/256.0 green:216/256.0 blue:183/256.0 alpha:1]];
        timeLapseVideoCheck = YES;
        
    } else {
         [[CameraManager cameraManager] params:@"off" type:@"timelapse_photo"];
        [self.timeLapseVideo setTitle:@"OFF" forState:UIControlStateNormal];
        [self.timeLapseVideo setBackgroundColor:[UIColor colorWithRed:166/256.0 green:166/256.0 blue:166/256.0 alpha:1]];
        timeLapseVideoCheck = NO;
    }
}

- (IBAction)burstPhotoModeButton:(UIButton *)sender {
    [self showBurstPhotoModeCollection];
}


#pragma mark -ActionsSetData
- (IBAction)photoResolution1Button:(UIButton *)sender {
    self.photoResolutionDestinationLabel.text = self.photoResolution1Label.text;
    [[CameraManager cameraManager] params:@"13M" type:@"photo_resolution"];
    for (UITableViewCell * cell in self.photoResolutionCollection) {
        [self cell:cell setHidden:YES];
        [self reloadDataAnimated:YES];
        photoResolutionCheck = YES;
    }
}

- (IBAction)photoResolution2Button:(UIButton *)sender {
    self.photoResolutionDestinationLabel.text = self.photoResolution2Label.text;
     [[CameraManager cameraManager] params:@"8M" type:@"photo_resolution"];
    for (UITableViewCell * cell in self.photoResolutionCollection) {
        [self cell:cell setHidden:YES];
        [self reloadDataAnimated:YES];
        photoResolutionCheck = YES;
    }
}

- (IBAction)photoResolution3Button:(UIButton *)sender {
    self.photoResolutionDestinationLabel.text = self.photoResolution3Label.text;
     [[CameraManager cameraManager] params:@"5M" type:@"photo_resolution"];
    for (UITableViewCell * cell in self.photoResolutionCollection) {
        [self cell:cell setHidden:YES];
        [self reloadDataAnimated:YES];
        photoResolutionCheck = YES;
    }
}




- (IBAction)burstPhoto1Button:(UIButton *)sender {
    self.burstPhotoDestinationLabel.text = self.burstPhoto1Label.text;
     [[CameraManager cameraManager] params:@"off" type:@"spinnerBurstPhotoMode"];
    for (UITableViewCell * cell in self.burstPhotoModeCollection) {
        [self cell:cell setHidden:YES];
        [self reloadDataAnimated:YES];
        burstPhotoModeCheck = YES;
    }
}

- (IBAction)burstPhoto2Button:(UIButton *)sender {
    self.burstPhotoDestinationLabel.text = self.burstPhoto2Label.text;
      [[CameraManager cameraManager] params:@"5" type:@"spinnerBurstPhotoMode"];
    for (UITableViewCell * cell in self.burstPhotoModeCollection) {
        [self cell:cell setHidden:YES];
        [self reloadDataAnimated:YES];
        burstPhotoModeCheck = YES;
    }

}

- (IBAction)burstPhoto3Button:(UIButton *)sender {
    self.burstPhotoDestinationLabel.text = self.burstPhoto3Label.text;
      [[CameraManager cameraManager] params:@"10" type:@"spinnerBurstPhotoMode"];
    for (UITableViewCell * cell in self.burstPhotoModeCollection) {
        [self cell:cell setHidden:YES];
        [self reloadDataAnimated:YES];
        burstPhotoModeCheck = YES;
    }

}



@end