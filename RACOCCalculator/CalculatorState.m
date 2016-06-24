//
//  CalculatorState.m
//  RACOCCalculator
//
//  Created by Xaree on 6/24/16.
//  Copyright © 2016 Xaree Lee. All rights reserved.
//

#import "CalculatorState.h"

@implementation CalculatorState

- (instancetype)initWithAnswer:(NSString *)ans currentOperator:(NSString *)c_op currentInput:(NSString *)c_ip latestOperator:(NSString *)l_op accumulatedValue:(NSString *)acc {
  self = [self init];
  if (self) {
    _ans = ans;
    _c_op = c_op;
    _c_ip = c_ip;
    _l_op = l_op;
    _acc = acc;
  }
  return self;
}

+ (instancetype)stateWithAnswer:(NSString *)ans currentOperator:(NSString *)c_op currentInput:(NSString *)c_ip latestOperator:(NSString *)l_op accumulatedValue:(NSString *)acc {
  return  [[CalculatorState alloc] initWithAnswer:ans currentOperator:c_op currentInput:c_ip latestOperator:l_op accumulatedValue:acc];
}

+ (instancetype)initialState{
  return [CalculatorState new];
}

- (NSString *)debugDescription {
  return [NSString stringWithFormat:@"(%@, %@, %@, %@, %@)",
          self.ans ?: @"nil",
          self.c_op ?: @"nil",
          self.c_ip ?: @"nil",
          self.l_op ?: @"nil",
          self.acc ?: @"nil"];
}

@end
