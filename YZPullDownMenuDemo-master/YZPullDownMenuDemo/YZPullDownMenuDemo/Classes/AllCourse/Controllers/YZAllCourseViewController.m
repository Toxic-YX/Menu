//
//  YZAllCourseViewController.m
//  PullDownMenu
//
//  Created by yz on 16/8/12.
//  Copyright © 2016年 yz. All rights reserved.
//

#import "YZAllCourseViewController.h"
#import "YZSortCell.h"

extern NSString * const YZUpdateMenuTitleNote;
static NSString * const ID = @"cell";

@interface YZAllCourseViewController ()
@property (nonatomic, copy) NSArray *titleArray;
@property (nonatomic, assign) NSInteger selectedCol;

@end

@implementation YZAllCourseViewController

-(void)viewDidLoad {
   [super viewDidLoad];
   // Do any additional setup after loading the view from its nib.
   
   _selectedCol = 0;
   
   _titleArray = @[@"小学生",@"中学生",@"大学生",@"研究生"];
   
   [self.tableView registerClass:[YZSortCell class] forCellReuseIdentifier:ID];
   
   self.tableView.backgroundColor = [UIColor cyanColor];
}

- (void)viewWillAppear:(BOOL)animated
{
   [super viewWillAppear:animated];
   NSIndexPath *indexPath = [NSIndexPath indexPathForItem:_selectedCol inSection:0];
   [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   YZSortCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
   cell.textLabel.text = _titleArray[indexPath.row];
   if (indexPath.row == 0) {
      [cell setSelected:YES animated:NO];
   }
   
   return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   _selectedCol = indexPath.row;
   
   // 选中当前
   YZSortCell *cell = [tableView cellForRowAtIndexPath:indexPath];
   
   // 更新菜单标题
   [[NSNotificationCenter defaultCenter] postNotificationName:YZUpdateMenuTitleNote object:self userInfo:@{@"title":cell.textLabel.text}];

}

@end
