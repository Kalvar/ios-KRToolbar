//
//  ViewController.m
//  KRToolbar
//
//  Created by Kalvar on 12/10/30.
//  Copyright (c) 2012年 Kuo-Ming Lin. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@property (nonatomic, retain) KRToolbar *_krToolbar;

@end

@interface ViewController (fixPrivate)

-(void)_backToInit;

@end

@implementation ViewController (fixPrivate)

-(void)_backToInit{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationBeginsFromCurrentState:YES];
    self.view.frame = CGRectMake(0.0f, 20.0f, self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
}

@end

@implementation ViewController

@synthesize _krToolbar;

- (void)viewDidLoad
{
    _krToolbar = [[KRToolbar alloc] init];
    self._krToolbar.delegate = self;
    self._krToolbar.linkMove = NO;
    [self._krToolbar watchKeyboard];
    
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
    //在這裡才能正確的抓到目標 View 座標
    [self._krToolbar setToolbar:_toolbar mappingView:self.view];
    [self._krToolbar hide];
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    [_krToolbar release];
    [super dealloc];
}

#pragma IBActions
-(IBAction)done:(id)sender{
    [self _backToInit];
    [_textField1 resignFirstResponder];
    [_textField2 resignFirstResponder];
}

#pragma UITextFieldDelegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    //設定 Toolbar 要隨著哪一個欄位的 Keyboard 昇降
    if( textField == _textField1 ){
        [self._krToolbar show];
    }else{
        [self._krToolbar hide];
    }
    textField.returnKeyType      = UIReturnKeyDone;
    textField.keyboardAppearance = UIKeyboardAppearanceAlert;
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self _backToInit];
    [textField resignFirstResponder];
	return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    return YES;
}

#pragma KRToolbarDelegate
-(void)krToolbar:(KRToolbar *)_aKRToolbar didFinishedAndHideToolbarToPoints:(CGPoint)_toPoints{
}

-(void)krToolbar:(KRToolbar *)_aKRToolbar trackChangingSlideDownToPoints:(CGPoint)_toPoints{
    
}

-(void)krToolbar:(KRToolbar *)_aKRToolbar trackChangingSlideUpToPoints:(CGPoint)_toPoints{
    
}


@end
