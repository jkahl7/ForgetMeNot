//
//  Queue.m
//  ForgetMeNot
//
//  Created by Josh Kahl on 2/2/15.
//  Copyright (c) 2015 Josh Kahl. All rights reserved.
//

#import "Queue.h"

@implementation Queue

-(id)init
{
  if (self = [super init])
  {
    queue = [[NSMutableArray alloc] init];
    personA = [[NSString alloc] init];
    personB = [NSString new];
    personC = [NSString new];
  }
  return self;
}

-(void)deQueue
{
  if (queue.count != 0)
  {
    [queue removeObjectAtIndex:0];
  }
}

-(instancetype)enQueue:(NSString *)person
{
  if (queue)
  {
    [queue addObject:person];
  }
  return 0;
}

@end
