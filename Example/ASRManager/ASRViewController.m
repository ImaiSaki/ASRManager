//
//  ASRViewController.m
//  ASRManager
//
//  Created by koda on 04/09/2015.
//  Copyright (c) 2014 koda. All rights reserved.
//

#import "ASRViewController.h"
#import "ASRManager.h"


@interface ASRViewController ()<ASRManagerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *myTextField;

@end

@implementation ASRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(appDidBecomActive:)
     name:UIApplicationDidBecomeActiveNotification
     object:nil];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(appWillTerminate:)
     name:UIApplicationWillTerminateNotification
     object:nil];
    
    [ASRManager sharedInstance].delegate = self;
}

- (void)appDidBecomActive:(NSNotification*)notification{
    
    [[ASRManager sharedInstance] open];
}

- (void)appWillTerminate:(NSNotification*) notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"appWillTerminate\n");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)ASRManagerOnBarcodeScanned:(ASRManager *)manager value:(NSString *)value{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        _myTextField.text = value;
    });
}

@end
