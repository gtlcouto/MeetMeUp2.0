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

@interface RootViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property NSArray * meetUpsArray;
@property NSMutableArray * meetUpObjArray;
@property NSDictionary * meetUpsDictionary;
@property NSDictionary * meetUpDictionary;


@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *tableSearchBar;

@property MeetUp * currentMeetUp;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [self fetchJsonFromURL];

}

#pragma mark - Delegate Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.meetUpsArray.count;
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
    [self fetchJsonFromURL];
}


#pragma mark - Helper Methods

-(void)fetchJsonFromURL
{
    self.meetUpObjArray = [NSMutableArray new];
    NSURL * url;
    if (!self.tableSearchBar.text || [self.tableSearchBar.text  isEqual: @""]) {
        url = [NSURL URLWithString:@"https://api.meetup.com/2/open_events.json?zip=60604&text=mobile&time=,1w&key=3a4d77271f957474a481b6c2c5a4a13"];
    }else
    {
        url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.meetup.com/2/open_events.json?zip=60604&text=%@&time=,1w&key=3a4d77271f957474a481b6c2c5a4a13", self.tableSearchBar.text]];
    }
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        self.meetUpsDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        self.meetUpsArray = self.meetUpsDictionary[@"results"];

        for (NSDictionary * meetUp in self.meetUpsArray)
        {
            MeetUp * myMeetUp = [MeetUp new];
            myMeetUp.name = meetUp[@"name"];
            myMeetUp.desc = meetUp[@"description"];
            myMeetUp.rsvpCount = meetUp[@"yes_rsvp_count"];
            NSDictionary * venue = meetUp[@"venue"];
            myMeetUp.address = venue[@"address_1"];
            myMeetUp.eventUrl = meetUp[@"event_url"];
            myMeetUp.eventId = meetUp[@"id"];


            [self.meetUpObjArray addObject:myMeetUp];
        }

        [self.tableView reloadData];

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
        self.currentMeetUp = [self.meetUpObjArray objectAtIndex:myIndexPath.row];

        detailVC.currentMeetUp = self.currentMeetUp;
    }
}

@end
