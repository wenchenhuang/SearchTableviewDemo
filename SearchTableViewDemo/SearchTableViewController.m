//
//  SearchTableViewController.m
//  SearchTableViewDemo
//
//  Created by huangwenchen on 15/3/25.
//  Copyright (c) 2015年 huangwenchen. All rights reserved.
//

#import "SearchTableViewController.h"
#import "SearchResultViewController.h"
#import "DetailViewController.h"
@interface SearchTableViewController()<UISearchBarDelegate,UISearchResultsUpdating>
@property (strong,nonatomic)NSMutableArray * dataArray;
@property (strong,nonatomic)UISearchController * searchcontroller;
@property (strong,nonatomic)SearchResultViewController * resultViewController;
@end

@implementation SearchTableViewController
- (IBAction)delete:(id)sender {
    if (self.tableView.isEditing) {
        [self.tableView beginUpdates];
        NSArray * selectRows = [self.tableView indexPathsForSelectedRows];
        NSMutableIndexSet * indexpaths = [[NSMutableIndexSet alloc] init];
        for(NSIndexPath * path in selectRows){
            [indexpaths addIndex:path.row];
        }
        [self.dataArray removeObjectsAtIndexes:indexpaths];
        [self.tableView deleteRowsAtIndexPaths:selectRows withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableView endUpdates];
        [self.tableView setEditing:NO animated:YES];
    }else{
        [self.tableView setEditing:YES animated:NO];
    }
}

-(void)viewDidLoad{
    self.dataArray = [[NSMutableArray alloc] initWithArray:@[@"jack",@"lucy",@"tom",@"truck",@"lily"]];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.resultViewController = [[SearchResultViewController alloc] init];
    self.searchcontroller = [[UISearchController alloc] initWithSearchResultsController:self.resultViewController];
    self.searchcontroller.searchBar.delegate = self;
    self.resultViewController.tableView.delegate = self;
    [self.searchcontroller.searchBar sizeToFit];
    self.searchcontroller.searchResultsUpdater = self;
    self.searchcontroller.dimsBackgroundDuringPresentation = NO;
    self.definesPresentationContext = YES;
    
    self.tableView.tableHeaderView = self.searchcontroller.searchBar;
    self.tableView.allowsMultipleSelectionDuringEditing = YES;
}
#pragma mark - search bar delegate
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
}
#pragma mark - UISearchResultUpdating
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    NSString * searchtext = searchController.searchBar.text;
    NSArray * searchResults = [self.dataArray filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        BOOL result = NO;
        if ([(NSString *)evaluatedObject hasPrefix:searchtext]) {
            result = YES;
        }
        return result;
    }]];
    SearchResultViewController *tableController = (SearchResultViewController *)self.searchcontroller.searchResultsController;
    tableController.dataArray = searchResults;
    [tableController.tableView reloadData];

}

#pragma mark - tableview datasource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.isEditing) {
        return;
    }
    if (tableView == self.tableView) {
        NSString * name = self.dataArray[indexPath.row];
        DetailViewController * detailvc = [self.storyboard instantiateViewControllerWithIdentifier:@"detailvc"];
        detailvc.name = name;
        [self.navigationController pushViewController:detailvc animated:YES];
    }else if(tableView == self.resultViewController.tableView){
        NSString * name = self.resultViewController.dataArray[indexPath.row];
        DetailViewController * detailvc = [self.storyboard instantiateViewControllerWithIdentifier:@"detailvc"];
        detailvc.name = name;
        [self.navigationController pushViewController:detailvc animated:YES];
    }
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if (tableView == self.tableView) {
            [self.dataArray removeObjectAtIndex:indexPath.row];
            [self.tableView beginUpdates];
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            [self.tableView endUpdates];
        }
    }
}
@end
