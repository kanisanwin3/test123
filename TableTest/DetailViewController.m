//
//  DetailViewController.m
//  TableTest
//
//  Created by 中島 克己 on 2014/06/05.
//  Copyright (c) 2014年 katsumi nakashima. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

-(void)loadView{
    self.view =[[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
}



- (void)viewDidLoad
{
    [super viewDidLoad];
   NSLog(@"%@" ,self.detail);
    
    self.detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, 320, 40)];
    [self.detailLabel setBackgroundColor:[UIColor whiteColor]];
    self.detailLabel.textAlignment = NSTextAlignmentCenter;
    self.detailLabel.text = self.detail;

    
    
    
    [self.view addSubview:self.detailLabel];


    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
