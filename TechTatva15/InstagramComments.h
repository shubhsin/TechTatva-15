//
//  InstagramComments.h
//  TechTatva15
//
//  Created by Sushant Gakhar on 17/09/15.
//  Copyright (c) 2015 AppDev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InstagramComments : NSObject

@property (strong, nonatomic) NSString *instaComments;

- (id) initWithDictionary : (NSDictionary *) dict;

@end
