//
//  MemberViewController.m
//  MeetMeUp
//
//  Created by Gustavo Couto on 2015-01-19.
//  Copyright (c) 2015 Gustavo Couto. All rights reserved.
//

#import "MemberViewController.h"
#import "Member.h"
#import "Parser.h"

@interface MemberViewController ()<ParserDelegate>

@property NSMutableArray * memberObjArray;
@property (nonatomic)  Member * currentMember;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *countryLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property Parser * parser;

@end

@implementation MemberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentMember = [Member new];
    [Member getMemberByMemberId:self.memberId withCompletion:^(Member *member) {
        self.currentMember = member;
    }];
}
#pragma overload setters
-(void)setCurrentMember:(Member *)currentMember
{
    _currentMember = currentMember;
    [self reloadUI];

}


#pragma mark - Helper Methods

-(void)reloadUI
{
    self.idLabel.text = self.currentMember.memberId;
    self.nameLabel.text = self.currentMember.name;
    self.countryLabel.text = self.currentMember.country;
    self.stateLabel.text = self.currentMember.state;
    self.cityLabel.text = self.currentMember.city;
}

@end
