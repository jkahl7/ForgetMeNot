//
//  NetController.m
//  ForgetMeNot
//
//  Created by Josh Kahl on 2/3/15.
//  Copyright (c) 2015 Josh Kahl. All rights reserved.
//

#import "NetController.h"
#import <Accounts/Accounts.h>

//singleton NetController is refrenced via NetController *sharedNetController = [NetController sharedNetController];

@implementation NetController

@synthesize property;

+ (instancetype)sharedManager
{
  // *sharedNetController is initilized only once
  static NetController *sharedNetController = nil;
  static dispatch_once_t onceToken;  //ensures that sharedNetController is only created once
  dispatch_once(&onceToken, ^{  
    sharedNetController = [[self alloc] init];
  });
  return sharedNetController;
}

- (instancetype) init
{
  if (self = [super init])
  {
    property           = @"default property value";
    userTwitterAccount = [ACAccount new];
    imageQueue         = [NSOperationQueue new];
  }
  return self;
}

// func fetchHomeTimeLine( completionHandler:(tweet:[Tweet]?, errorString:String?) -> Void)
// void fetchLocalTweets(int x, char* v)
// -(void)fetchblahbla:(NSString *)string andCompletionHandler:(void (^)(NSString *))completionHandler { stuff }

-(void)fetchHomeLocalTweets:(void (^)(NSString *))completionHandler
{
  
}



@end
