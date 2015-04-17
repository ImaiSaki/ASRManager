//
//  ASRManager.h
//  ASRManager
//
//  Created by Asterisk Inc. on 04/09/2015.
//  Copyright (c) 2015 Asterisk Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RcpBarcodeApi.h"

/**
 * AsReaderSDKの管理クラス
 * 補足 : 画面遷移する際に、delegateをviewWillAppearで設定し、
 * 　　   viewWillDisappearでdelegate=nilを行ってください。
 * 　　   複数にdelegateが設定されていると落ちます。
 */
@interface ASRManager : NSObject <RcpBarcodeDelegate>
{
    
}

//-------- property --------------------------------------------
@property(nonatomic, assign)id delegate;
@property(nonatomic, strong)NSMutableString *debugText;

//-------- GloabalMethod --------------------------------------------
/** インスタンス取得 */
+ (instancetype)sharedInstance;

//-------- PublicMethod --------------------------------------------
/** 接続を開く */
- (void)open;

/** 接続を閉じる */
- (void)close;

/** バーコードの変換エンコードをセット */
- (void)setBarcodeEncoding:(NSStringEncoding)encoding;

/** レーザー照射開始 */
- (void)startReadBarcodeOnce;

/** レーザー照射停止 */
- (void)stopReadBarcode;

@end

/**
 * プロトコル
 */
@protocol ASRManagerDelegate
@optional
/** スキャン時のデリゲートメソッド */
- (void)ASRManagerOnBarcodeScanned:(ASRManager *)manager value:(NSString *)value;

/** AsReaderとの接続状態に変更があった場合のデリゲートメソッド */
- (void)ASRManagerPlugged:(ASRManager *)manager isPlugged:(BOOL)isPlugged;

/** AsReaderのバッテリー状態を受け取るデリゲートメソッド （5秒に1回入る）*/
- (void)ASRManagerBattery:(ASRManager *)manager battery:(int)battery;
@end