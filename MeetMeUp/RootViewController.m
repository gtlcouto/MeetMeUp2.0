//
//  ViewController.m
//  MeetMeUp
//
//  Created by Gustavo Couto on 2015-01-19.
//  Copyright (c) 2015 Gustavo Couto. All rights reserved.
//

#import "RootViewController.h"
#import "DetailViewController.h"
#import "MeetUp.h"
#import "Parser.h"

@interface RootViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, ParserDelegate>

@property (nonatomic)  NSArray * meetUpsArray;
@property (nonatomic)  NSMutableArray * meetUpObjArray;
@property NSDictionary * meetUpsDictionary;
@property NSDictionary * meetUpDictionary;
@property Parser * parser;


@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *tableSearchBar;

@property MeetUp * currentMeetUp;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [MeetUp getMeetUpsWithString:self.tableSearchBar.text withCompletion:^(NSArray *array) {
        self.meetUpObjArray = [array mutableCopy];
    }];

}
#pragma mark - overload setter
-(void)setMeetUpObjArray:(NSMutableArray *)meetUpObjArray
{
    _meetUpObjArray = meetUpObjArray;
    [self.tableView reloadData];
}

#pragma mark - Delegate Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.meetUpObjArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    MeetUp * myMeetUp = [[MeetUp alloc] initWithDictionary:[self.meetUpObjArray objectAtIndex:indexPath.row]];
    cell.textLabel.text = myMeetUp.name;
    cell.detailTextLabel.text = myMeetUp.address;

    return cell;
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [MeetUp getMeetUpsWithString:self.tableSearchBar.text withCompletion:^(NSArray *array) {
        self.meetUpObjArray = [array mutableCopy];
    }];
}


#pragma mark - Segue Methods

//send necessary informaton to detailViewController
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

    if ([segue.identifier isEqualToString:@"detailSegue"])
    {
        DetailViewController *detailVC = segue.destinationViewController;

        NSIndexPath *myIndexPath = [self.tableView
                                    indexPathForSelectedRow];
        self.currentMeetUp = [[MeetUp alloc] initWithDictionary:[self.meetUpObjArray objectAtIndex:myIndexPath.row]];

        detailVC.currentMeetUp = self.currentMeetUp;
    }
}

@end
