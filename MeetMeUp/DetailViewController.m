//
//  DetailViewController.m
//  MeetMeUp
//
//  Created by Gustavo Couto on 2015-01-19.
//  Copyright (c) 2015 Gustavo Couto. All rights reserved.
//

#import "DetailViewController.h"
#import "WebViewController.h"
#import "MemberViewController.h"
#import "Comment.h"

@interface DetailViewController () <UITableViewDataSource, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *rsvpYesLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UITextView *descTextView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSMutableArray * commentsObjArray;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self reloadUI];
    [self fetchJsonFromURL];

}

#pragma mark - Delegate Methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.commentsObjArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"commentCell"];
    Comment * comment;
    comment = [self.commentsObjArray objectAtIndex:indexPath.row];
    cell.textLabel.text = comment.memberName;
    cell.detailTextLabel.text = comment.comment;

    return cell;
}

#pragma mark - Helper Methods

-(void)reloadUI
{
    self.nameLabel.text = self.currentMeetUp.name;
    self.rsvpYesLabel.text = [NSString stringWithFormat:@"%@", self.currentMeetUp.rsvpCount ];
    self.addressLabel.text = self.currentMeetUp.address;
    self.descTextView.text = self.currentMeetUp.desc;
}

-(void)fetchJsonFromURL
{
    self.commentsObjArray = [NSMutableArray new];
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.meetup.com/2/event_comments?&sign=true&photo-host=public&event_id=%@&page=20&key=3a4d77271f957474a481b6c2c5a4a13", self.currentMeetUp.eventId]];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSDictionary * commentsDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSArray * commentsArray = commentsDictionary[@"results"];

        for (NSDictionary * comment in commentsArray)
        {
            Comment * myComment = [Comment new];
            myComment.memberName = comment[@"member_name"];
            myComment.memberId = comment[@"member_id"];
            myComment.comment = comment[@"comment"];
            myComment.time = comment[@"time"];


            [self.commentsObjArray addObject:myComment];
        }

        [self.tableView reloadData];
        
    }];
    
}





#pragma mark - Segue Methods
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier  isEqual: @"toMemberSegue"]) {
        MemberViewController * mvc = segue.destinationViewController;
        NSIndexPath * myIndexPath = [self.tableView
                                    indexPathForSelectedRow];
        Comment * comment =  [self.commentsObjArray objectAtIndex:myIndexPath.row];
        
        mvc.memberId = comment.memberId;

    } else {
        WebViewController * vc = segue.destinationViewController;
        vc.currentMeetUp = self.currentMeetUp;
    }
    
}


@end
