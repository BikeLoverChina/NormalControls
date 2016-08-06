//
//  DemoOfControlCategoryList.m
//  NormalControlUse
//
//  Created by Apple on 16/8/6.
//  Copyright © 2016年 ywj. All rights reserved.
//

#import "DemoOfControlCategoryList.h"
#import "UIButtonViewController.h"
#import "UILabelViewController.h"

const static  CGFloat RowHeight = 50.0;

@interface DemoOfControlCategoryList ()

@property (nonatomic, strong) NSMutableArray *controllArray;

@end

@implementation DemoOfControlCategoryList

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - tableview代理方法

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return RowHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.controllArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [self.controllArray objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *titleStr = [self.controllArray objectAtIndex:indexPath.row];
    
    if ([titleStr isEqualToString:@"UIButton"]) {
        UIButtonViewController *buttonVC = [[UIButtonViewController alloc] init];
        [self.navigationController pushViewController:buttonVC animated:YES];
    }
    else if ([titleStr isEqualToString:@"UILabel"])
    {
        UILabelViewController *lableVC = [[UILabelViewController alloc] init];
        [self.navigationController pushViewController:lableVC animated:YES];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark- 懒加载

- (NSMutableArray *)controllArray
{
    if (_controllArray == nil) {
        _controllArray = [[NSMutableArray alloc] initWithObjects:@"UIButton", @"UILabel", nil];
    }
    return _controllArray;
}

@end
