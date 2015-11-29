//
//  XPDropDown.h
//  TestView
//
//  Created by 清欢有味 on 15/11/28.
//  Copyright © 2015年 清欢有味. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XPDropDown;
@protocol XPDropDownDelegate <NSObject>
- (void) xpDropDownDelegateMethod:(NSIndexPath *)indexPath;
@end

@interface XPDropDown : UIView <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, assign) id <XPDropDownDelegate> delegate;
@property (nonatomic, assign) CGFloat cornerRadius;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIColor *btnBackgroundColor;


-(void)hideTable;
-(id)initWithFrame:(CGRect)frame tableHeight:(CGFloat)height dataArr:(NSArray *)arr;
@end
