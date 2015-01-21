//
//  MeetUp.m
//  MeetMeUp
//
//  Created by Gustavo Couto on 2015-01-19.
//  Copyright (c) 2015 Gustavo Couto. All rights reserved.
//

#import "MeetUp.h"

@implementation MeetUp

-(instancetype)initWithDictionary:(NSDictionary *)meetUp
{
    self = [super init];

    self.name = meetUp[@"name"];
    self.desc = meetUp[@"description"];
    self.rsvpCount = meetUp[@"yes_rsvp_count"];
    NSDictionary * venue = meetUp[@"venue"];
    self.address = venue[@"address_1"];
    self.eventUrl = meetUp[@"event_url"];
    self.eventId = meetUp[@"id"];
    
    return self;

}
@end
