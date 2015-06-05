//
//  SearchResultViewController.m
//  SearchTableViewDemo
//
//  Created by huangwenchen on 15/3/26.
//  Copyright (c) 2015年 huangwenchen. All rights reserved.
//

#import "SearchResultViewController.h"

@implementation SearchResultViewController
-(void)viewDidLoad{
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell ==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
@end
