//
//  Coupon.h
//  TableTest
//
//  Created by 中島 克己 on 2014/06/03.
//  Copyright (c) 2014年 katsumi nakashima. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Coupon : NSObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *detail;
@property (nonatomic, retain) UIImage *img;

-(id)initWithName:(NSString*)name imgParse:(NSString*)url;
-(NSString*)detail;


@end
