//
//  KRToolbar.m
//
//  ilovekalvar@gmail.com
//
//  Created by Kuo-Ming Lin on 12/10/29.
//  Copyright (c) 2012年 Kuo-Ming Lin. All rights reserved.
//

#import "KRToolbar.h"

@interface KRToolbar ()

@property (nonatomic, assign) BOOL _slideUpToolbar;

@end

@interface KRToolbar (fixPrivate)

-(void)_initWithVars;
-(void)_moveToSitesWithView:(UIView *)_targetView toX:(float)_toX toY:(float)_toY;
-(void)_slideUpWithFrame:(CGRect)_keyboardFrame;
-(void)_slideDown;
-(void)_keyboardWillShowOnDelay:(NSNotification *)notification;
-(void)_keyboardWillShow:(NSNotification *)notification;
-(void)_keyboardWillHide:(NSNotification *)notification;
-(void)_removeNotification;

@end

@implementation KRToolbar (fixPrivate)

-(void)_initWithVars{
    self._slideUpToolbar = NO;
    self.toolbar         = nil;
    self.view            = nil;
}

-(void)_moveToSitesWithView:(UIView *)_targetView
                        toX:(float)_toX
                        toY:(float)_toY
{    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationBeginsFromCurrentState:YES];
    _targetView.frame = CGRectMake(_toX,
                                   _toY,
                                   _targetView.frame.size.width,
                                   _targetView.frame.size.height);
    [UIView commitAnimations];
}

-(void)_slideUpWithFrame:(CGRect)_keyboardFrame
{
    self.toolbar.hidden = NO;
    CGFloat _keyboardHeight = _keyboardFrame.size.height;
    CGFloat _toolbarHeight  = 44.0f;
    CGFloat _toolbarX       = self.toolbar.frame.origin.x;
    CGFloat _superviewY     = self.view.frame.origin.y;
    CGFloat _toolbarYOfNew  = self.view.frame.size.height - _keyboardHeight - _toolbarHeight;
    if( _superviewY < 0 ){
        _toolbarYOfNew -= _superviewY;
    }
    [self _moveToSitesWithView:self.toolbar toX:_toolbarX toY:_toolbarYOfNew];
}

-(void)_slideDown{
    if( self.toolbar.frame.origin.y <= 300.0f ){
        [self _moveToSitesWithView:self.toolbar toX:0.0f toY:[[UIScreen mainScreen] bounds].size.height];
    }
    self.toolbar.hidden = YES;
}

-(void)_keyboardWillShowOnDelay:(NSNotification *)notification
{
    [self performSelector:@selector(_keyboardWillShow:) withObject:notification afterDelay:0];
}

-(void)_keyboardWillShow:(NSNotification *)notification{
    UIView *foundKeyboard = nil;
    UIWindow *keyboardWindow = nil;
    for (UIWindow *testWindow in [[UIApplication sharedApplication] windows]){
        if (![[testWindow class] isEqual:[UIWindow class]]){
            keyboardWindow = testWindow;
            break;
        }
    }
    if (!keyboardWindow) return;
    for (UIView *possibleKeyboard in [keyboardWindow subviews])
    {
        //iOS3
        if ([[possibleKeyboard description] hasPrefix:@"<UIKeyboard"]){
            foundKeyboard = possibleKeyboard;
            break;
        }else{
            //iOS 4+
            if ([[possibleKeyboard description] hasPrefix:@"<UIPeripheralHostView"]){
                for( UIView *_findOutKeyboardView in possibleKeyboard.subviews ){
                    if( [[_findOutKeyboardView description] hasPrefix:@"<UIKeyboard"] ){
                        possibleKeyboard = _findOutKeyboardView;
                    }
                }
            }
            if ([[possibleKeyboard description] hasPrefix:@"<UIKeyboard"]){
                foundKeyboard = possibleKeyboard;
                break;
            }
        }
    }
    
    if (foundKeyboard){
        if( self._slideUpToolbar ){
            [self _slideUpWithFrame:foundKeyboard.frame];
        }else{
            [self _slideDown];
        }
    }
}

-(void)_keyboardWillHide:(NSNotification *)notification{
    [self _slideDown];
}

-(void)_removeNotification{
    /*
     * 栘除監聽事件 No longer listen for keyboard 
     */
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

@end

@implementation KRToolbar

@synthesize toolbar;
@synthesize view;

@synthesize _slideUpToolbar;

-(id)init{
    self = [super init];
    if( self ){
        [self _initWithVars];
    }
    return self;
}

-(id)initWithToolbar:(UIToolbar *)_aToolbar mappingView:(UIView *)_aView{
    self = [super init];
    if( self ){
        [self _initWithVars];
        self.toolbar = _aToolbar;
        self.view    = _aView;
    }
    return self;
}

-(void)dealloc{
    [self _removeNotification];
    [toolbar release], self.toolbar = nil;;
    [view release]; //, self.view = nil;
    [super dealloc];
}

#pragma Methods
-(void)watchKeyboard{
    self._slideUpToolbar = YES;
    //監聽 Keyboard 出現事件
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(_keyboardWillShowOnDelay:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    //監聽 Keyboard 消失事件
	[[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(_keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

-(void)leaveKeyboard{
    [self _removeNotification];
    [self hide];
}

-(void)hide{
    self._slideUpToolbar = NO;
    [self.toolbar setHidden:YES];
    [self _slideDown];
}

-(void)show{
    self._slideUpToolbar = YES;
    [self.toolbar setHidden:NO];
    [self _keyboardWillShowOnDelay:nil];
}

@end
