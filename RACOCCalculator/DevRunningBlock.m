//
//  DevRunningBlock.m
//  RACOCCalculator
//
//  Created by Xaree on 5/30/16.
//  Copyright © 2016 Xaree Lee. All rights reserved.
//

#import "DevRunningBlock.h"

__attribute__(())


@interface DevRunningBlock()
@property (nonatomic) BOOL isTest;
+ (instancetype)sharedInstance;
@end

@implementation DevRunningBlock

+ (instancetype)sharedInstance {
  static DevRunningBlock *sharedInstance;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedInstance = [DevRunningBlock new];
  });
  return sharedInstance;
}

+ (BOOL)isTest {
  return [DevRunningBlock sharedInstance].isTest;
}

+ (void)setIsTest:(BOOL)isTest {
  [DevRunningBlock sharedInstance].isTest = isTest;
}

@end


void _debug_only(void(^block)(void)) {
  if (![DevRunningBlock isTest]) {
    block();
  }
}

void _debug_and_test_only(void(^block)(void)) {
  block();
}
