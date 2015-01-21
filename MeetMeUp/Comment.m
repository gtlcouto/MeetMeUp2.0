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

    self.memberName = comments[@"member_name"];
    self.memberId = comments[@"member_id"];
    self.comment = comments[@"comment"];
    self.time = comments[@"time"];

    return self;


}
@end
