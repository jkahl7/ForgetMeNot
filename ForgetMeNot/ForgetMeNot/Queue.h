//
//  Queue.h
//  ForgetMeNot
//
//  Created by Josh Kahl on 2/2/15.
//  Copyright (c) 2015 Josh Kahl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Queue : NSObject
{
  NSMutableArray *queue;
  NSString *personA, *personB, *personC;
}
-(void)deQueue;
-(instancetype)enQueue:(NSString *)person;
@end

