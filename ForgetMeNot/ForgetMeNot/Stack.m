//
//  Stack.m
//  ForgetMeNot
//
//  Created by Josh Kahl on 2/2/15.
//  Copyright (c) 2015 Josh Kahl. All rights reserved.
//

#import "Stack.h"

@implementation Stack

-(id)init
{
  if (self = [super init])
  {
    stack = [[NSMutableArray alloc] init];
    personA = [[NSString alloc] init];
    personB = [[NSString alloc] init];
    personC = [[NSString alloc] init];
    arrayIndex = 0;
  }
  return self;
}

-(void)push:(NSString *)character
{
  [stack addObject:character];
  
}

-(id)pop
{
  if (stack.count != 0)
  {
    [stack removeLastObject];
  }
  return 0;
}

-(id)peek
{
  if(stack.count != 0)
  {
    return stack[arrayIndex];
  }
  return nil;
}

-(void)peopleMaker
{
  personA = @"Sanford";
  personB = @"Dr.Venkman";
  personC = @"Mulder";
}

@end






