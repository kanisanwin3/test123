//
//  ViewController.m
//  TableTest
//
//  Created by 中島 克己 on 2014/06/03.
//  Copyright (c) 2014年 katsumi nakashima. All rights reserved.
//

#import "ViewController.h"
#import "Coupon.h"
#import "CustomCell.h"
#import "DetailViewController.h"
#import "FMDatabase.h"

@interface ViewController  ()<UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>{
    NSMutableArray *coupons;
}

@property (nonatomic, retain) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setTitle:@"aaa"];
    
    //barのボタン
    UIBarButtonItem *addButton =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose  // スタイルを指定
                                                                              target:self  // デリゲートのターゲットを指定
                                                                              action:@selector(pushButton:)  // ボタンが押されたときに呼ばれるメソッドを指定
     ];
    self.navigationItem.rightBarButtonItem = addButton;
    
//    UIBarButtonItem *deleteButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop
//                                                                                  target:self
//                                                                                  action:@selector(deleteButton)
//    ];
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    //DB
    
    
    
    //初期値のcouponsを作る処理
    //変数coupon1の.nameに@""を入れた状態で生成
    Coupon *coupon1 = [[Coupon alloc] initWithName:@"USJ"
                                          imgParse:@"http://icon.nimg.jp/community/s/240/co2403382.jpg"];
    
    Coupon *coupon2 = [[Coupon alloc] initWithName:@"Disney"
                                          imgParse:@"http://hhl-classy.blog.eonet.jp/photos/uncategorized/2010/10/14/photo.jpg"];
    
    coupons = [[NSMutableArray alloc] initWithObjects:coupon1,coupon2, nil];


    self.tableView = [[UITableView alloc] initWithFrame:[self.view bounds]];
    [self.tableView registerClass:[CustomCell class] forCellReuseIdentifier:@"Cell"];


    self.tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];

}

//UITableViewのSetEditingメソッドを追加
-(void)setEditing:(BOOL)editing animated:(BOOL)animated{
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:animated];
}




//右上ボタンおしたらどうするか
-(void)pushButton:(id)sender{

    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"新規クーポン作成"
                                                    message:@"名前と内容を入力してください。"
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"OK", nil
    ];
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 88)];
    UITextField *textField1 = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, view1.bounds.size.width, view1.bounds.size.height/2)];
    UITextField *textField2 = [[UITextField alloc] initWithFrame:CGRectMake(0, view1.bounds.size.height/2, view1.bounds.size.width, view1.bounds.size.height/2)];
    textField1.backgroundColor = [UIColor whiteColor];
    textField2.backgroundColor = [UIColor whiteColor];
    textField1.placeholder = @"name";
    textField2.placeholder = @"detail";
    
    [view1 addSubview:textField1];
    [view1 addSubview:textField2];
    
    [alert setValue:view1 forKey:@"accessoryView"];
    
    [alert show];
    
    
}

//定数　CANCEL = 0
#define CANCEL 0

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != CANCEL) {
        UIView *view1 = [alertView valueForKey:@"accessoryView"];
        NSLog(@"%@" ,view1.subviews);
        
        NSString *name, *detail;
        name = detail = nil;
        
        for (int i = 0; i < view1.subviews.count; i++) {
            
            
            NSString *tempText = [(UITextField *)[view1.subviews objectAtIndex:i] text];
            
            switch (i) {
                case 0:
                    name = tempText;
                    break;
                case 1:
                    detail = tempText;
                    break;
                    
                default:
                    break;
            }
        }
        if ((name && ![name isEqualToString:@""]) && (detail && ![detail isEqualToString:@""])) {
            Coupon *coupon3 = [[Coupon alloc] initWithName:name imgParse:@""];
            coupon3.detail = detail;
            
            [coupons addObject:coupon3];
            [self.tableView reloadData];
        }
    }
}




//Deleteボタンが押されたら
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld",(long) indexPath.row);
    [coupons removeObjectAtIndex:indexPath.row];
    [self.tableView reloadData];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return coupons.count;   //セルの数をcoupons配列の長さで指定
}


//タップしたときの処理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"%ld",(long)indexPath.row);
    
    DetailViewController *dvc = [[DetailViewController alloc] init];
    
    Coupon *coupon = [coupons objectAtIndex:indexPath.row];
    dvc.title = coupon.name;
    dvc.detail = coupon.detail;
    

    
    [self.navigationController pushViewController:dvc animated:YES];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80; //セルの縦幅
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Couponクラスで生成した変数couponに配列couponsの特定の番号のオブジェクトを代入
    Coupon *coupon = [coupons objectAtIndex:indexPath.row];
    
    //static（静的変数）
    static NSString *cellIdentifer = @"Cell";
    
    //使用可能なセルを取得
    CustomCell *cell = (CustomCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifer]; //セルの再利用系メソッド
    
    //registerClass:forCellReuseIdentifier:メソッドを使った場合はこのチェックがいらないらしい
//    if (!cell) {
//        cell = [[CustomCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifer];
//    }
    

    
    //CustomCellクラスの各ラベルに指定されたレイアウトでテキストラベルを設置
    cell.titleLabel.text = [NSString stringWithFormat:@"%@",coupon.name];
    cell.detailLabel.text = [NSString stringWithFormat:@"%@" ,coupon.detail];
    
    //画像設置
    cell.urlImageView.image = coupon.img;
    
    
    return cell;
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
