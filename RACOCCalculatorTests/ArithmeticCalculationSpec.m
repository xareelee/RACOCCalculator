//
//  ArithmeticCalculationSpec.m
//  RACOCCalculator
//
//  Created by Xaree on 6/1/16.
//  Copyright © 2016 Xaree Lee. All rights reserved.
//

#import <Specta/Specta.h>
#import <Expecta/Expecta.h>
#import <KIF/KIF.h>

#import "Calculation.h"
#import "CalculationTestHelper.h"


SpecBegin(ArithmeticCalculation)

describe(@"Arithmetic operation", ^{
  
  NSString *error = (NSString *)CalculatorError;
  
  context(@"with input `1+==`", ^{
    
    itShouldBehaveLike(CalculationTestHelper, ^{
      NSArray *calculatorStates =
      @[calculatorState(nil, nil, @"1", nil, nil),      // 1
        calculatorState(@"1", @"+", nil, nil, @"1"),    // +
        calculatorState(@"2", nil, nil, @"+", @"1"),    // =
        calculatorState(@"3", nil, nil, @"+", @"1")     // =
        ];
      return @{@"sequence": @"1+==",
               @"expectedStates": calculatorStates};
    });
    
  });
  
  context(@"with input `3+4+5=`", ^{
    
    itShouldBehaveLike(CalculationTestHelper, ^{
      NSArray *calculatorStates =
      @[calculatorState(nil, nil, @"3", nil, nil),      // 3
        calculatorState(@"3", @"+", nil, nil, @"3"),    // +
        calculatorState(@"3", @"+", @"4", nil, @"3"),   // 4
        calculatorState(@"7", @"+", nil, @"+", @"7"),   // +
        calculatorState(@"7", @"+", @"5", @"+", @"7"),  // 5
        calculatorState(@"12", nil, nil, @"+", @"5"),   // =
        ];
      return @{@"sequence": @"3+4+5=",
               @"expectedStates": calculatorStates};
    });

  });
  
  
  context(@"with input `2/0=1===`", ^{
    
    itShouldBehaveLike(CalculationTestHelper, ^{
      NSArray *calculatorStates =
      @[calculatorState(nil, nil, @"2", nil, nil),      // 2
        calculatorState(@"2", @"/", nil, nil, @"2"),    // /
        calculatorState(@"2", @"/", @"0", nil, @"2"),   // 0
        calculatorState(error, nil, nil, @"/", @"0"),   // =
        calculatorState(error, nil, @"1", @"/", @"0"),  // 1
        calculatorState(error, nil, nil, @"/", @"1"),   // =
        calculatorState(error, nil, nil, @"/", @"1"),   // =
        calculatorState(error, nil, nil, @"/", @"1"),   // =
        ];
      return @{@"sequence": @"2/0=1===",
               @"expectedStates": calculatorStates};
    });
    
  });

  context(@"with input `2/0=1+2==`", ^{
    
    itShouldBehaveLike(CalculationTestHelper, ^{
      NSArray *calculatorStates =
      @[calculatorState(nil, nil, @"2", nil, nil),      // 2
        calculatorState(@"2", @"/", nil, nil, @"2"),    // /
        calculatorState(@"2", @"/", @"0", nil, @"2"),   // 0
        calculatorState(error, nil, nil, @"/", @"0"),   // =
        calculatorState(error, nil, @"1", @"/", @"0"),  // 1
        calculatorState(@"1", @"+", nil, nil, @"1"),    // +
        calculatorState(@"1", @"+", @"2", nil, @"1"),   // 2
        calculatorState(@"3", nil, nil, @"+", @"2"),    // =
        calculatorState(@"5", nil, nil, @"+", @"2"),    // =
        ];
      return @{@"sequence": @"2/0=1+2==",
               @"expectedStates": calculatorStates};
    });
    
  });

  context(@"with input `2+3===`", ^{
    
    itShouldBehaveLike(CalculationTestHelper, ^{
      NSArray *calculatorStates =
      @[calculatorState(nil, nil, @"2", nil, nil),        // 2
        calculatorState(@"2", @"+", nil, nil, @"2"),      // +
        calculatorState(@"2", @"+", @"3", nil, @"2"),     // 3
        calculatorState(@"5", nil, nil, @"+", @"3"),      // =
        calculatorState(@"8", nil, nil, @"+", @"3"),      // =
        calculatorState(@"11", nil, nil, @"+", @"3"),     // =
        ];
      return @{@"sequence": @"2+3===",
               @"expectedStates": calculatorStates};
    });
    
  });

  context(@"with input `2+3+===`", ^{
    
    itShouldBehaveLike(CalculationTestHelper, ^{
      NSArray *calculatorStates =
      @[calculatorState(nil, nil, @"2", nil, nil),        // 2
        calculatorState(@"2", @"+", nil, nil, @"2"),      // +
        calculatorState(@"2", @"+", @"3", nil, @"2"),     // 3
        calculatorState(@"5", @"+", nil, @"+", @"5"),     // +
        calculatorState(@"10", nil, nil, @"+", @"5"),     // =
        calculatorState(@"15", nil, nil, @"+", @"5"),     // =
        calculatorState(@"20", nil, nil, @"+", @"5"),     // =
        ];
      return @{@"sequence": @"2+3+===",
               @"expectedStates": calculatorStates};
    });
    
  });

});

SpecEnd