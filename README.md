## Screen Shot

<img src="https://dl.dropbox.com/u/83663874/GitHubs/KRToolbar-1.png" alt="KRToolbar" title="KRToolbar" style="margin: 20px;" class="center" />
。
<img src="https://dl.dropbox.com/u/83663874/GitHubs/KRToolbar-2.png" alt="KRToolbar" title="KRToolbar" style="margin: 20px;" class="center" />

## Supports

KRToolbar supports MRC ( Manual Reference Counting ), if you did want it support to ARC, that just use Xode tool to auto convert to ARC. ( Xcode > Edit > Refactor > Convert to Objective-C ARC )

## How To Get Started

KRToolbar which will control the UIToolbar to watch and fit Keyboard events of appear or disappear, that UIToolbar will match slide up to upper or slide down to hide with the keyboard changed its status at the same time.

``` objective-c
@interface ViewController(){
@private
    IBOutlet UIToolbar *_toolbar;
    IBOutlet UITextField *_textField1;
    IBOutlet UITextField *_textField2;
}
@property (nonatomic, retain) KRToolbar *_krToolbar;
@end

- (void)viewDidLoad
{
    _krToolbar = [[KRToolbar alloc] initWithToolbar:_toolbar mappingView:self.view];
    [self._krToolbar watchKeyboard];
    [self._krToolbar hide];
    [super viewDidLoad];
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
```

## Version

KRToolbar now is V0.1 beta.

## License

KRToolbar is available under the MIT license ( or Whatever you wanna do ). See the LICENSE file for more info.
