//
//  ViewController.m
//  RACOCCalculator
//
//  Created by Xaree on 5/30/16.
//  Copyright © 2016 Xaree Lee. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorState.h"
#import "Calculation.h"


@interface CalculatorViewController ()

@property (weak, nonatomic) IBOutlet UILabel *displayLabel;

@property (weak, nonatomic) IBOutlet UIButton *inputButton0;
@property (weak, nonatomic) IBOutlet UIButton *inputButton1;
@property (weak, nonatomic) IBOutlet UIButton *inputButton2;
@property (weak, nonatomic) IBOutlet UIButton *inputButton3;
@property (weak, nonatomic) IBOutlet UIButton *inputButton4;
@property (weak, nonatomic) IBOutlet UIButton *inputButton5;
@property (weak, nonatomic) IBOutlet UIButton *inputButton6;
@property (weak, nonatomic) IBOutlet UIButton *inputButton7;
@property (weak, nonatomic) IBOutlet UIButton *inputButton8;
@property (weak, nonatomic) IBOutlet UIButton *inputButton9;
@property (weak, nonatomic) IBOutlet UIButton *inputButtonDecimalPoint;

@property (weak, nonatomic) IBOutlet UIButton *actionButtonAdd;
@property (weak, nonatomic) IBOutlet UIButton *actionButtonSubstract;
@property (weak, nonatomic) IBOutlet UIButton *actionButtonMultiply;
@property (weak, nonatomic) IBOutlet UIButton *actionButtonDivide;
@property (weak, nonatomic) IBOutlet UIButton *actionButtonEqual;

@property (weak, nonatomic) IBOutlet UIButton *actionButtonClear;
@property (weak, nonatomic) IBOutlet UIButton *actionButtonPercentage;
@property (weak, nonatomic) IBOutlet UIButton *actionButtonTransitPosNeg;


// Internal
@property (strong, nonatomic) CalculatorState *calculatorState;
@end

@implementation CalculatorViewController

- (void)resetCalculater {
  [self resetCalculaterWithState:[CalculatorState initialState]];
}

- (void)resetCalculaterWithState:(CalculatorState *)state {
  self.calculatorState = state;
}


- (void)viewDidLoad {
  [super viewDidLoad];
  
  // Initialization
  {
    [self resetCalculater];
  }

  // Input command & signals for buttons
  RACSignal *inputSignal;
  {
    RACCommand *inputCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(UIButton *inputButton) {
      return [RACSignal return:inputButton.accessibilityLabel];
    }];
    
    self.inputButton0.rac_command = inputCommand;
    self.inputButton1.rac_command = inputCommand;
    self.inputButton2.rac_command = inputCommand;
    self.inputButton3.rac_command = inputCommand;
    self.inputButton4.rac_command = inputCommand;
    self.inputButton5.rac_command = inputCommand;
    self.inputButton6.rac_command = inputCommand;
    self.inputButton7.rac_command = inputCommand;
    self.inputButton8.rac_command = inputCommand;
    self.inputButton9.rac_command = inputCommand;
    self.inputButtonDecimalPoint.rac_command = inputCommand;
    
    self.actionButtonAdd.rac_command = inputCommand;
    self.actionButtonSubstract.rac_command = inputCommand;
    self.actionButtonMultiply.rac_command = inputCommand;
    self.actionButtonDivide.rac_command = inputCommand;
    self.actionButtonEqual.rac_command = inputCommand;
    
    self.actionButtonClear.rac_command = inputCommand;
    self.actionButtonPercentage.rac_command = inputCommand;
    self.actionButtonTransitPosNeg.rac_command = inputCommand;
    
    inputSignal = inputCommand.executionSignals.switchToLatest;
  }
  
  // Calculator state Signal
  RACSignal *calculatorStateSignal;
  {
    calculatorStateSignal = RACObserve(self, calculatorState);
  }
  
  // Update the display label with the current value
  {
    // Show current input; if nil, show current result; if nil, show `0`.
    RAC(self, displayLabel.text) = [calculatorStateSignal map:^id(CalculatorState *state) {
      return stringValueForDisplay(state);
    }];
  }
  
  // Calculate the next state
  {
    RACSignal *nextStateSignal;
    nextStateSignal =
    [[inputSignal
      zipWith:[calculatorStateSignal sample:inputSignal]]
      reduceEach:^id(NSString *input, CalculatorState *state){
        return combineInputIntoCalculatorState(input, state);
      }];
    
    RAC(self, calculatorState) = nextStateSignal;
  }
}

@end
