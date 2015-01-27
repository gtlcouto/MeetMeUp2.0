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
#import "Parser.h"

@interface DetailViewController () <UITableViewDataSource, UITableViewDataSource, ParserDelegate>
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *rsvpYesLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UITextView *descTextView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic)  NSMutableArray * commentsObjArray;
@property Parser * parser;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self reloadUI];
    [Comment getCommentsWithEventId:self.currentMeetUp.eventId withCompletion:^(NSArray *commentsArray) {
        self.commentsObjArray = [commentsArray mutableCopy];
    }];


}
#pragma mark - Setter Methods

-(void)setCommentsObjArray:(NSMutableArray *)commentsObjArray
{
    _commentsObjArray = commentsObjArray;
    [self.tableView reloadData];
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
