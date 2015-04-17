//
//  ASRSecondViewController.m
//  ASRManager
//
//  Created by Asterisk Inc. on 04/09/2015.
//  Copyright (c) 2015 Asterisk Inc. All rights reserved.
//

#import "ASRManager.h"
#import "ASRSecondViewController.h"
#import <Foundation/Foundation.h>

@interface ASRSecondViewController ()

@end

@implementation ASRSecondViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
     NSLog(@"Second ViewController : viewWillAppear");
    
    // 画面表示前にAsReaderSDKをセットして開始する
    [ASRManager sharedInstance].delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
     NSLog(@"Second ViewController : viewWillDisappear");
    
    // 画面非表示にAsReaderSDKのデリゲートをnilに
    [ASRManager sharedInstance].delegate = nil;
}

#pragma mark Action

- (IBAction)tapToClear:(id)sender {
    _SecondInputTextField.text = @"";
}

#pragma mark AsReaderManager Delegate Method

-(void)ASRManagerOnBarcodeScanned:(ASRManager *)manager value:(NSString *)value
{
    NSLog(@"Second ViewController : ASRManagerOnBarcodeScanned");
    _SecondInputTextField.text = value;

}

-(void)ASRManagerPlugged:(ASRManager *)manager isPlugged:(BOOL)isPlugged
{
    NSLog(@"Second ViewController : ASRManagerPlugged");
    
    if(isPlugged)
    {
        NSLog(@"Second ViewController : AsReader Plugged");
    }
    else
    {
        NSLog(@"Second ViewController : AsReader Unplugged");
    }
}

-(void)ASRManagerBattery:(ASRManager *)manager battery:(int)battery
{
    NSLog(@"Second ViewController : ASRManagerBattery");
    NSLog(@"Second ViewController : battery %d%%",battery);
}

@end

