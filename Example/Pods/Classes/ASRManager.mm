//
//  ASR510RManager.m
//  SampleASManager
//
//  Created by Asterisk on 2014/11/12.
//  Copyright (c) 2014年 Asterisk. All rights reserved.
//

#import "ASRManager.h"
/**
 * AsReaderSDKの管理クラス(AsReader2)
 */
@interface ASRManager()
{
    /** AsReaderSDKのインスタンス */
    RcpBarcodeApi *asReaderApi_;
    /** バーコードのエンコーディング */
    NSStringEncoding barcodeEncoding;
}

@end

@implementation ASRManager

@synthesize delegate;
@synthesize debugText;

/**
 * インスタンス取得
 */
+ (instancetype)sharedInstance
{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

//---------------------------------------------------------------------------------------------------------
#pragma mark - LifeCycle
//---------------------------------------------------------------------------------------------------------
/**
 * 初期化
 */
- (id)init
{
    self = [super init];
    
    if(self){
        asReaderApi_ = [[RcpBarcodeApi alloc] init];
        asReaderApi_.delegate = self;
        
        barcodeEncoding = NSShiftJISStringEncoding;
    }
    return self;
}

//---------------------------------------------------------------------------------------------------------
#pragma mark - PublicMethod
//---------------------------------------------------------------------------------------------------------
/**
 * 接続を開く
 */
- (void)open
{
    if([asReaderApi_ isOpened]){
        dispatch_async(dispatch_get_main_queue(),^{
            [asReaderApi_ open];
            [asReaderApi_ setReaderPower:YES];
        });
    }
}

/**
 * 接続を閉じる
 */
- (void)close
{
    dispatch_async(dispatch_get_main_queue(),^{
        
        [asReaderApi_ setReaderPower:NO];
        [asReaderApi_ close];
    });
}

/**
 * バーコードの変換エンコードをセット
 */
- (void)setBarcodeEncoding:(NSStringEncoding)encoding
{
    barcodeEncoding = encoding;
}

- (void)startReadBarcodeOnce
{
    dispatch_async(dispatch_get_main_queue(),^{

        [asReaderApi_ startReadBarcodes:0 mtime:0 repeatCycle:0];
    });
}

- (void)stopReadBarcode
{
    dispatch_async(dispatch_get_main_queue(),^{
        [asReaderApi_ stopReadBarcodes];
    });
}

//---------------------------------------------------------------------------------------------------------
#pragma mark - AsReaderSDK Delegate
//---------------------------------------------------------------------------------------------------------
- (void)startedReadTags:(uint8_t)status
{
    
}

/**
 * AsReaderが読み取ったバーコード値を受け取る
 */
-(void)barcodeReceived:(NSData *)barcode
{
    NSString *scanStr = @"";
    scanStr = [[NSString alloc]initWithData:barcode encoding:barcodeEncoding];
    
    dispatch_async(dispatch_get_main_queue(),
    ^{
        if([self.delegate respondsToSelector:@selector(ASRManagerOnBarcodeScanned:value:)])
        {
            [self.delegate ASRManagerOnBarcodeScanned:self value:scanStr];
        }
    });
}

/**
 * バッテリーの残量を返す（5秒に1回のペースで受け取る）
 */
-(void)adcReceived:(NSData *)data
{
    NSLog(@"adcReceived [%@]\n",data);
    Byte *b = (Byte*) [data bytes];
    
    int adc = b[0];
    int adcMin = b[1];
    int adcMax = b[2];
    int battery = (adc-adcMin) * 100 / (adcMax - adcMin);
    if(battery > 100) battery = 100;
    
    dispatch_async(dispatch_get_main_queue(),
    ^{
        if([self.delegate respondsToSelector:@selector(ASRManagerBattery:battery:)])
        {
            [self.delegate ASRManagerBattery:self battery:battery];
        }
    });
}

/**
 * ビープ音の設定状況を受け取る
 */
- (void)readerInfoReceived:(NSData *)data
{
    
}

/**
 * AsReaderとの接続状態に変更があった場合にはいってくる
 */

-(void)pluggedBarcode:(BOOL)plug
{
    if(plug){
        // AsReaderと接続があればOpenする
        [self open];
    }else{
        // AsReaderと接続が切れればCloseする
        [self close];
    }
    
    //音なし、バイブレーションなし、イルミネーションなし
    [asReaderApi_ setBeep:(uint8_t)false setVibration:(uint8_t)false setIllumination:(uint8_t)false];
    
    dispatch_async(dispatch_get_main_queue(),
    ^{
        if([self.delegate respondsToSelector:@selector(ASRManagerPlugged:isPlugged:)])
        {
            [self.delegate ASRManagerPlugged:self isPlugged:plug];
        }
    });
}

@end


