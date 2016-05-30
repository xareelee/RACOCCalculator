//
//  RACMergeChannel.m
//  RACOCCalculator
//
//  Created by Xaree on 5/30/16.
//  Copyright © 2016 Xaree Lee. All rights reserved.
//

#import "RACMergeChannel.h"


@interface RACMergeChannel()
@property (strong, nonatomic) NSArray *signalForMergedSignals;
@end


@implementation RACMergeChannel

- (instancetype)init {
  self = [super init];
  if (self) {
    @weakify(self);
    
    _signalForMergedSignals = @[];
    
    RACSignal *signalForMergedSignalsChangedSignal = [RACObserve(self, signalForMergedSignals) skip:1];
    
    
    RACSignal *mergedSignals =
    [signalForMergedSignalsChangedSignal
      flattenMap:^RACStream *(NSArray *mergedSignals) {
        return [RACSignal merge:mergedSignals];
      }];
    
    
    [mergedSignals subscribeNext:^(id x) {
      @strongify(self);
      debug_only(^{
        NSLog(@"update current value: %@", x);
      });
      [self.leadingTerminal sendNext:x];
    } error:^(NSError *error) {
      @strongify(self);
      [self.leadingTerminal sendError:error];
    } completed:^{
      @strongify(self);
      [self.leadingTerminal sendCompleted];
    }];
  }
  return self;
}

- (void)mergeSignal:(RACSignal *)signal {
  self.signalForMergedSignals = [self.signalForMergedSignals arrayByAddingObject:signal];
}


@end
