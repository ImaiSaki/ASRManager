//
//  ASRViewController.h
//  ASRManager
//
//  Created by Asterisk Inc. on 04/09/2015.
//  Copyright (c) 2015 Asterisk Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ASRViewController : UIViewController<ASRManagerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *inputTextField;

@end