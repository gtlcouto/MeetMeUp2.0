//
//  Comment.m
//  MeetMeUp
//
//  Created by Gustavo Couto on 2015-01-19.
//  Copyright (c) 2015 Gustavo Couto. All rights reserved.
//

#import "Comment.h"


@implementation Comment


-(instancetype)initWithDictionary:(NSDictionary *)comments
{
    self = [super init];
    if (self) {

        self.memberName = comments[@"member_name"];
        self.memberId = comments[@"member_id"];
        self.comment = comments[@"comment"];
        self.time = comments[@"time"];
    }
    return self;


}

+(void)getCommentsWithEventId:(NSNumber *)eventId withCompletion:(void(^)(NSArray * commentsArray))complete
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
         complete(commentsObjArray);
         
     }];

}
@end
