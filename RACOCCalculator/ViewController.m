//
//  ViewController.m
//  RACOCCalculator
//
//  Created by Xaree on 5/30/16.
//  Copyright © 2016 Xaree Lee. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

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

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
