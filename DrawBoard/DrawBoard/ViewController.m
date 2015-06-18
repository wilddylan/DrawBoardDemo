//
//  ViewController.m
//  DrawBoard
//
//  Created by XueYulun on 15/6/18.
//  Copyright (c) 2015年 __Dylan. All rights reserved.
//

#import "ViewController.h"
#import "DLPaintView.h"
#import "DLDarwShape.h"

@interface ViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet DLPaintView *DLPaintView;
@property (weak, nonatomic) IBOutlet UITextField *LineWidth;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

// - Action - //

- (IBAction)DrawRectShape:(UIButton *)sender {
    
    _DLPaintView.dType = DLPAINT_RECT;
}

- (IBAction)DrawOvalShape:(UIButton *)sender {

    _DLPaintView.dType = DLPAINT_OVAL;
}

- (IBAction)DrawLineShape:(UIButton *)sender {
    
    _DLPaintView.dType = DLPAINT_LINE;
}

- (IBAction)UndoAction:(UIButton *)sender {
    
    [_DLPaintView backout];
}

- (IBAction)RemoveAll:(UIButton *)sender {
    
    [_DLPaintView cleanBoard];
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    _DLPaintView.lineWidth = [string integerValue];
    
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
