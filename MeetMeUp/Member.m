//
//  Member.m
//  MeetMeUp
//
//  Created by Gustavo Couto on 2015-01-19.
//  Copyright (c) 2015 Gustavo Couto. All rights reserved.
//

#import "Member.h"

@implementation Member

-(instancetype)initWithDictionary:(NSDictionary *)member
{
    self = [super init];

    self.name = member[@"name"];
    self.memberId = [NSString stringWithFormat:@"%@", member[@"id"]];
    self.country = member[@"country"];
    self.city = member[@"city"];
    self.state = member[@"state"];

    return self;
}
@end
