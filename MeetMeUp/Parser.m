//
//  parser.m
//  MeetMeUp
//
//  Created by Gustavo Couto on 2015-01-19.
//  Copyright (c) 2015 Gustavo Couto. All rights reserved.
//

#import "Parser.h"
#import "MeetUp.h"

@implementation Parser

-(NSMutableArray *)getMeetUpsByString:(NSString *)search
{
    NSMutableArray *meetUpObjArray = [NSMutableArray new];
    NSURL * url;
    if (!search || [search  isEqual: @""]) {
        url = [NSURL URLWithString:@"https://api.meetup.com/2/open_events.json?zip=60604&text=mobile&time=,1w&key=3a4d77271f957474a481b6c2c5a4a13"];
    }else
    {
        url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.meetup.com/2/open_events.json?zip=60604&text=%@&time=,1w&key=3a4d77271f957474a481b6c2c5a4a13", search]];
    }
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSDictionary * meetUpsDictionary;
        meetUpsDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
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
        return meetUpObjArray;

        [self.tableView reloadData];
        
    }];
    
}

@end
