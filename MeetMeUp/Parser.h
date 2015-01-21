//
//  Parser.h
//  MeetMeUp
//
//  Created by Gustavo Couto on 2015-01-19.
//  Copyright (c) 2015 Gustavo Couto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Member.h"

@protocol ParserDelegate <NSObject>
    
@optional
-(void)fetchedMeetups:(NSMutableArray *)returnArray;
-(void)fetchedComments:(NSMutableArray *)returnArray;
-(void)fetchedMember:(Member *)returnMember;

@end

@interface Parser : NSObject

-(void)getMeetUpsWithString:(NSString *)string;
-(void)getCommentsWithEventId:(NSNumber *)eventId;
-(void)getMemberByMemberId:(NSNumber *)memberId;

@property (nonatomic, weak) id<ParserDelegate> delegate;

@end
