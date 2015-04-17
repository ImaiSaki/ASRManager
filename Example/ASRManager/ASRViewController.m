//
//  ASRViewController.m
//  ASRManager
//
//  Created by Asterisk Inc. on 04/09/2015.
//  Copyright (c) 2015 Asterisk Inc. All rights reserved.
//

#import "ASRManager.h"
#import "ASRViewController.h"
#import <Foundation/Foundation.h>

@interface ASRViewController()

@end

@implementation ASRViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
     NSLog(@"First ViewController : viewWillAppear");
    
    // 画面表示前にAsReaderSDKをセットして開始する
    [ASRManager sharedInstance].delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

     NSLog(@"First ViewController : viewWillDisappear");
    
    // 画面非表示にAsReaderSDKのデリゲートをnilに
    [ASRManager sharedInstance].delegate = nil;
}

#pragma mark Action

- (IBAction)tapToClear:(id)sender {
    _inputTextField.text = @"";
}

#pragma mark AsReaderManager Delegate Method


-(void)ASRManagerOnBarcodeScanned:(ASRManager *)manager value:(NSString *)value
{
    _inputTextField.text = value;
    NSLog(@"First ViewController : ASRManagerOnBarcodeScanned");
    [self performSegueWithIdentifier:@"pushToSecond" sender:self];
}

-(void)ASRManagerPlugged:(ASRManager *)manager isPlugged:(BOOL)isPlugged
{
    NSLog(@"First ViewController : ASRManagerPlugged");
    
    if(isPlugged)
    {
        NSLog(@"First ViewController : AsReader Plugged");
    }
    else
    {
        NSLog(@"First ViewController : AsReader Unplugged");
    }
}

-(void)ASRManagerBattery:(ASRManager *)manager battery:(int)battery
{
    NSLog(@"First ViewController : ASRManagerBattery");
    NSLog(@"First ViewController : battery %d%%",battery);
}

@end
