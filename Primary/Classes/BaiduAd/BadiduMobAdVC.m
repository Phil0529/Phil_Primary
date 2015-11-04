//
//  BadiduMobAdVC.m
//  Primary
//
//  Created by Phil Xhc on 15/10/29.
//  Copyright © 2015年 Xhc. All rights reserved.
//

#import "BadiduMobAdVC.h"
#import "BaiduMobFirstVC.h"
#import "BaiduMobSecondVC.h"


static NSString *BaiduMobAdTbViewCellReuseIdentifier = @"BaiduMobAdTbViewCellReuseIdentifier";
@interface BadiduMobAdVC ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tbView;
}
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation BadiduMobAdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self philInitPageBMAVC];
    [self philInitUIBMAVC];
}
- (void)philInitPageBMAVC{
    [self.view setBackgroundColor:BACKGROUND_COLOR];
    //使⽤嵌⼊⼲告的⽅法实例。
    
}

- (NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray = @[@"banner",@"Table Screen"];
    }
    return _dataArray;
}
- (void)philInitUIBMAVC{
    _tbView = [[UITableView alloc] initWithFrame:CGRectMake(0.f, 0.f, SCREEN_WIDTH, SCREEN_HEIGHT - NAVBAR_HEIGHT - STATUSBAR_HEIGHT) style:UITableViewStylePlain];
    _tbView.delegate = self;
    _tbView.dataSource = self;
    [self.view addSubview:_tbView];
}


#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:BaiduMobAdTbViewCellReuseIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:BaiduMobAdTbViewCellReuseIdentifier];
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:{
            BaiduMobFirstVC *vc = [[BaiduMobFirstVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:{
            BaiduMobSecondVC *vc = [[BaiduMobSecondVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;

            
        default:
            break;
    }
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
