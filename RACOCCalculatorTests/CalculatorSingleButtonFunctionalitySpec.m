//
//  CalculatorSingleButtonFunctionalitySpec.m
//  RACOCCalculator
//
//  Created by Xaree on 5/30/16.
//  Copyright © 2016 Xaree Lee. All rights reserved.
//

//CalculatorSingleButtonFunctionality

#import <Specta/Specta.h>
#import <Expecta/Expecta.h>
#import <KIF/KIF.h>

#import "TestRootViewSetup.h"
#import "TestHelper.h"


SpecBegin(CalculatorSingleButtonFunctionality)

describe(@"Calculator", ^{
  
  __block CalculatorViewController *calculatorVC;
  
  beforeAll(^{
    calculatorVC = [TestRootViewSetup setupForCalculator];
  });
  
  beforeEach(^{
    [calculatorVC resetCalculater];
  });
  
  context(@"with clear state", ^{
        
    it(@"should show 0 when tapping 0", ^{
      [tester typeCalculatorWithExpectedStartValue:@"0" sequence:@"0" expectedResult:@"0"];
    });
    
    it(@"should show 1 when tapping 1", ^{
      [tester typeCalculatorWithExpectedStartValue:@"0" sequence:@"1" expectedResult:@"1"];
    });
    
    it(@"should show 2 when tapping 2", ^{
      [tester typeCalculatorWithExpectedStartValue:@"0" sequence:@"2" expectedResult:@"2"];
    });
    
    it(@"should show 3 when tapping 3", ^{
      [tester typeCalculatorWithExpectedStartValue:@"0" sequence:@"3" expectedResult:@"3"];
    });
    
    it(@"should show 4 when tapping 4", ^{
      [tester typeCalculatorWithExpectedStartValue:@"0" sequence:@"4" expectedResult:@"4"];
    });
    
    it(@"should show 5 when tapping 5", ^{
      [tester typeCalculatorWithExpectedStartValue:@"0" sequence:@"5" expectedResult:@"5"];
    });
    
    it(@"should show 6 when tapping 6", ^{
      [tester typeCalculatorWithExpectedStartValue:@"0" sequence:@"6" expectedResult:@"6"];
    });
    
    it(@"should show 7 when tapping 7", ^{
      [tester typeCalculatorWithExpectedStartValue:@"0" sequence:@"7" expectedResult:@"7"];
    });
    
    it(@"should show 8 when tapping 8", ^{
      [tester typeCalculatorWithExpectedStartValue:@"0" sequence:@"8" expectedResult:@"8"];
    });
    
    it(@"should show 9 when tapping 9", ^{
      [tester typeCalculatorWithExpectedStartValue:@"0" sequence:@"9" expectedResult:@"9"];
    });
    
    it(@"should show 0 when tapping decimal point", ^{
      [tester typeCalculatorWithExpectedStartValue:@"0" sequence:@"0." expectedResult:@"0."];
    });
  });

  
});

SpecEnd
