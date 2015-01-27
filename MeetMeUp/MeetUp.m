//
//  MeetUp.m
//  MeetMeUp
//
//  Created by Gustavo Couto on 2015-01-19.
//  Copyright (c) 2015 Gustavo Couto. All rights reserved.
//

#import "MeetUp.h"

@implementation MeetUp

- (instancetype)initWithDictionary:(NSDictionary *)meetUp
{
    self = [super init];
    if (self)
    {
        self.name = meetUp[@"name"];
        self.desc = meetUp[@"description"];
        self.rsvpCount = meetUp[@"yes_rsvp_count"];
        NSDictionary * venue = meetUp[@"venue"];
        self.address = venue[@"address_1"];
        self.eventUrl = meetUp[@"event_url"];
        self.eventId = meetUp[@"id"];
    }
    return self;

}

+ (void)getMeetUpsWithString:(NSString *)string withCompletion:(void(^)(NSArray * array))complete
{
    NSMutableArray * meetUpObjArray = [NSMutableArray new];
    NSURL * url = [NSURL URLWithString:string];
    if (!string || [string  isEqual: @""]) {
        url = [NSURL URLWithString:@"https://api.meetup.com/2/open_events.json?zip=60604&text=mobile&time=,1w&key=3a4d77271f957474a481b6c2c5a4a13"];
    }else
    {
        url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.meetup.com/2/open_events.json?zip=60604&text=%@&time=,1w&key=3a4d77271f957474a481b6c2c5a4a13", string]];
    }
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSDictionary * meetUpsDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSArray * meetUpsArray = [[NSArray alloc] init];

        meetUpsArray = meetUpsDictionary[@"results"];

        for (NSDictionary * meetUp in meetUpsArray)
        {
            MeetUp * myMeetUp = [[MeetUp alloc] initWithDictionary:meetUp];
            [meetUpObjArray addObject:myMeetUp];
        }
        complete(meetUpsArray);

        
    }];
    
}
@end
