//
//  NetController.h
//  ForgetMeNot
//
//  Created by Josh Kahl on 2/3/15.
//  Copyright (c) 2015 Josh Kahl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Accounts/Accounts.h>
#import <Social/Social.h>

@interface NetController : NSObject
{
  NSString *property;
  ACAccount *userTwitterAccount;
  NSOperationQueue *imageQueue;
}

@property (nonatomic, retain) NSString *property;

+(instancetype)sharedManager;

@end
