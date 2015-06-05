//
//  DetailViewController.m
//  SearchTableViewDemo
//
//  Created by huangwenchen on 15/3/29.
//  Copyright (c) 2015年 huangwenchen. All rights reserved.
//

#import "DetailViewController.h"
@interface DetailViewController()
@property (weak, nonatomic) IBOutlet UILabel *namelabel;

@end
@implementation DetailViewController
-(void)setName:(NSString *)name{
    _name = name;
    self.namelabel.text  =name;
}
-(void)viewWillAppear:(BOOL)animated{
    self.namelabel.text = self.name;
}
@end
