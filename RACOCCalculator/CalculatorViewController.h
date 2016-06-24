//
//  ViewController.h
//  RACOCCalculator
//
//  Created by Xaree on 5/30/16.
//  Copyright © 2016 Xaree Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
@class CalculatorState;


@interface CalculatorViewController : UIViewController

@property (strong, nonatomic, readonly) CalculatorState *calculatorState;

- (void)resetCalculater;
- (void)resetCalculaterWithState:(CalculatorState *)state;

@end

