//
//  Coupon.m
//  TableTest
//
//  Created by 中島 克己 on 2014/06/03.
//  Copyright (c) 2014年 katsumi nakashima. All rights reserved.
//

#import "Coupon.h"

@interface Coupon (){
}

@end

@implementation Coupon

-(id)initWithName:(NSString*)name imgParse:(NSString *)url{
    self = [super init];    //initを継承
    if (self) { //もし真なら
        self.name = name;   //受け取った文字列1をself.nameに代入
        self.detail = [NSString stringWithFormat:@"これは%@のクーポンです。", self.name];
        NSData *urlData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]]; //受け取った文字列を元にURL変数を生成
        self.img = [[UIImage alloc] initWithData:urlData]; //URL変数を元にUIImageを作成してself.imgに代入
    }
    return self;
}







@end
