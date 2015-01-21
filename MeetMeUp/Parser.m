//
//  Parser.m
//  MeetMeUp
//
//  Created by Gustavo Couto on 2015-01-19.
//  Copyright (c) 2015 Gustavo Couto. All rights reserved.
//

#import "Parser.h"
#import "MeetUp.h"
#import "Comment.h"

@implementation Parser

-(void)getMeetUpsWithString:(NSString *)string
{
    NSMutableArray * meetUpObjArray = [NSMutableArray new];
    NSURL * url;
    if (string || [string  isEqual: @""]) {
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
        //DELEGATE
        [self.delegate fetchedMeetups:meetUpObjArray];

        
    }];
}

-(void)getCommentsWithEventId:(NSNumber *)eventId
{
    NSMutableArray * commentsObjArray = [NSMutableArray new];
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.meetup.com/2/event_comments?&sign=true&photo-host=public&event_id=%@&page=20&key=3a4d77271f957474a481b6c2c5a4a13", eventId]];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
    {
        NSDictionary * commentsDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSArray * commentsArray = commentsDictionary[@"results"];

        for (NSDictionary * comment in commentsArray)
        {
            Comment * myComment = [[Comment alloc] initWithDictionary:comment];
            [commentsObjArray addObject:myComment];
        }

        [self.delegate fetchedComments:commentsObjArray];
        
    }];
    
}

-(void)getMemberByMemberId:(NSNumber *)memberId
{
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.meetup.com/2/member/%@?&sign=true&photo-host=public&page=20&key=3a4d77271f957474a481b6c2c5a4a13", memberId]];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSDictionary * member = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        Member * myMember = [[Member alloc] initWithDictionary:member];
        [self.delegate fetchedMember:myMember];

        
    }];
    
}



@end
