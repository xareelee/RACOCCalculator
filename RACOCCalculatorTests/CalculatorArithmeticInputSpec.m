//
//  CalculatorArithmeticSpec.m
//  RACOCCalculator
//
//  Created by Xaree on 6/1/16.
//  Copyright © 2016 Xaree Lee. All rights reserved.
//

#import <Specta/Specta.h>
#import <Expecta/Expecta.h>
#import <KIF/KIF.h>

#import "CalculatorState.h"
#import "TestRootViewSetup.h"
#import "Calculation.h"
#import "TestHelper.h"


SpecBegin(CalculatorArithmeticInput)

describe(@"Arithmetic operation", ^{
  
  __block CalculatorViewController *calculatorVC;
  
  beforeAll(^{
    calculatorVC = [TestRootViewSetup setupForCalculator];
  });
  
  beforeEach(^{
    [calculatorVC resetCalculater];
  });
  
  context(@"when it already has input a value", ^{
    
    __block NSString *initValue;
    
    beforeEach(^{
      initValue = @"532";
      CalculatorState *state = stateForTuple(calculatorState(nil, nil, initValue, nil, nil));
      [calculatorVC resetCalculaterWithState:state];
      
      UILabel *displayLabel = (UILabel *)[tester waitForViewWithAccessibilityLabel:@"display"];
      expect(displayLabel.text).to.equal(initValue);
    });
    
    
    it(@"should still display the same value after type a plus sign", ^{
      [tester typeCalculatorWithExpectedStartValue:@"532" sequence:@"+" expectedResult:@"532"];
    });
    
    it(@"should still display the same value after type a minus sign", ^{
      [tester typeCalculatorWithExpectedStartValue:@"532" sequence:@"-" expectedResult:@"532"];
    });
    
    it(@"should still display the same value after type a multiplication sign", ^{
      [tester typeCalculatorWithExpectedStartValue:@"532" sequence:@"*" expectedResult:@"532"];
    });
    
    it(@"should still display the same value after type a division sign", ^{
      [tester typeCalculatorWithExpectedStartValue:@"532" sequence:@"/" expectedResult:@"532"];
    });
    
    it(@"should still display the same value after type a equals sign", ^{
      [tester typeCalculatorWithExpectedStartValue:@"532" sequence:@"=" expectedResult:@"532"];
    });
    
  });
  
  
  context(@"when it already has input a value and a plus sign", ^{
    
    __block NSString *initValue;
    
    beforeEach(^{
      initValue = @"240";
      [calculatorVC resetCalculaterWithState:calculatorState(nil, nil, initValue, nil, nil)];
      
      [tester tapViewWithAccessibilityLabel:@"+"];
      
      UILabel *displayLabel = (UILabel *)[tester waitForViewWithAccessibilityLabel:@"display"];
      expect(displayLabel.text).to.equal(initValue);
    });
    
    
    
    
  });
  
});

SpecEnd