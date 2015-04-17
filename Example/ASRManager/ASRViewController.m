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

#pragma mark - view Lifecycle

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
     NSLog(@"First ViewController : viewWillAppear");
    
    // Before view appears, Set AsReader SDK delegate
    [ASRManager sharedInstance].delegate = self;
    
    // Open session and AsReader Power ON
    [[ASRManager sharedInstance] open];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

     NSLog(@"First ViewController : viewWillDisappear");
    
    // Before view disappears, Remove AsReader SDK delegate
    [ASRManager sharedInstance].delegate = nil;
}

#pragma mark - Button Action

- (IBAction)tapToClear:(id)sender
{
    _inputTextField.text = @"";
}

#pragma mark - AsReaderManager Delegate Method

/**
 *    When AsReader scans barcode, call ASRManagerOnBarcodeScanned Method
 *
 *    @param manager ASRManager
 *    @param value   Scanned bar code
 */
-(void)ASRManagerOnBarcodeScanned:(ASRManager *)manager value:(NSString *)value
{
     NSLog(@"First ViewController : ASRManagerOnBarcodeScanned");
    
    _inputTextField.text = value;
    
    // Move Next Page
    [self performSegueWithIdentifier:@"pushToSecond" sender:self];
}

/**
 *    When changes AsReader's connection status, call ASRManagerPlugged Method
 *
 *    @param manager   ASRManager
 *    @param isPlugged AsReader's connection status
 *                     true  : AsReader plugged
 *                     false : AsReader unplugged
 */
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

/**
 *    When receives AsReader's battery status, call ASRManagerBattery Method
 *
 *    @param manager ASRManager
 *    @param battery AsReader's battery status
 *                   Max        : 100
 *                   Mix        :   0
 *                   increments :  25
 */
-(void)ASRManagerBattery:(ASRManager *)manager battery:(int)battery
{
    NSLog(@"First ViewController : ASRManagerBattery");
    NSLog(@"First ViewController : battery %d%%",battery);
}

@end
