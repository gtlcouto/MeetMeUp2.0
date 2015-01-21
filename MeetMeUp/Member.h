//
//  Member.h
//  MeetMeUp
//
//  Created by Gustavo Couto on 2015-01-19.
//  Copyright (c) 2015 Gustavo Couto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Member : NSObject

@property NSString * name;
@property NSString * memberId;
@property NSString * country;
@property NSString * city;
@property NSString * state;


-(instancetype)initWithDictionary:(NSDictionary *)member;
@end
