//
//  Stack.h
//  ForgetMeNot
//
//  Created by Josh Kahl on 2/2/15.
//  Copyright (c) 2015 Josh Kahl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Stack : NSObject
{
  
  NSMutableArray *stack;
  NSString *personA, *personB, *personC;
  int arrayIndex;
}
@property (strong, nonatomic) NSArray *arrayPtr;

-(void)push:(NSString *)character;
-()pop;
-(id)peek;
-(void)peopleMaker; // populates people

//forward declration of the stack mutable array data structure


@end
