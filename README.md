## Screen Shot

<img src="https://dl.dropbox.com/u/83663874/GitHubs/KRToolbar-1.png" alt="KRToolbar" title="KRToolbar" style="margin: 20px;" class="center" />
。
<img src="https://dl.dropbox.com/u/83663874/GitHubs/KRToolbar-2.png" alt="KRToolbar" title="KRToolbar" style="margin: 20px;" class="center" />

## Supports

KRToolbar supports MRC ( Manual Reference Counting ), if you did want it support to ARC, that just use Xode tool to auto convert to ARC. ( Xcode > Edit > Refactor > Convert to Objective-C ARC )

## How To Get Started

KRToolbar which will control the UIToolbar to watch and fit Keyboard events of appear or disappear, that UIToolbar will match slide up to upper or slide down to hide with the keyboard changed its status at the same time.

``` objective-c
- (void)viewDidLoad
{
    _krToolbar = [[KRToolbar alloc] init];
    self._krToolbar.delegate = self;
    self._krToolbar.linkMove = YES;
    [self._krToolbar watchKeyboard];
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
    [self._krToolbar setToolbar:_toolbar mappingView:self.view];
    [self._krToolbar hide];
    [super viewWillAppear:animated];
}

#pragma UITextFieldDelegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if( textField == _textField1 ){
        [self._krToolbar show];
    }else{
        [self._krToolbar hide];
    }
    textField.returnKeyType      = UIReturnKeyDone;
    textField.keyboardAppearance = UIKeyboardAppearanceAlert;
    return YES;
}

#pragma KRToolbarDelegate
//It Keep Changing Slide up.
-(void)krToolbar:(KRToolbar *)_aKRToolbar trackChangingSlideUpToPoints:(CGPoint)_toPoints{
	
}

//It Keep Changing Slide down.
-(void)krToolbar:(KRToolbar *)_aKRToolbar trackChangingSlideDownToPoints:(CGPoint)_toPoints{
	
}

//It did Finish and Hide the Toolbar.
-(void)krToolbar:(KRToolbar *)_aKRToolbar didFinishedAndHideToolbarToPoints:(CGPoint)_toPoints{
    
}
```

## Version

KRToolbar now is V0.2 beta.

## License

KRToolbar is available under the MIT license ( or Whatever you wanna do ). See the LICENSE file for more info.
