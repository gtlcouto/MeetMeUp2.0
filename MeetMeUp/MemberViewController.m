//
//  MemberViewController.m
//  MeetMeUp
//
//  Created by Gustavo Couto on 2015-01-19.
//  Copyright (c) 2015 Gustavo Couto. All rights reserved.
//

#import "MemberViewController.h"
#import "Member.h"

@interface MemberViewController ()

@property NSMutableArray * memberObjArray;
@property Member * currentMember;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *countryLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;

@end

@implementation MemberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentMember = [Member new];
    [self fetchJsonFromURL];
}

#pragma mark - Helper Methods
-(void)fetchJsonFromURL
{
    self.memberObjArray = [NSMutableArray new];
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.meetup.com/2/member/%@?&sign=true&photo-host=public&page=20&key=3a4d77271f957474a481b6c2c5a4a13", self.memberId]];

    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSDictionary * member = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];


        self.currentMember.name = member[@"name"];
        self.currentMember.memberId = [NSString stringWithFormat:@"%@", member[@"id"]];
        self.currentMember.country = member[@"country"];
        self.currentMember.city = member[@"city"];
        self.currentMember.state = member[@"state"];

        [self reloadUI];
        
    }];
    
}

-(void)reloadUI
{
    self.idLabel.text = self.currentMember.memberId;
    self.nameLabel.text = self.currentMember.name;
    self.countryLabel.text = self.currentMember.country;
    self.stateLabel.text = self.currentMember.state;
    self.cityLabel.text = self.currentMember.city;
}

@end
