//
//  Comment.h
//  MeetMeUp
//
//  Created by Gustavo Couto on 2015-01-19.
//  Copyright (c) 2015 Gustavo Couto. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Comment : NSObject

@property NSNumber * memberId;
@property NSString * memberName;
@property NSString * comment;
@property NSDate * time;

-(instancetype)initWithDictionary:(NSDictionary *)comments;

//-(void)getCommentsWithEventId:(NSNumber *)eventId;
+(void)getCommentsWithEventId:(NSNumber *)eventId withCompletion:(void(^)(NSArray * commentsArray))complete;

@end
