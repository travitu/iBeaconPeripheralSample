//
//  ViewController.m
//  iBeaconPeripheralSample
//
//  Created by Toshikazu Fukuoka on 2014/12/23.
//  Copyright (c) 2014年 Toshikazu Fukuoka. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <CoreBluetooth/CoreBluetooth.h>

// proximityUUIDとして利用するUUID（Macターミナル：$ uuidgen）
#define UUID_FOR_PROXIMITY @"23959981-C41C-4D6F-BC40-3656D56A4D6B"

// アプリ内でRegionを特定するために利用するID
#define REGION_ID @"com.travitu.ibeacontest"

@interface ViewController () <CBPeripheralManagerDelegate>
@property (nonatomic, strong) CLLocationManager   *locationManager;
@property (nonatomic, strong) NSUUID              *proximityUUID;
@property (nonatomic, strong) CLBeaconRegion      *beaconRegion;
@property (nonatomic, strong) CBPeripheralManager *peripheralManager;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 生成したUUIDからNSUUIDを作成する
    self.proximityUUID = [[NSUUID alloc] initWithUUIDString:UUID_FOR_PROXIMITY];
    
    // CBPeripheralManagerを作成する
    self.peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self queue:dispatch_get_main_queue() options:nil];
    
    // アドバタイズ開始処理
//    [self startAdvertising];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startAdvertising
{
    NSLog(@"startAdvertising");
    // CLBeaconRegionを作成してアドバタイズするデータを取得する
    self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:self.proximityUUID major:1 minor:2 identifier:REGION_ID];
    NSDictionary *beaconPeripheralData = [self.beaconRegion peripheralDataWithMeasuredPower:nil];
    
    // アドバタイズを開始する
    [self.peripheralManager startAdvertising:beaconPeripheralData];
}

#pragma mark - CBPeripheralManagerDelegate
- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral
{
//    NSLog(@"%@", NSStringFromSelector(_cmd));
    switch (peripheral.state) {
        case CBPeripheralManagerStatePoweredOn:
            NSLog(@"%ld, CBPeripheralManagerStatePoweredOn", peripheral.state);
            // ここでアドバタイズ開始処理をした方がよいか
            [self startAdvertising];
            break;
        case CBPeripheralManagerStatePoweredOff:
            NSLog(@"%ld, CBPeripheralManagerStatePoweredOff", peripheral.state);
            break;
        case CBPeripheralManagerStateResetting:
            NSLog(@"%ld, CBPeripheralManagerStateResetting", peripheral.state);
            break;
        case CBPeripheralManagerStateUnauthorized:
            NSLog(@"%ld, CBPeripheralManagerStateUnauthorized", peripheral.state);
            break;
        case CBPeripheralManagerStateUnsupported:
            NSLog(@"%ld, CBPeripheralManagerStateUnsupported", peripheral.state);
            break;
        case CBPeripheralManagerStateUnknown:
            NSLog(@"%ld, CBPeripheralManagerStateUnknown", peripheral.state);
            break;
        default:
            break;
    }
}

@end
