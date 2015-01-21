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

@property NSArray * meetUpsArray;
@property NSMutableArray * meetUpObjArray;
@property NSDictionary * meetUpsDictionary;
@property NSDictionary * meetUpDictionary;
@property Parser * parser;


@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *tableSearchBar;

@property MeetUp * currentMeetUp;

@end

@implementation RootViewController

- (void)viewDidLoad {

    self.parser = [Parser new];
    self.parser.delegate = self;
    [self.parser getMeetUpsWithString:@""];

}

#pragma mark - Delegate Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.meetUpObjArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    MeetUp * myMeetUp;
    myMeetUp = [self.meetUpObjArray objectAtIndex:indexPath.row];
    cell.textLabel.text = myMeetUp.name;
    cell.detailTextLabel.text = myMeetUp.address;

    return cell;
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.parser getMeetUpsWithString:self.tableSearchBar.text];
}


#pragma mark - Custom Delegate

-(void)fetchedMeetups:(NSMutableArray *)returnArray
{
    self.meetUpObjArray = returnArray;
    [self.tableView reloadData];
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
        self.currentMeetUp = [self.meetUpObjArray objectAtIndex:myIndexPath.row];

        detailVC.currentMeetUp = self.currentMeetUp;
    }
}

@end
