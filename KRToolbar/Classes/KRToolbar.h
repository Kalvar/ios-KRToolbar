//
//  KRToolbar.h
//
//  ilovekalvar@gmail.com
//
//  Created by Kuo-Ming Lin on 12/10/29.
//  Copyright (c) 2012年 Kuo-Ming Lin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KRToolbar : NSObject{
    UIToolbar *toolbar;
    UIView *view;
}

@property (nonatomic, retain) UIToolbar *toolbar;
@property (nonatomic, retain) UIView *view;

-(id)initWithToolbar:(UIToolbar *)_aToolbar mappingView:(UIView *)_aView;
-(void)watchKeyboard;
-(void)leaveKeyboard;
-(void)hide;
-(void)show;

@end
