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
    if (self) {
        self.name = member[@"name"];
        self.memberId = [NSString stringWithFormat:@"%@", member[@"id"]];
        self.country = member[@"country"];
        self.city = member[@"city"];
        self.state = member[@"state"];
    }
    return self;
}

+(void)getMemberByMemberId:(NSNumber *)memberId withCompletion:(void(^)(Member * member))complete
{

        NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.meetup.com/2/member/%@?&sign=true&photo-host=public&page=20&key=3a4d77271f957474a481b6c2c5a4a13", memberId]];
        NSURLRequest * request = [NSURLRequest requestWithURL:url];
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            NSDictionary * member = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            Member * myMember = [[Member alloc] initWithDictionary:member];
            complete(myMember);
            
            
        }];
    
}
@end
