//
//  ViewController.h
//  KRToolbar
//
//  Created by Kalvar on 12/10/30.
//  Copyright (c) 2012年 Kuo-Ming Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KRToolbar.h"

@interface ViewController : UIViewController<UITextFieldDelegate, KRToolbarDelegate>{

@private
    IBOutlet UIToolbar *_toolbar;
    IBOutlet UITextField *_textField1;
    IBOutlet UITextField *_textField2;
    
}

-(IBAction)done:(id)sender;

@end
