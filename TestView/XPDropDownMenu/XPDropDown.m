//
//  XPDropDown.m
//  TestView
//
//  Created by 清欢有味 on 15/11/28.
//  Copyright © 2015年 清欢有味. All rights reserved.
//

#import "XPDropDown.h"

@interface XPDropDown()
@property(nonatomic, strong) UITableView *table;
@property(nonatomic, strong) UIButton *btnSender;
@property (nonatomic, strong)UIImageView *arrowImageView;
@property(nonatomic, strong) NSArray *list;
@property (nonatomic, assign) BOOL isShowTable;
@property (nonatomic, assign) CGFloat tableHeight;

@end

@implementation XPDropDown

-(void)setBtnBackgroundColor:(UIColor *)btnBackgroundColor
{
    if (_btnBackgroundColor != btnBackgroundColor) {
        _btnBackgroundColor = btnBackgroundColor;
        self.btnSender.backgroundColor = btnBackgroundColor;
    }
}
-(void)setCornerRadius:(CGFloat)cornerRadius
{
    if (_cornerRadius != cornerRadius) {
        _cornerRadius = cornerRadius;
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = self.cornerRadius;
    }
}
-(void)setTitleColor:(UIColor *)titleColor
{
    if (_titleColor != titleColor) {
        _titleColor = titleColor;
        [self.btnSender setTitleColor:titleColor forState:UIControlStateNormal];
    }
}

-(id)initWithFrame:(CGRect)frame tableHeight:(CGFloat)height dataArr:(NSArray *)arr
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.isShowTable = NO;
        self.list = [NSArray arrayWithArray:arr];
        self.tableHeight = height;

        self.btnSender = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.btnSender.backgroundColor = [UIColor yellowColor];
        [self.btnSender setTitle:@"全部" forState:UIControlStateNormal];
        [self.btnSender setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                                      
        [self.btnSender addTarget:self action:@selector(myButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.btnSender];
        
        
        self.arrowImageView = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width - 32 - 10, (frame.size.height - 32) * 0.5, 32, 32)];
        self.arrowImageView.image = [UIImage imageNamed:@"dropdown"];
        [self addSubview:self.arrowImageView];
        
        self.table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0)];
        self.table.delegate = self;
        self.table.dataSource = self;
        self.table.bounces = NO;
        self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.table.frame = CGRectMake(0, self.btnSender.frame.size.height, self.frame.size.width, 0);
        [self addSubview:self.table];
        self.table.hidden = YES;

    }
    return self;
}
-(void)myButtonClick
{
    self.isShowTable = !self.isShowTable;
    if (self.isShowTable) {
        //加遮罩
        UIView *coverView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        coverView.backgroundColor = [UIColor clearColor];
        coverView.tag = 109553462;
        UITapGestureRecognizer* singleRecognizer= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverViewSingleTap)];
        [coverView addGestureRecognizer:singleRecognizer];
        UIView *supView = self.superview;
        [supView insertSubview:coverView belowSubview:self];
        
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.btnSender.frame.size.height + self.tableHeight);
        self.table.hidden = NO;
        
        [UIView animateWithDuration:0.5 animations:^{
            self.table.frame = CGRectMake(0, self.btnSender.frame.size.height, self.frame.size.width, self.tableHeight);
            
            [self.arrowImageView setImage:[UIImage imageNamed:@"dropup"]];
            
        } completion:^(BOOL finished) {
            ;
        }];
        
    }else{
        //移除遮罩
        UIView *supView = self.superview;
        UIView *coverView = [supView viewWithTag:109553462];
        [coverView removeFromSuperview];
        coverView = nil;
        
        [UIView animateWithDuration:0.5 animations:^{
            self.table.frame = CGRectMake(0, self.btnSender.frame.size.height, self.frame.size.width, 0);
            
            [self.arrowImageView setImage:[UIImage imageNamed:@"dropdown"]];

            
        } completion:^(BOOL finished) {
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.btnSender.frame.size.height);
            self.table.hidden = YES;
        }];

    }

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40 ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.list count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        
        cell.backgroundColor = [UIColor redColor];
        cell.textLabel.textColor = [UIColor blackColor];
        cell.textLabel.highlightedTextColor = [UIColor whiteColor];

    }
    cell.textLabel.text =[self.list objectAtIndex:indexPath.row];
    
    UIView * v = [[UIView alloc] init];
    v.backgroundColor = [UIColor blackColor];
    cell.selectedBackgroundView = v;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *c = [tableView cellForRowAtIndexPath:indexPath];
    [self.btnSender setTitle:c.textLabel.text forState:UIControlStateNormal];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(xpDropDownDelegateMethod:)]){
        [self.delegate xpDropDownDelegateMethod:indexPath];
    }
    [self myButtonClick];

}
- (void)coverViewSingleTap
{
    [self hideTable];
}
-(void)hideTable{
    if (self.isShowTable) {
        [self myButtonClick];
    }
}

@end
