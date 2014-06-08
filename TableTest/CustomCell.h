//
//  CustomCell.h
//  TableTest
//
//  Created by 中島 克己 on 2014/06/03.
//  Copyright (c) 2014年 katsumi nakashima. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *Cell;

@interface CustomCell : UITableViewCell{

}
@property (nonatomic, retain) UILabel *titleLabel;  //タイトルラベル
@property (nonatomic, retain) UILabel *detailLabel;  //説明文
@property (nonatomic, retain) UIImageView *urlImageView; //画像



@end
