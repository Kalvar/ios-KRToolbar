//
//  ViewController.m
//  KRToolbar
//
//  Created by Kalvar on 12/10/30.
//  Copyright (c) 2012年 Kuo-Ming Lin. All rights reserved.
//

#import "ViewController.h"
#import "KRToolbar.h"

@interface ViewController ()

@property (nonatomic, retain) KRToolbar *_krToolbar;

@end

@implementation ViewController

@synthesize _krToolbar;

- (void)viewDidLoad
{
    _krToolbar = [[KRToolbar alloc] initWithToolbar:_toolbar mappingView:self.view];
    [self._krToolbar watchKeyboard];
    [self._krToolbar hide];
    
    [super viewDidLoad];
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
    [textField resignFirstResponder];
	return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    return YES;
}


@end
